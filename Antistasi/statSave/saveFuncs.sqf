#include "../macros.hpp"
call compile PreprocessFileLineNumbers "statSave\core.sqf";

// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"NATOsupport", "CSATsupport", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"civPerc", "spawnDistance", "minimumFPS", "cleantime",  // game options
	"secondsForAAFAttack", "destroyedLocations", "vehiclesInGarage", "destroyedBuildings",
	"antenasPos_alive", "antenasPos_dead", "vehicles", "date", "BE_module",
	"patrollingLocations", "patrollingPositions"
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

	// convert everything to a dictionary and serialize it
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
			if (_x == "BE_module") exitWith {
				[_dict, _x, call fnc_BE_save] call DICT_fnc_set;
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
			if (_x == "BE_module") exitWith {
				[_value] call fnc_BE_load;
			};
			AS_Pset(_x, _value);
		};
	} forEach AS_serverVariables;
	_dict call DICT_fnc_delete;

	// modify map items consequent of the persistents
	{
		private _antenna = nearestBuilding _x;
		_antenna removeAllEventHandlers "Killed";
		_antenna setDamage 1;
	} forEach AS_P("antenasPos_dead");
	{
		private _antenna = nearestBuilding _x;
		_antenna removeAllEventHandlers "Killed";
		_antenna setDamage 0;
		_antenna addEventHandler ["Killed", AS_fnc_antennaKilledEH];
	} forEach AS_P("antenasPos_alive");

	{
		[_x, false] call AS_fnc_location_destroy;
	} forEach AS_P("destroyedLocations");

	// destroy the buildings.
	{
		private _buildings = [];
		private _dist = 5;
		while {count _buildings == 0} do {
			_buildings = nearestObjects [_x, AS_destroyable_buildings, _dist];
			_dist = _dist + 5;
		};
		(_buildings select 0) setDamage 1;
	} forEach AS_P("destroyedBuildings");

	// this depends on destroyed locations, so it is run here
	{
		[_x] call powerReorg;
	} forEach ("powerplant" call AS_fnc_location_T);

	// resume saved patrols
   [] spawn {
       sleep 25;
       {
   		[[_x], "patrolCA"] call AS_scheduler_fnc_execute;
       } forEach AS_P("patrollingLocations");
   	{
   		[[_x], "patrolCA"] call AS_scheduler_fnc_execute;
       } forEach AS_P("patrollingPositions");
   };

};

AS_hq_fnc_serialize = {
	private _dict = DICT_fnc_create;

	private _array = [];
	{
		_array pushback [getPos _x, getDir _x];
	} forEach AS_permanent_HQplacements;
	[_dict, "permanents", _array] call DICT_fnc_set;

	_array = [];
	{
		_array pushback [getPos _x, getDir _x, typeOf _x];
	} forEach AS_HQ_placements;
	[_dict, "placed", _array] call DICT_fnc_set;
	[_dict, "inflame", inflamed fuego] call DICT_fnc_set;

	private _serialized_string = _dict call DICT_fnc_serialize;
    _dict call DICT_fnc_delete;

    _serialized_string
};

AS_hq_fnc_deserialize = {
	params ["_serialized_string"];
	private _dict = _serialized_string call DICT_fnc_deserialize;

	{
		(AS_permanent_HQplacements select _forEachIndex) setPos (_x select 0);
		(AS_permanent_HQplacements select _forEachIndex) setDir (_x select 1);
	} forEach ([_dict, "permanents"] call DICT_fnc_get);

	{deleteVehicle _x} forEach AS_HQ_placements;
	AS_HQ_placements = [];
	{
		_x params ["_pos", "_dir", "_type"];
		private _obj = _type createVehicle _pos;
		_obj setDir _dir;
		AS_HQ_placements pushBack _obj;
	} forEach ([_dict, "placed"] call DICT_fnc_get);
	publicVariable "AS_HQ_placements";

	fuego inflame ([_dict, "inflame"] call DICT_fnc_get);
	call AS_fnc_initPetros;

	placementDone = true; publicVariable "placementDone";
	_dict call DICT_fnc_delete;
};

fn_SaveProfile = {saveProfileNamespace};

AS_fnc_saveServer = compile preProcessFileLineNumbers "statSave\saveServer.sqf";
AS_fnc_loadServer = compile preProcessFileLineNumbers "statSave\loadServer.sqf";
