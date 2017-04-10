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

	[_saveName] call AS_fnc_saveCities;
};


// function that loads all AS_serverVariables.
AS_fnc_loadPersistents = {
    params ["_saveName"];
	{
        AS_Pset(_x, [_saveName, _x] call AS_fnc_LoadStat);
	} forEach AS_serverVariables;

	[_saveName] call AS_fnc_loadCities;
};

// function that persistently saves cities.
AS_fnc_saveCities = {
    params ["_saveName"];
	{
		_data = AS_persistent_cities getVariable _x;
		[_saveName, "CITY" + _x, _data] call AS_fnc_SaveStat;
	} forEach ciudades;
};

AS_fnc_loadCities = {
    params ["_saveName"];
	{
		AS_persistent_cities setVariable [_x, [_saveName, "CITY" + _x] call AS_fnc_LoadStat, true];
	} forEach ciudades;
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

AS_permanent_HQplacements = [caja, cajaVeh, mapa, fuego, bandera];

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
			if (_pos distance (getMarkerPos "respawn_west") < 50) then {
				_array pushback [_pos, getDir _x, typeOf _x];
			};
		} forEach AS_HQ_placements;
	};
	[_saveName, "HQPlacements", _array] call fn_SaveStat;

	[_saveName, "HQpos", getMarkerPos "respawn_west"] call fn_Savestat;
	[_saveName, "HQinflamed", inflamed fuego] call fn_Savestat;
};

AS_fnc_loadHQ = {
	private _posHQ = [_saveName, "HQpos"] call AS_fnc_LoadStat;
	{
		if (getMarkerPos _x distance _posHQ < 1000) exitWith {
			mrkAAF = mrkAAF - [_x];
			mrkFIA = mrkFIA + [_x];
		};
	} forEach controles;

	"FIA_HQ" setMarkerPos _posHQ;
	"respawn_west" setMarkerPos _posHQ;
	"respawn_west" setMarkerAlpha 1;
	petros setPos _posHQ;

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
	// controls change side depending on the markers, so no need to save them.
	[_saveName, "mrkAAF", mrkAAF - controles] call fn_SaveStat;
	// puestosFIA is saved afterwards.
	[_saveName, "mrkFIA", mrkFIA - puestosFIA - controles] call fn_SaveStat;

	private _FIAoutpostsPositions = [];
	{
		_FIAoutpostsPositions pushBack (getMarkerPos _x);
	} forEach puestosFIA;
	[_saveName, "FIAoutpostPositions", _FIAoutpostsPositions] call fn_SaveStat;

	private _AAFbasesStatus = [];
	{
		_AAFbasesStatus pushBack [_x, server getVariable _x];
	} forEach (aeropuertos + bases);
	[_saveName, "AAFbasesStatus", _AAFbasesStatus] call fn_SaveStat;

	// this indirectly saves puestosFIA
	private _FIAcampsData = [];
	{
		_position = getMarkerPos (_x select 0);
		_text = _x select 1;
		_FIAcampsData pushBack [_position, _text];
	} forEach campList;
	[_saveName, "FIAcampsData", _FIAcampsData] call fn_SaveStat;

	[_saveName, "destroyedBuildings", destroyedBuildings] call fn_SaveStat;
};

AS_fnc_loadMarkers = {
	params ["_saveName"];
	{
		server setVariable [_x select 0,_x select 1,true];
	} forEach ([_saveName, "AAFbasesStatus"] call AS_fnc_LoadStat);

	FIA_RB_list = [];
	FIA_WP_list = [];
	{
		_mrk = createMarker [format ["FIApost%1", random 1000], _x];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "loc_bunker";
		_mrk setMarkerColor "ColorYellow";
		if (isOnRoad _x) then {
			_mrk setMarkerText "FIA Roadblock";
			FIA_RB_list pushBackUnique _mrk;
		} else {
			_mrk setMarkerText "FIA Watchpost";
			FIA_WP_list pushBackUnique _mrk;
		};
		spawner setVariable [_mrk,false,true];
		puestosFIA pushBack _mrk;
	} forEach ([_saveName, "FIAoutpostPositions"] call AS_fnc_LoadStat);
	publicVariable "FIA_RB_list";
	publicVariable "FIA_WP_list";

	// campList contains pairs [markerName, campPosition].
	// campsFIA is a list of markerName.
	// usedCN is the list of used names.
	campsFIA = [];
	campList = [];
	usedCN = [];
	{
		private _position = (_x select 0);
		private _name = (_x select 1);

		private _mrk = createMarker [format ["FIACamp%1", random 1000], _position];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "loc_bunker";
		_mrk setMarkerColor "ColorOrange";
		_mrk setMarkerText _txt;
		usedCN pushBackUnique _txt;
		spawner setVariable [_mrk,false,true];
		campList pushBack [_mrk, _txt];
		campsFIA pushBack _mrk;
	} forEach ([_saveName, "FIAcampsData"] call fn_LoadStat);

	publicVariable "campFIA";
	publicVariable "campList";

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

	// these are public, but will still be modified before exposing.
	// See saveServer.sqf.
	mrkAAF = [_saveName, "mrkAAF"] call fn_LoadStat;
	mrkFIA = ([_saveName, "mrkFIA"] call fn_LoadStat) + puestosFIA;

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
["minas","mineFieldMrk","estaticas","cuentaCA","fecha","garrison","tasks"];

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
			if(_varName == 'garrison') exitWith
				{
				_marcadores = mrkFIA - puestosFIA - controles - ciudades;
				_garrison = _varvalue;
				for "_i" from 0 to (count _marcadores - 1) do
					{
					garrison setVariable [_marcadores select _i,_garrison select _i,true];
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

call compile preprocessFileLineNumbers "statSave\cityAttrs.sqf";

saveFuncsLoaded = true;
