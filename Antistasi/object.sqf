/*
This is an API to store generic objects in a structure similar to a 2-level nested Python dictionary.
This API uses atomic read/write/delete.
The first level is named "containers", the second "objects". I.e. containers contain objects.

How to use:
    * add container: AS_fnc_container_add(container, isGlobal)
    * remove container: AS_fnc_container_remove(container)

    * add object: `AS_fnc_object_add(container, name)`
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
    2. `isGlobal` defines whether the container (and its objects) is global or local
*/

// These defines are used for atomicity:
// * WRITE/END_WRITE locks/unlocks READ
// * READ waits until there is no write

#define READ (if (!isNil "AS_object_all") then {waitUntil {isNil "AS_object_all"}})
#define WRITE AS_object_all = true
#define END_WRITE AS_object_all = nil

// These are idioms to GET from a container. We define them to simplify the
// notation. They have to be used before a READ to guarantee atomicity.
#define GET_PROPERTY(_container, _property) ((AS_containers getVariable _container) getVariable _property)
#define GET_OBJECT_PROPERTY(_container, _object, _property) (GET_PROPERTY(_container, (_object + "_" + _property)))
#define GET_OBJECT_EXISTS(_container, _object) (_object in GET_PROPERTY(_container, "_all"))

#define SET_PROPERTY(_container, _property, _value, _isGlobal) ((AS_containers getVariable _container) setVariable [_property, _value, _isGlobal])

AS_fnc_containers = {AS_containers getVariable ["_all",[]]};

////////////////////////////////// Getters //////////////////////////////////

AS_fnc_container_exists = {
    params ["_container"];
    _container in (call AS_fnc_containers)
};

AS_fnc_object_exists = {
    params ["_container", "_object"];
    READ;
    GET_OBJECT_EXISTS(_container, _object)
};

AS_fnc_object_get = {
    params ["_container", "_object", "_property"];
    READ;

    if not (GET_OBJECT_EXISTS(_container, _object)) exitWith {
        diag_log format ["[AS] Error: object_get(%1,%2,%3): object '%2' does not exist in container '%1'. Valid objects: %4", _container, _object, _property, _container call AS_fnc_objects];
    };

    private _properties = GET_OBJECT_PROPERTY(_container, _object, "_properties");
    if not (_property in _properties) exitWith {
        diag_log format ["[AS] Error: object_get(%1,%2,%3): property '%3' does not exist for object '%2' in container '%1'. Valid properties: %4", _container, _object, _property, _properties];
    };

    GET_OBJECT_PROPERTY(_container, _object, _property)
};

////////////////////////////////// Iterators ////////////////////////////////

// returns all objects in a container
AS_fnc_objects = {
    params ["_container"];
    READ;

    if not (_container call AS_fnc_container_exists) exitWith {
        diag_log format ["[AS] Error: AS_fnc_objects: container '%1' does not exist", _container];
        []
    };
    GET_PROPERTY(_container, "_all")
};

// returns all properties of a given object of a container
AS_fnc_object_properties = {
    params ["_container", "_object"];
    READ;

    if not (GET_OBJECT_EXISTS(_container, _object)) exitWith {
        diag_log format ["[AS] Error: object_properties: object '%1' does not exist in container %2", _object, _container];
        []
    };
    GET_OBJECT_PROPERTY(_container, _object, "_properties")
};

////////////////////////////////// Setters ////////////////////////////////

AS_fnc_container_add = {
    params ["_container", "_isGlobal"];
    READ;
    WRITE;

    if (isNil "AS_containers") then {
        // create container to store containers
        AS_containers = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
        publicVariable "AS_containers";
    };

    private _containers = call AS_fnc_containers;
    if (_container in _containers) exitWith {
        diag_log format ["[AS] Error: AS_fnc_container_add: container '%1' already exists", _container];
        END_WRITE;
    };

    if (_container find "_" == 0) exitWith {
        diag_log format ["[AS] Error: AS_fnc_container_add: containers cannot start with '_' but '%s' does.", _container];
        END_WRITE;
    };

    _containers pushBack _container;
    AS_containers setVariable ["_all", _containers, true];
    private _containerObj = (createGroup sideLogic) createUnit ["LOGIC",[0, 0, 0] , [], 0, ""];
    AS_containers setVariable [_container, _containerObj, _isGlobal];
    private _all = [];
    SET_PROPERTY(_container, "_all", _all, true);
    SET_PROPERTY(_container, "_isGlobal", _isGlobal, true);
    END_WRITE;
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
    params ["_container", "_object"];
    READ;
    WRITE;

    private _objects = GET_PROPERTY(_container, "_all");
    private _isGlobal = GET_PROPERTY(_container, "_isGlobal");

    if (_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_add: object '%1' already exists in container '%2'.", _object, _container];
        END_WRITE;
    };
    if (_object find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_add: objects cannot start with '_' but '%1' in container '%2' does.", _object, _container];
        END_WRITE;
    };

    _objects pushBack _object;
    private _properties = ["_properties"];
    SET_PROPERTY(_container, "_all", _objects, _isGlobal);
    SET_PROPERTY(_container, _object + "_" + "_properties", _properties, _isGlobal);
    END_WRITE;
};

// Sets a property of an object
AS_fnc_object_set = {
    params ["_container", "_object", "_property", "_value"];
    READ;
    WRITE;

    if ((_property find "_") == 0) exitWith {
        diag_log format ["[AS] Error: object_set: properties cannot start with '_' but '%1' does (%2, %3, %4).", _property, _container, _object, _value];
        END_WRITE;
    };

    if not (GET_OBJECT_EXISTS(_container, _object)) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_set: object '%1' does not exist in container '%2'", _object, _container];
        END_WRITE;
    };

    private _isGlobal = GET_PROPERTY(_container, "_isGlobal");

    private _properties = GET_OBJECT_PROPERTY(_container, _object, "_properties");
    _properties pushBack _property;
    SET_PROPERTY(_container, _object + "_" + "_properties", _properties, _isGlobal);
    SET_PROPERTY(_container, _object + "_" + _property, _value, _isGlobal);
    END_WRITE;
};

// deletes a property of an object
AS_fnc_object_del = {
    params ["_container", "_object", "_property"];
    READ;
    WRITE;

    if (_property find "_" == 0) exitWith {
        diag_log format ["[AS] Error: object_del: properties cannot start with '_' but '%1' does.", _property];
    };
    if not (GET_OBJECT_EXISTS(_container, _object)) exitWith {
        diag_log format ["[AS] Error: AS_fnc_object_del: object '%1' does not exist in container '%2'", _object, _container];
        END_WRITE;
    };
    private _isGlobal = GET_PROPERTY(_container, "_isGlobal");

    private _properties = GET_OBJECT_PROPERTY(_container, _object, "_properties");
    _properties = _properties - [_property];
    SET_PROPERTY(_container, _object + "_" + "_properties", _properties, _isGlobal);
    SET_PROPERTY(_container, _object + "_" + _property, nil, _isGlobal);
    END_WRITE;
};

// removes an object.
AS_fnc_object_remove = {
    params ["_container", "_object"];
    READ;
    WRITE;

    private _objects = GET_PROPERTY(_container, "_all");

    if !(_object in _objects) exitWith {
        diag_log format ["[AS] Error: object_remove: object '%1' cannot be removed from container '%2' because it does not exist.", _object, _container];
        END_WRITE;
    };
    private _isGlobal = GET_PROPERTY(_container, "_isGlobal");

    // its properties
    {
        SET_PROPERTY(_container, _object + "_" + _x, nil, _isGlobal);
    } forEach GET_OBJECT_PROPERTY(_container, _object, "_properties");

    // itself
    _objects = _objects - [_object];
    SET_PROPERTY(_container, _object + "_" + "_properties", nil, _isGlobal);
    SET_PROPERTY(_container, "_all", _objects, _isGlobal);
    END_WRITE;
};

////////////////////////////////// Persistent ////////////////////////////////

AS_fnc_object_save = {
    params ["_container", "_saveName"];
    WRITE;
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
    END_WRITE;
};

AS_fnc_object_load = {
    params ["_container", "_saveName"];
    private _key = "AS_containers_%1_%2_%3";

    // populate with the saved objects
    private _objects = [_saveName, "AS_containers_" + _container] call fn_LoadStat;
    {
        private _object = _x;
        [_container, _object] call AS_fnc_object_add;

        private _properties = [_saveName, format[_key, _container, _object, "_properties"]] call fn_LoadStat;
        {
            if (_x find "_" != 0) then {
                private _value = [_saveName, format[_key, _container, _object, _x]] call fn_LoadStat;
                [_container, _object, _x, _value] call AS_fnc_object_set;
            };
        } forEach _properties;
    } forEach _objects;
};
