#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_persistents_toDict");

private _money = AS_P("resourcesFIA");
private _hr = AS_P("hr");

// money for spawned units
{
    if ((alive _x) and
            {_x getVariable "side" == "FIA"} and
            {_x getVariable ["BLUFORSpawn", false]} and // garrisons are already tracked by the garrison list
            {!isPlayer _x} and
            {leader group _x == AS_commander or {group _x in (hcAllGroups AS_commander)}}) then {

        _money = _money + ((_x call AS_fnc_getFIAUnitType) call AS_fnc_getCost);
        _hr = _hr + 1;
    };
} forEach allUnits;

// money for FIA vehicles
{
    private _closest = (getPos _x) call AS_location_fnc_nearest;
    private _closest_pos = _closest call AS_location_fnc_position;
    private _size = _closest call AS_location_fnc_size;
    if ((_closest call AS_location_fnc_side == "FIA") and
            {not (_x in AS_permanent_HQplacements)} and
            {(_x call AS_fnc_getSide) == "FIA"} and
            {alive _x} and
            {_x distance _closest_pos < _size} and
            {not (_x in AS_P("vehicles"))} and // these are saved and so they are not converted to money
            {_x getVariable ["AS_vehOwner", "noOwner"] == "noOwner"}) then {

        _money = _money + ([typeOf _x] call AS_fnc_getFIAvehiclePrice);
        {_money = _money + ([typeOf _x] call AS_fnc_getFIAvehiclePrice)} forEach attachedObjects _x;
    };
} forEach vehicles;

// convert vehicles to positional information
private _vehicles = [];
{
    private _type = typeOf _x;
    private _pos = getPos _x;
    private _dir = getDir _x;
    _vehicles pushBack [_type, _pos, _dir];
} forEach AS_P("vehicles");

// convert everything to a dictionary
private _dict = call DICT_fnc_create;
{
    call {
        if (_x == "vehicles") exitWith {
            [_dict, _x, _vehicles] call DICT_fnc_setGlobal;
        };
        if (_x == "hr") exitWith {
            [_dict, _x, _hr] call DICT_fnc_setGlobal;
        };
        if (_x == "date") exitWith {
            [_dict, _x, date] call DICT_fnc_setGlobal;
        };
        if (_x == "BE_module") exitWith {
            [_dict, _x, call fnc_BE_save] call DICT_fnc_setGlobal;
        };
        if (_x == "resourcesFIA") exitWith {
            [_dict, _x, _money] call DICT_fnc_setGlobal;
        };
        [_dict, _x, AS_P(_x)] call DICT_fnc_setGlobal;
    };
} forEach AS_database_persistents;
_dict
