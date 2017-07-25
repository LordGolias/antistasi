// This is a API to store generic objects, pretty much like a Python dictionary.
// How to use:
/*
    * add object: `AS_fnc_object_add(name, type, isGlobal=false)`
    * remove object: `AS_fnc_object_remove(name)`
    * set property: `AS_fnc_object_set(name, property, value)`
    * get property: `AS_fnc_object_get(name, property)`
    * del property: `AS_fnc_object_del(name, property)`

    * list of objects (see descrition in function): `AS_fnc_objects(condition=nil)`
    + list of properties of an object: `AS_fnc_object_properties(name)`

    Rules:
    1. object names must be unique and cannot start with `_`.
    2. `type` is a default property used to differentiate types of objects.
    3. `isGlobal` defines whether the object is global or local
    4. properties cannot start with `_` (reserved for the dict itself).
*/

////////////////////////////////// Getters //////////////////////////////////

// get property of objects
AS_fnc_object_get = {
    params ["_object", "_property"];
    if not (_object in (call AS_fnc_objects)) exitWith {
        diag_log format ["[AS] Error: object_get: object '%1' does not exist", _object];
    };
    private _properties = _object call AS_fnc_object_properties;
    if not (_property in _properties) exitWith {
        diag_log format ["[AS] Error: object_get: property '%1' does not exist for object '%2'. Valid properties: %3", _property, _object, _properties];
    };

    AS_objects getVariable (_object + "_" + _property)
};

// returns the object type
AS_fnc_object_type = {
    [_this, "_type"] call AS_fnc_object_get;
};

////////////////////////////////// Iterators ////////////////////////////////

// returns all objects that fulfill a certain condition, where the condition
// depends on the argument:
// * if no argument, returns all objects
// * if argument is an array, returns all objects whose type is in that array
// * if argument is a string, returns all objects whose type equals argument
// * if argument is code, returns all objects that fulfill the condition in the code
AS_fnc_objects = {
    private _objects = AS_objects getVariable "_all";
    if (typeName _this == "ARRAY") then {
        _objects = _objects select {_x call AS_fnc_object_type in _this};
    };
    if (typeName _this == "CODE") then {
        _objects = _objects select _this;
    };
    if (typeName _this == "STRING") then {
        _objects = _objects select {_x call AS_fnc_object_type == _this};
    };
    _objects
};

// returns all objects of a given type
AS_fnc_type_objects = {
    (call AS_fnc_objects) select {_x call AS_fnc_object_type == _this}
};

// returns all properties of a given object
AS_fnc_object_properties = {
    private _object = _this;
    if not (_object in (call AS_fnc_objects)) exitWith {
        diag_log format ["[AS] Error: object_properties: object '%1' does not exist", _object];
    };
    AS_objects getVariable ("_properties_" + _object)
};

////////////////////////////////// Setters ////////////////////////////////

// adds an object of a given type. The first argument must be a unique name. Second argument can be any string.
// Third argument (_isGlobal) makes the object either local or global (default is local).
AS_fnc_object_add = {
    params ["_object", "_type", ["_isGlobal", false]];
    private _objects = call AS_fnc_objects;

    if (_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_add: object '%1' already exists.", _object];
    };
    if (_object find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_add: objects cannot start with '_' but '%s' does.", _object];
    };

    _objects pushBack _object;
    AS_objects setVariable ["_all", _objects, _isGlobal];
    AS_objects setVariable ["_properties_" + _object, ["_properties"], _isGlobal];

    // _isGlobal has to be the first property set so next ones are already set correctly.
    [_object, "_isGlobal", _isGlobal] call AS_fnc_object_set;
    [_object, "_type", _type] call AS_fnc_object_set;
};

// Sets a property of an object
AS_fnc_object_set = {
    params ["_object", "_property", "_value"];

    if not (_object in (call AS_fnc_objects)) exitWith {
        diag_log format ["[AS] Error: object_set: object '%1' does not exist", _object];
    };
    if (_property find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_set: properties cannot start with '_' but '%s' does.", _property];
    };

    // when isGlobal is set itself, we need to be careful:
    private _isGlobal = false;
    if (_property == "_isGlobal") then {
        _isGlobal = _value;
    } else {
        _isGlobal = [_object, "_isGlobal"] call AS_fnc_object_get;
    };

    private _properties = _object call AS_fnc_object_properties;
    _properties pushBack _property;
    AS_objects setVariable ["_properties_" + _object, _properties, _isGlobal];
    AS_objects setVariable [_object + "_" + _property, _value, _isGlobal];
};

// deletes a property of an object
AS_fnc_object_del = {
    params ["_object", "_property"];

    if not (_object in (call AS_fnc_objects)) exitWith {
        diag_log format ["[AS] Error: object_del: object '%1' does not exist", _object];
    };
    if (_property find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_del: properties cannot start with '_' but '%s' does.", _property];
    };
    private _isGlobal = [_object, "_isGlobal"] call AS_fnc_object_get;

    private _properties = _object call AS_fnc_object_properties;
    _properties = _properties - [_property];
    AS_objects setVariable ["_properties_" + _object, _properties, _isGlobal];
    AS_objects setVariable [_object + "_" + _property, nil, _isGlobal];
};

// removes an object.
AS_fnc_object_remove = {
    private _object = _this;
    private _objects = call AS_fnc_objects;

    if !(_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_remove: object '%1' cannot be removed because it does not exist.", _object];
    };
    private _isGlobal = [_object, "_isGlobal"] call AS_fnc_object_get;

    // its properties
    {
        AS_objects setVariable ["_properties_" + _object + "_" + _x, nil, _isGlobal];
    } forEach (_object call AS_fnc_object_properties);

    // itself
    AS_objects setVariable ["all", _objects - [_object], _isGlobal];
    AS_objects setVariable ["_properties_" + _object, nil, _isGlobal];
};

AS_fnc_object_save = {
    params ["_saveName"];
    private _objects = call AS_fnc_objects;
    [_saveName, "AS_objects", _objects] call fn_SaveStat;
    {
        private _object = _x;
        private _properties = _object call AS_fnc_object_properties;
        // saves both "_" and non-"_" properties.
        {
            [_saveName, "AS_objects_" + _object + "_" + _x, [_object, _x] call AS_fnc_object_get] call fn_SaveStat;
        } forEach _properties;
    } forEach _objects;
};

AS_fnc_object_load = {
    params ["_saveName"];

    // remove all existing objects first
    {
        _x call AS_fnc_object_remove;
    } forEach (call AS_fnc_objects);

    // populate with the saved objects
    private _objects = [_saveName, "AS_objects"] call fn_LoadStat;
    {
        //
        private _object = _x;
        private _type = [_saveName, "AS_objects_" + _object + "_" + "_type"] call fn_LoadStat;
        private _isGlobal = [_saveName, "AS_objects_" + _object + "_" + "_isGlobal"] call fn_LoadStat;
        [_object, _type, _isGlobal] call AS_fnc_object_add;

        private _properties = [_saveName, "AS_objects_" + _object + "_" + "_properties"] call fn_LoadStat;
        {
            if (_x find "_" != 0) then {
                private _value = [_saveName, "AS_objects_" + _object + "_" + _x] call fn_LoadStat;
                [_object, _x, _value] call AS_fnc_object_set;
            };
        } forEach _properties;
    } forEach _objects;
};
