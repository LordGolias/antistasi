#include "../macros.hpp"

// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"NATOsupport", "CSATsupport", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"civPerc", "spawnDistance", "minimumFPS", "cleantime",  // game options
	"secondsForAAFAttack", "destroyedLocations", "vehiclesInGarage", "destroyedBuildings",
	"antenasPos_alive", "antenasPos_dead", "vehicles", "date", "BE_module",
	"patrollingLocations", "patrollingPositions"
];

AS_persistents_fnc_toDict = {
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

	// convert everything to a dictionary
	private _dict = call DICT_fnc_create;
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
    _dict
};

AS_persistents_fnc_fromDict = {
	params ["_dict"];
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

AS_hq_fnc_toDict = {
	private _dict = call DICT_fnc_create;

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

	_dict
};

AS_hq_fnc_fromDict = {
	params ["_dict"];

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
};

AS_fnc_serializeServer = {
	AS_SERVER_ONLY("AS_fnc_serializeServer");

	diag_log "[AS] Server: serializing game...";

	private _dict = call DICT_fnc_create;

	diag_log "[AS] Server: serializing AAF arsenal...";
	[_dict, "AS_aaf_arsenal", call AS_AAFarsenal_fnc_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing locations...";
	[_dict, "AS_location", call AS_fnc_location_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing fia_hq...";
	[_dict, "AS_fia_hq", call AS_hq_fnc_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing FIA arsenal...";
	[_dict, "AS_fia_arsenal", call AS_FIAarsenal_fnc_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing persistents...";
	[_dict, "AS_persistent", call AS_persistents_fnc_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing missions...";
	[_dict, "AS_mission", call AS_fnc_mission_toDict] call DICT_fnc_set;

	diag_log "[AS] Server: serializing players...";
	[_dict, "AS_player", call AS_players_fnc_toDict] call DICT_fnc_set;

	private _string = _dict call DICT_fnc_serialize;
	diag_log "[AS] Server: serialization completed.";
	_string
};

AS_fnc_deserializeServer = {
	AS_SERVER_ONLY("AS_fnc_deserializeServer");
	params ["_string"];

	petros allowdamage false;

	// stop spawning new locations
	[false] call AS_fnc_spawnToggle;
	// despawn every spawned location
	{
	    if (_x call AS_fnc_location_spawned) then {
	        _x call AS_fnc_location_despawn;
	    };
	} forEach (call AS_fnc_locations);

	[false] call AS_fnc_resourcesToggle;

	diag_log "[AS] Server: deserializing data...";
	private _dict = _string call DICT_fnc_deserialize;

	// this order matters!
	diag_log "[AS] Server: loading locations...";
	([_dict, "AS_location"] call DICT_fnc_get) call AS_fnc_location_fromDict;

	diag_log "[AS] Server: loading persistents...";
	([_dict, "AS_persistent"] call DICT_fnc_get) call AS_persistents_fnc_fromDict;

	diag_log "[AS] Server: loading HQ...";
	([_dict, "AS_fia_hq"] call DICT_fnc_get) call AS_hq_fnc_fromDict;

	diag_log "[AS] Server: loading FIA arsenal...";
	([_dict, "AS_fia_arsenal"] call DICT_fnc_get) call AS_FIAarsenal_fnc_fromDict;

	diag_log "[AS] Server: loading players...";
	([_dict, "AS_player"] call DICT_fnc_get) call AS_players_fnc_fromDict;

	diag_log "[AS] Server: loading AAF arsenal...";
	([_dict, "AS_aaf_arsenal"] call DICT_fnc_get) call AS_AAFarsenal_fnc_fromDict;

	diag_log "[AS] Server: loading missions...";
	([_dict, "AS_mission"] call DICT_fnc_get) call AS_fnc_mission_fromDict;
	petros allowdamage true;

	_dict call DICT_fnc_delete;
	diag_log "[AS] Server: loading completed.";

	// start spawning again
	[true] call AS_fnc_spawnToggle;
	[true] call AS_fnc_resourcesToggle;
};
