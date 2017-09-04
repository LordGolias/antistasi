#include "../macros.hpp"
call compile PreprocessFileLineNumbers "statSave\core.sqf";
call compile preProcessFileLineNumbers "statSave\saveLoadPlayers.sqf";

// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"NATOsupport", "CSATsupport", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"civPerc", "spawnDistance", "minimumFPS", "cleantime",  // game options
	"secondsForAAFAttack", "destroyedLocations", "vehiclesInGarage", "destroyedBuildings",
	"antenasPos_alive", "antenasPos_dead",
	"patrollingLocations"
];

// function that saves all AS_serverVariables. The two parameters overwrite the AS_persistent variable value to save.
AS_fnc_savePersistents = {
	params ["_saveName", "_varNames", "_varValues"];

	{
		private _index = _varNames find _x;
		private _varValue = AS_P(_x);
		if (_index != -1) then {
			_varValue = _varValues select _index;
		};
		[_saveName, _x, _varValue] call AS_fnc_SaveStat;
	} forEach AS_serverVariables;

	// vehicles have to be serialized, so we do it here.
	private _vehicles = [];
	{
		private _type = typeOf _x;
		private _pos = getPos _x;
		private _dir = getDir _x;
		_vehicles pushBack [_type,_pos,_dir];
	} forEach AS_P("vehicles");
	[_saveName, "vehicles", _vehicles] call AS_fnc_SaveStat;
};


// function that loads all AS_serverVariables.
AS_fnc_loadPersistents = {
	params ["_saveName"];

	// vehicles have to be serialized, so we do it here.
	private _vehicles = [];
	{
		private _type = _x select 0;
		private _pos = _x select 1;
		private _dir = _x select 2;

		private _veh = _type createVehicle _pos;
		_veh setDir _dir;
		[_veh, "FIA"] call AS_fnc_initVehicle;
		_vehicles pushBack _veh;
	} forEach ([_saveName, "vehicles"] call AS_fnc_LoadStat);
	AS_Pset('vehicles', _vehicles);

	// remaining variables
    params ["_saveName"];
	{
        AS_Pset(_x, [_saveName, _x] call AS_fnc_LoadStat);
	} forEach AS_serverVariables;
};

AS_fnc_saveArsenal = {
	params ["_saveName", "_weapons", "_magazines", "_items", "_backpacks"];

	[_saveName, "ARSENALweapons", _weapons] call fn_SaveStat;
	[_saveName, "ARSENALmagazines", _magazines] call fn_SaveStat;
	[_saveName, "ARSENALitems", _items] call fn_SaveStat;
	[_saveName, "ARSENALbackpacks", _backpacks] call fn_SaveStat;

	[_saveName, "ARSENALunlockedWeapons", unlockedWeapons] call fn_SaveStat;
	[_saveName, "ARSENALunlockedItems", unlockedItems] call fn_SaveStat;
	[_saveName, "ARSENALunlockedMagazines", unlockedMagazines] call fn_SaveStat;
	[_saveName, "ARSENALunlockedBackpacks", unlockedBackpacks] call fn_SaveStat;
};

AS_fnc_loadArsenal = {
    params ["_saveName"];
	private ["_weapons", "_magazines", "_items", "_backpacks"];

	_weapons = [_saveName, "ARSENALweapons"] call AS_fnc_LoadStat;
	_magazines = [_saveName, "ARSENALmagazines"] call AS_fnc_LoadStat;
	_items = [_saveName, "ARSENALitems"] call AS_fnc_LoadStat;
	_backpacks = [_saveName, "ARSENALbackpacks"] call AS_fnc_LoadStat;

	[caja, _weapons, _magazines, _items, _backpacks, true, true] call AS_fnc_populateBox;

	// load unlocked stuff
	unlockedWeapons = [_saveName, "ARSENALunlockedWeapons"] call AS_fnc_LoadStat;
	unlockedMagazines = [_saveName, "ARSENALunlockedMagazines"] call AS_fnc_LoadStat;
	unlockedItems = [_saveName, "ARSENALunlockedItems"] call AS_fnc_LoadStat;
	unlockedBackpacks = [_saveName, "ARSENALunlockedBackpacks"] call AS_fnc_LoadStat;

	publicVariable "unlockedWeapons";
	publicVariable "unlockedMagazines";
	publicVariable "unlockedItems";
	publicVariable "unlockedBackpacks";
};

AS_fnc_saveHQ = {
    params ["_saveName"];
	private _array = [];
	{
		_array pushback [getPos _x, getDir _x];
	} forEach AS_permanent_HQplacements;
	[_saveName, "HQPermanents", _array] call fn_SaveStat;

	_array = [];
	{
		_array pushback [getPos _x, getDir _x, typeOf _x];
	} forEach AS_HQ_placements;
	[_saveName, "HQPlacements", _array] call fn_SaveStat;

	[_saveName, "HQinflamed", inflamed fuego] call fn_Savestat;
};

AS_fnc_loadHQ = {
	params ["_saveName"];
	call AS_fnc_initPetros;

	private _array = [_saveName, "HQPermanents"] call AS_fnc_LoadStat;
	for "_i" from 0 to count AS_permanent_HQplacements - 1 do {
		(AS_permanent_HQplacements select _i) setPos ((_array select _i) select 0);
		(AS_permanent_HQplacements select _i) setDir ((_array select _i) select 1);
	};

	fuego inflame ([_saveName, "HQinflamed"] call AS_fnc_LoadStat);

	"delete" call AS_fnc_HQaddObject;
	_array = [_saveName, "HQPlacements"] call AS_fnc_LoadStat;
	{
		_x params ["_pos", "_dir", "_type"];
		private _obj = _type createVehicle _pos;
		_obj setDir _dir;
		AS_HQ_placements pushBack _obj;
	} forEach _array;

	placementDone = true; publicVariable "placementDone";
};

fn_SaveStat = AS_fnc_SaveStat;  // to be replaced in whole project.
fn_LoadStat = AS_fnc_LoadStat;  // to be replaced in whole project.

fn_SaveProfile = {saveProfileNamespace};

//===========================================================================
// Variables that require scripting after loaded. See fn_SetStat.
specialVarLoads = ["fecha"];

// global variables that are set to be publicVariable on loading.
AS_publicVariables = ["miembros"];

//THIS FUNCTIONS HANDLES HOW STATS ARE LOADED
fn_SetStat = {
	private _varName = _this select 0;
	private _varValue = _this select 1;
	if(isNil '_varValue') exitWith {};

	if(_varName in specialVarLoads) then {
		call {
			if(_varName == 'fecha') exitWith {setDate _varValue; forceWeatherChange};
		};
	}
	else
	{
		call compile format ["%1 = %2",_varName,_varValue];
	};

	if (_varName in AS_publicVariables) then {
		publicVariable _varName;
	};
};

AS_fnc_saveServer = compile preProcessFileLineNumbers "statSave\saveServer.sqf";
AS_fnc_loadServer = compile preProcessFileLineNumbers "statSave\loadServer.sqf";

saveFuncsLoaded = true;
