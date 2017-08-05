// This is an API to store generic objects in a structure similar to a 2-level nested Python dictionary.
// The first level is named "containers", the second "objects".
// How to use:
/*
    * add container: AS_fnc_container_add(container)
    * remove container: AS_fnc_container_remove(container)

    * add object: `AS_fnc_object_add(container, name, isGlobal=false)`
    * remove object: `AS_fnc_object_remove(container, name)`
    * set property: `AS_fnc_object_set(container, name, property, value)`
    * get property: `AS_fnc_object_get(container, name, property)`
    * del property: `AS_fnc_object_del(container, name, property)`

    * list of objects: `AS_fnc_objects(container)`
    * list of properties of an object: `AS_fnc_object_properties(container, name)`

    * save all: `AS_fnc_container_save`
    * load all: `AS_fnc_container_load`

    Rules:
    1. container, object, and property names must be unique and cannot start with `_`.
    2. `isGlobal` defines whether the object is global or local
*/

AS_fnc_containers = {AS_containers getVariable ["_all",[]]};

////////////////////////////////// Getters //////////////////////////////////

AS_fnc_container_exists = {
    params ["_container"];
    _container in (call AS_fnc_containers)
};

AS_fnc_object_exists = {
    params ["_container", "_object"];

    if not (_container call AS_fnc_container_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_exists: container '%1' does not exist", _container];
        false
    };
    _object in (_container call AS_fnc_objects)
};

AS_fnc_object_get = {
    params ["_container", "_object", "_property"];

    if not ([_container, _object] call AS_fnc_object_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_get: object '%1' does not exist in container '%2'", _object, _container];
    };

    private _properties = [_container, _object] call AS_fnc_object_properties;
    if not (_property in _properties) exitWith {
        diag_log format ["[AS] Error: object_get: property '%1' does not exist for object '%2' in container '%3'. Valid properties: %4", _property, _object, _container, _properties];
    };

    (AS_containers getVariable _container) getVariable (_object + "_" + _property)
};

////////////////////////////////// Iterators ////////////////////////////////

// returns all objects in a container
AS_fnc_objects = {
    params ["_container"];

    if not (_container call AS_fnc_container_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_objects: container '%1' does not exist", _container];
        false
    };
    (AS_containers getVariable _container) getVariable "_all"
};

// returns all properties of a given object of a container
AS_fnc_object_properties = {
    params ["_container", "_object"];

    if not ([_container, _object] call AS_fnc_object_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_properties: object '%1' does not exist in container %2", _object, _container];
        []
    };
    (AS_containers getVariable _container) getVariable (_object + "_" + "_properties")
};

////////////////////////////////// Setters ////////////////////////////////

AS_fnc_container_add = {
    params ["_container"];

    if (isNil "AS_containers") then {
        // create container to store containers
        AS_containers = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
        publicVariable "AS_containers";
    };

    private _containers = call AS_fnc_containers;
    if (_container in _containers) exitWith {
        diag_log format ["[AS] Error: AS_fnc_container_add: container '%1' already exists", _container];
    };

    if (_container find "_" == 0) exitWith {
        diag_log format ["[AS] Error: AS_fnc_container_add: containers cannot start with '_' but '%s' does.", _container];
    };

    _containers pushBack _container;
    AS_containers setVariable ["_all", _containers, true];
    private _containerObj = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
    AS_containers setVariable [_container, _containerObj, true];
    _containerObj setVariable ["_all", []];
};

AS_fnc_container_remove = {
    params ["_container"];
    private _containers = call AS_fnc_containers;
    if not (_container in _containers) exitWith {
        diag_log format ["[AS] Error: AS_fnc_container_remove: container '%1' does not exist", _container];
    };
    deleteVehicle (AS_containers getVariable _container);
    AS_containers setVariable ["_all", _containers - _container, true];
    AS_containers setVariable [_container, nil, true];
};

// adds an object to a container. The second argument must be a unique name for that container
// Third argument (_isGlobal) makes the object either local or global (default is local).
AS_fnc_object_add = {
    params ["_container", "_object", ["_isGlobal", false]];
    private _objects = _container call AS_fnc_objects;

    if (_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_add: object '%1' already exists in container '%2'.", _object, _container];
    };
    if (_object find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_add: objects cannot start with '_' but '%1' in container '%2' does.", _object, _container];
    };

    _objects pushBack _object;
    (AS_containers getVariable _container) setVariable ["_all", _objects, _isGlobal];
    (AS_containers getVariable _container) setVariable [_object + "_" + "_properties", ["_properties"], _isGlobal];

    // _isGlobal has to be the first property set so next ones are already set correctly.
    [_container, _object, "_isGlobal", _isGlobal] call AS_fnc_object_set;
};

// Sets a property of an object
AS_fnc_object_set = {
    params ["_container", "_object", "_property", "_value"];

    if (_property != "_isGlobal" and (_property find "_") == 0) exitWith {
        diag_log format ["[AS] Error: object_set: properties cannot start with '_' but '%1' does (%2, %3, %4).", _property, _container, _object, _value];
    };

    if not ([_container, _object] call AS_fnc_object_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_set: object '%1' does not exist in container '%2'", _object, _container];
    };

    // when isGlobal is set itself, we need to be careful:
    private _isGlobal = false;
    if (_property == "_isGlobal") then {
        _isGlobal = _value;
    } else {
        _isGlobal = [_container, _object, "_isGlobal"] call AS_fnc_object_get;
    };

    private _properties = [_container, _object] call AS_fnc_object_properties;
    _properties pushBack _property;
    (AS_containers getVariable _container) setVariable [_object + "_" + "_properties", _properties, _isGlobal];
    (AS_containers getVariable _container) setVariable [_object + "_" + _property, _value, _isGlobal];
};

// deletes a property of an object
AS_fnc_object_del = {
    params ["_container", "_object", "_property"];

    if (_property find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_del: properties cannot start with '_' but '%1' does.", _property];
    };
    if not ([_container, _object] call AS_fnc_object_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_del: object '%1' does not exist in container '%2'", _object, _container];
    };
    private _isGlobal = [_container, _object, "_isGlobal"] call AS_fnc_object_get;

    private _properties = [_container, _object] call AS_fnc_object_properties;
    _properties = _properties - [_property];
    (AS_containers getVariable _container) setVariable [_object + "_" + "_properties", _properties, _isGlobal];
    (AS_containers getVariable _container) setVariable [_object + "_" + _property, nil, _isGlobal];
};

// removes an object.
AS_fnc_object_remove = {
    params ["_container", "_object"];
    private _objects = _container call AS_fnc_objects;

    if !(_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_remove: object '%1' cannot be removed from container '%2' because it does not exist.", _object, _container];
    };
    private _isGlobal = [_container, _object, "_isGlobal"] call AS_fnc_object_get;

    // its properties
    {
        (AS_containers getVariable _container) setVariable [_object + "_" + "_properties" + "_" + _x, nil, _isGlobal];
    } forEach ([_container, _object] call AS_fnc_object_properties);

    // itself
    (AS_containers getVariable _container) setVariable ["_all", _objects - [_object], _isGlobal];
    (AS_containers getVariable _container) setVariable [_object + "_" + "_properties", nil, _isGlobal];
};

////////////////////////////////// Persistent ////////////////////////////////

AS_fnc_object_save = {
    params ["_container", "_saveName"];
    private _objects = _container call AS_fnc_objects;
    [_saveName, "AS_containers_" + _container, _objects] call fn_SaveStat;
    {
        private _object = _x;
        private _properties = [_container, _object] call AS_fnc_object_properties;
        // saves both "_" and non-"_" properties.
        {
            [_saveName, format ["AS_containers_%1_%2_%3", _container, _object, _x], [_container, _object, _x] call AS_fnc_object_get] call fn_SaveStat;
        } forEach _properties;
    } forEach _objects;
};

AS_fnc_object_load = {
    params ["_container", "_saveName"];
    private _key = "AS_containers_%1_%2_%3";

    // populate with the saved objects
    private _objects = [_saveName, "AS_containers_" + _container] call fn_LoadStat;
    {
        private _object = _x;
        private _isGlobal = [_saveName, format[_key, _container, _object, "_isGlobal"]] call fn_LoadStat;
        [_container, _object, _isGlobal] call AS_fnc_object_add;

        private _properties = [_saveName, format[_key, _container, _object, "_properties"]] call fn_LoadStat;
        {
            if (_x find "_" != 0) then {
                private _value = [_saveName, format[_key, _container, _object, _x]] call fn_LoadStat;
                [_container, _object, _x, _value] call AS_fnc_object_set;
            };
        } forEach _properties;
    } forEach _objects;
};
