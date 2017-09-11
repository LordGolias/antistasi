#include "../macros.hpp"
call compile PreprocessFileLineNumbers "statSave\core.sqf";
call compile preProcessFileLineNumbers "statSave\saveLoadPlayers.sqf";

// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"NATOsupport", "CSATsupport", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"civPerc", "spawnDistance", "minimumFPS", "cleantime",  // game options
	"secondsForAAFAttack", "destroyedLocations", "vehiclesInGarage", "destroyedBuildings",
	"antenasPos_alive", "antenasPos_dead", "vehicles", "date",
	"patrollingLocations",
];

AS_persistents_fnc_serialize = {
    private _money = AS_P("resourcesFIA");
	private _hr = AS_P("hr");

    // money for spawned units
    {
        if ((alive _x) and
                {_x getVariable "side" == "FIA"} and
				{_x getVariable ["BLUFORSpawn", false]} and // garrisons are already tracked by the garrison list
                {!isPlayer _x} and
                {leader group _x == AS_commander or {group _x in (hcAllGroups AS_commander)}}) then {

            private _price = AS_data_allCosts getVariable (_x call AS_fnc_getFIAUnitName);
            if (!(isNil "_price")) then {
                _money = _money + _price;
				_hr = _hr + 1;
            } else {
                diag_log format ["[AS] Error: type '%1' has no defined price", typeOf _x];
            };
        };
    } forEach allUnits;

	// money for FIA vehicles
    {
        private _closest = (getPos _x) call AS_fnc_location_nearest;
		private _size = _closest call AS_fnc_location_size;
        if ((_closest call AS_fnc_location_side == "FIA") and
				{not (_x in AS_permanent_HQplacements)} and
                {(_x getVariable "AS_side") == "FIA"} and
                {alive _x} and
                {_x distance _closest < _size} and
				{not (_x in AS_P("vehicles"))} and // these are saved and so they are not converted to money
                {_x getVariable ["AS_vehOwner", "noOwner"] == "noOwner"}) then {

            _money = _money + ([typeOf _x] call FIAvehiclePrice);
            {_money = _money + ([typeOf _x] call FIAvehiclePrice)} forEach attachedObjects _x;
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

	private _dict = DICT_fnc_create;
	{
		call {
			if (_x == "vehicles") exitWith {
				[_dict, _x, _vehicles] call DICT_fnc_set;
			};
			if (_x == "hr") exitWith {
				[_dict, _x, _hr] call DICT_fnc_set;
			};
			if (_x == "date") exitWith {
				[_dict, _x, date] call DICT_fnc_set;
			};
			if (_x == "resourcesFIA") exitWith {
				[_dict, _x, _money] call DICT_fnc_set;
			};
			[_dict, _x, AS_P(_x)] call DICT_fnc_set;
		};
	} forEach AS_serverVariables;

	private _serialized_string = _dict call DICT_fnc_serialize;
    _dict call DICT_fnc_delete;

    _serialized_string
};

AS_persistents_fnc_deserialize = {
	params ["_serialized_string"];

	private _dict = _serialized_string call DICT_fnc_deserialize;

	{
		private _value = [_dict, _x] call DICT_fnc_get;
		call {
			if (_x == "vehicles") exitWith {
				private _vehicles = [];
				{
					_x params ["_type", "_pos", "_dir"];

					private _vehicle = _type createVehicle _pos;
					_vehicle setDir _dir;
					[_vehicle, "FIA"] call AS_fnc_initVehicle;
					_vehicles pushBack _vehicle;
				} forEach _value;
				AS_Pset(_x, _vehicles);
			};
			if (_x == "date") exitWith {
				setDate _value;
			};
			AS_Pset(_x, _value);
		};
	} forEach AS_serverVariables;
};

AS_fnc_saveHQ = {
    params ["_saveName"];
	private _array = [];
	{
		_array pushback [getPos _x, getDir _x];
	} forEach AS_permanent_HQplacements;
	[_saveName, "HQPermanents", _array] call AS_fnc_saveStat;

	_array = [];
	{
		_array pushback [getPos _x, getDir _x, typeOf _x];
	} forEach AS_HQ_placements;
	[_saveName, "HQPlacements", _array] call AS_fnc_saveStat;

	[_saveName, "HQinflamed", inflamed fuego] call AS_fnc_saveStat;
};

AS_fnc_loadHQ = {
	params ["_saveName"];
	call AS_fnc_initPetros;

	private _array = [_saveName, "HQPermanents"] call AS_fnc_loadStat;
	for "_i" from 0 to count AS_permanent_HQplacements - 1 do {
		(AS_permanent_HQplacements select _i) setPos ((_array select _i) select 0);
		(AS_permanent_HQplacements select _i) setDir ((_array select _i) select 1);
	};

	fuego inflame ([_saveName, "HQinflamed"] call AS_fnc_loadStat);

	"delete" call AS_fnc_HQaddObject;
	_array = [_saveName, "HQPlacements"] call AS_fnc_loadStat;
	{
		_x params ["_pos", "_dir", "_type"];
		private _obj = _type createVehicle _pos;
		_obj setDir _dir;
		AS_HQ_placements pushBack _obj;
	} forEach _array;

	placementDone = true; publicVariable "placementDone";
};

fn_SaveProfile = {saveProfileNamespace};

AS_fnc_saveServer = compile preProcessFileLineNumbers "statSave\saveServer.sqf";
AS_fnc_loadServer = compile preProcessFileLineNumbers "statSave\loadServer.sqf";

saveFuncsLoaded = true;
