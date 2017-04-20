#include "../macros.hpp"
call compile PreprocessFileLineNumbers "statSave\core.sqf";
call compile preProcessFileLineNumbers "statSave\saveLoadPlayers.sqf";

// Variables that are persistent to `AS_persistent`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"prestigeNATO", "prestigeCSAT", "resourcesAAF", "resourcesFIA", "skillFIA", "skillAAF", "hr",  // FIA attributes
	"enableFTold", "civPerc", "spawnDistance", "minimumFPS", "cleantime"  // game options
];

// function that saves all AS_serverVariables. The two parameters overwrite the AS_persistent variable value to save.
AS_fnc_savePersistents = {
	params ["_saveName", "_varNames", "_varValues"];

	{
		_index = _varNames find _x;
		_varValue = AS_P(_x);
		if (_index != -1) then {
			_varValue = _varValues select _index;
		};
		[_saveName, _x, _varValue] call AS_fnc_SaveStat;
	} forEach AS_serverVariables;
};


// function that loads all AS_serverVariables.
AS_fnc_loadPersistents = {
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
	_array = [];
	{
		_array pushback [getPos _x, getDir _x];
	} forEach AS_permanent_HQplacements;
	[_saveName, "HQPermanents", _array] call fn_SaveStat;

	_array = [];
	if (!isNil "AS_HQ_placements") then {
		{
			// save stuff only close to the HQ.
			_pos = getPos _x;
			if (_pos distance (getMarkerPos "FIA_HQ") < 50) then {
				_array pushback [_pos, getDir _x, typeOf _x];
			};
		} forEach AS_HQ_placements;
	};
	[_saveName, "HQPlacements", _array] call fn_SaveStat;

	[_saveName, "HQinflamed", inflamed fuego] call fn_Savestat;
};

AS_fnc_loadHQ = {
	petros setPos ("FIA_HQ" call AS_fnc_location_position);

	_array = [_saveName, "HQPermanents"] call AS_fnc_LoadStat;
	for "_i" from 0 to count AS_permanent_HQplacements - 1 do {
		(AS_permanent_HQplacements select _i) setPos ((_array select _i) select 0);
		(AS_permanent_HQplacements select _i) setDir ((_array select _i) select 1);
	};

	fuego inflame ([_saveName, "HQinflamed"] call AS_fnc_LoadStat);

	// this is modified only by moveObject.sqf
	AS_HQ_placements = [];
	_array = [_saveName, "HQPlacements"] call AS_fnc_LoadStat;
	for "_i" from 0 to count _array - 1 do {
		_item = ((_array select _i) select 2) createVehicle ((_array select _i) select 0);
		_item setDir ((_array select _i) select 1);
		AS_HQ_placements pushBack _item;
	};
	publicVariable "AS_HQ_placements";

	placementDone = true; publicVariable "placementDone";
	[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
	[[petros,"mission"], "flagaction"] call BIS_fnc_MP;
};

fn_SaveStat = AS_fnc_SaveStat;  // to be replaced in whole project.
fn_LoadStat = AS_fnc_LoadStat;  // to be replaced in whole project.

fn_SaveProfile = {saveProfileNamespace};

AS_fnc_saveMarkers = {
	params ["_saveName"];
	[_saveName, "deadAntennas", antenasmuertas] call fn_SaveStat;

	[_saveName, "destroyedBuildings", destroyedBuildings] call fn_SaveStat;
};

AS_fnc_loadMarkers = {
	params ["_saveName"];

	antenasmuertas = [_saveName, "deadAntennas"] call fn_LoadStat;
	// destroy dead antennas and remove respective marker.
	// antenasmuertas is a list of positions, not markers.
	{
		_mrk = [mrkAntenas, _x] call BIS_fnc_nearestPosition;
		_antena = [antenas, _mrk] call BIS_fnc_nearestPosition;
		antenas = antenas - [_antena];
		_antena removeAllEventHandlers "Killed";
		_antena setDamage 1;
		deleteMarker _mrk;
	} forEach antenasmuertas;

	// list of military building positions that were destroyed.
	destroyedBuildings = [];
	{
		// destroy the building.
		private _buildings = [];
		private _dist = 5;
		while {count _buildings == 0} do {
			_buildings = nearestObjects [_x, listMilBld, _dist];
			_dist = _dist + 5;
		};
		(_buildings select 0) setDamage 1;
		destroyedBuildings pushBack _x;
	} forEach ([_saveName, "destroyedBuildings"] call fn_LoadStat);
};

//===========================================================================
// Variables that require scripting after loaded. See fn_SetStat.
specialVarLoads =
["minas","mineFieldMrk","estaticas","cuentaCA","fecha","tasks"];

// global variables that are set to be publicVariable on loading.
AS_publicVariables = [
	"cuentaCA", "miembros",
	"destroyedCities",
	"vehInGarage", "staticsToSave"
];

//THIS FUNCTIONS HANDLES HOW STATS ARE LOADED
fn_SetStat = {
	_varName = _this select 0;
	_varValue = _this select 1;
	if(isNil '_varValue') exitWith {};

	if(_varName in specialVarLoads) then {
		call {
			if(_varName == 'cuentaCA') exitWith {
				if (_varValue < 2700) then {cuentaCA = 2700} else {cuentaCA = _varValue};
			};
			if(_varName == 'fecha') exitWith {setDate _varValue; forceWeatherChange};
			if(_varName == 'minas') exitWith
				{
				for "_i" from 0 to (count _varvalue) - 1 do
					{
					_tipoMina = _varvalue select _i select 0;
					switch _tipoMina do
						{
						case "APERSMine_Range_Ammo": {_tipoMina = "APERSMine"};
						case "ATMine_Range_Ammo": {_tipoMina = "ATMine"};
						case "APERSBoundingMine_Range_Ammo": {_tipoMina = "APERSBoundingMine"};
						case "SLAMDirectionalMine_Wire_Ammo": {_tipoMina = "SLAMDirectionalMine"};
						case "APERSTripMine_Wire_Ammo": {_tipoMina = "APERSTripMine"};
						case "ClaymoreDirectionalMine_Remote_Ammo": {_tipoMina = "Claymore_F"};
						};
					_posMina = _varvalue select _i select 1;
					_mina = createMine [_tipoMina, _posMina, [], 0];
					_detectada = _varvalue select _i select 2;
					if (_detectada) then {side_blue revealMine _mina};
					if (count (_varvalue select _i) > 3) then//borrar esto en febrero
						{
						_dirMina = _varvalue select _i select 3;
						_mina setDir _dirMina;
						};
					};
				};
			if(_varname == 'estaticas') exitWith
				{
				for "_i" from 0 to (count _varvalue) - 1 do
					{
					_tipoVeh = _varvalue select _i select 0;
					_posVeh = _varvalue select _i select 1;
					_dirVeh = _varvalue select _i select 2;

					_veh = _tipoVeh createVehicle _posVeh;
					_veh setDir _dirVeh;
					if (_tipoVeh in (allStatMGs + allStatATs + allStatAAs + allStatMortars)) then {
						staticsToSave pushBack _veh;
					};
					[_veh, "FIA"] call AS_fnc_initVehicle;
					};
				};
			if(_varname == 'tasks') exitWith
				{
				{
				if (_x == "AtaqueAAF") then
					{
					[] call ataqueAAF;
					}
				else
					{
					if (_x == "DEF_HQ") then
						{
						[] spawn ataqueHQ;
						}
					else
						{
						[_x,true] call missionRequest;
						};
					};
				} forEach _varvalue;
				};
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
