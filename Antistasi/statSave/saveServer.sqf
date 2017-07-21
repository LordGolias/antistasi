#include "../macros.hpp"
AS_SERVER_ONLY("statSave/saveServer.sqf");
params ["_saveName"];

if (!isNil "AS_savingServer") exitWith {"Server data save is still in process" remoteExecCall ["hint",AS_commander]};
AS_savingServer = true;

// spawn and wait for all clients to report their data.
private _savingPlayersHandle = ([_saveName] spawn {
    params ["_saveName"];
    [] call AS_fnc_getPlayersData;
    // todo: This is bad: we want to wait for every client to answer or timeout.
    sleep 5;  // brute force method of waiting for every client...
    [_saveName] call AS_fnc_savePlayers;
});

[_saveName, "BE_data", ([] call fnc_BE_save)] call fn_SaveStat;

[_saveName, "smallCAmrk", smallCAmrk] call fn_SaveStat;
[_saveName, "miembros", miembros] call fn_SaveStat;
[_saveName, "fecha", date] call fn_SaveStat;

[_saveName] call AS_fnc_saveAAFarsenal;
[_saveName] call AS_fnc_saveMarkers;
[_saveName] call AS_fnc_location_save;
[_saveName] call AS_fnc_saveHQ;

private ["_hrfondo","_resfondo","_veh","_tipoVeh","_contenedores","_arrayEst","_posVeh","_dierVeh","_prestigeOPFOR","_prestigeBLUFOR","_ciudad","_datos","_marcadores","_garrison","_arrayMrkMF","_arrayPuestosFIA","_pospuesto","_tipoMina","_posMina","_detectada","_tipos","_exists","_amigo","_arrayCampsFIA","_enableMemAcc","_campList"];

// save all units as hr and money.

_resfondo = AS_P("resourcesFIA");
private _cargoArray = [caja, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
private _cargo_w = _cargoArray select 0;
private _cargo_m = _cargoArray select 1;
private _cargo_i = _cargoArray select 2;
private _cargo_b = _cargoArray select 3;

{
_amigo = _x;
if (_amigo getVariable ["BLUFORSpawn",false]) then
	{
	if ((alive _amigo) and (!isPlayer _amigo)) then
		{
		if ((isPlayer leader _amigo) or (group _amigo in (hcAllGroups AS_commander)) and (not((group _amigo) getVariable ["esNATO",false]))) then
			{
			if (isPlayer (leader group _amigo)) then
				{
				if (!isMultiplayer) then {
					private _precio = AS_data_allCosts getVariable ([_amigo] call AS_fnc_getFIAUnitNameType);
					if (!(isNil "_precio")) then {_resfondo = _resfondo + _precio};
				};
				private _arsenal = [_amigo, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
				_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
				_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
				_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
				_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
				};
			if (vehicle _amigo != _amigo) then
				{
				_veh = vehicle _amigo;
				_tipoVeh = typeOf _veh;
				if (not(_veh in AS_P("vehicles"))) then
					{
					if ((_veh isKindOf "StaticWeapon") or (driver _veh == _amigo)) then
						{
						if ((group _amigo in (hcAllGroups AS_commander)) or (!isMultiplayer)) then
							{
							_resfondo = _resfondo + ([_tipoVeh] call FIAvehiclePrice);
							if (count attachedObjects _veh != 0) then {{_resfondo = _resfondo + ([typeOf _x] call FIAvehiclePrice)} forEach attachedObjects _veh};
							};
						};
					};
				};
			};
		};
	};
} forEach allUnits;

_hrfondo = AS_P("hr") + ({(alive _x) and (not isPlayer _x) and (_x getVariable ["BLUFORSpawn",false])} count allUnits);
[_saveName, ["resourcesFIA", "hr"], [_resfondo, _hrfondo]] call AS_fnc_savePersistents;

if (isMultiplayer) then {
	{
		private _arsenal = [_x, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
		_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
		_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
		_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
		_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
	} forEach playableUnits;
}
else {
	private _arsenal = [player, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
	_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
	_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
	_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
	_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
};

// list of locations where static weapons are saved.
private _statMrks = [];
{
    _statMrks pushBack _x;
} forEach ("FIA" call AS_fnc_location_S);

// store in "_arrayEst" the list of vehicles.
_arrayEst = [];
{
_veh = _x;
_tipoVeh = typeOf _veh;

private _test = [_statMrks, getPos _veh] call BIS_fnc_nearestPosition;
private _testDist = _veh distance (getMarkerPos _test);

// saves static weapons everywhere.
if ((_veh isKindOf "StaticWeapon") and (_testDist < 50)) then {
	_posVeh = getPos _veh;
	private _dirVeh = getDir _veh;
	_arrayEst = _arrayEst + [[_tipoVeh,_posVeh,_dirVeh]];
};

// saves vehicles close to the HQ.
if (_veh distance getMarkerPos "FIA_HQ" < 50) then
	{
	if (!(_veh isKindOf "StaticWeapon") and
		!(_veh isKindOf "ReammoBox") and
		!(_veh isKindOf "FlagCarrier") and
		!(_veh isKindOf "Building") and
		!(_tipoVeh in planesNATO) and
		!(_tipoVeh in vehNATO) and
		!(_tipoVeh == "C_Van_01_box_F") and
		(count attachedObjects _veh == 0) and
		(alive _veh) and
		({(alive _x) and (!isPlayer _x)} count crew _veh == 0) and
		!(_tipoVeh == "WeaponHolderSimulated")) then {
		_posVeh = getPos _veh;
		private _dirVeh = getDir _veh;
		_arrayEst = _arrayEst + [[_tipoVeh,_posVeh,_dirVeh]];

		private _arsenal = [_veh, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
		_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
		_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
		_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
		_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
	};
	};
} forEach vehicles - AS_permanent_HQplacements;

[_saveName, "estaticas", _arrayEst] call fn_SaveStat;

[_saveName, _cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_saveArsenal;

if (!isDedicated) then
	{
	_tipos = [];
	{
	if (_x in misiones) then
		{
		private _state = [_x] call BIS_fnc_taskState;
		if (_state == "CREATED") then
			{
			_tipos = _tipos + [_x];
			};
		};
	} forEach ["AS","CON","DES","LOG","RES","CONVOY","DEF_HQ","AtaqueAAF"];

	["tasks",_tipos] call fn_SaveStat;
	};

// if the spawning is faster, let us wait until it is finished.
waitUntil {scriptDone _savingPlayersHandle};

[] call fn_SaveProfile;

AS_savingServer = nil;

diag_log "[AS] server: game saved.";
