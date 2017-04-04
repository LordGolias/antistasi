if (!isServer) exitWith {};
params ["_saveName"];

if (savingServer) exitWith {"Server data save is still in process" remoteExecCall ["hint",AS_commander]};
savingServer = true;

// spawn and wait for all clients to report their data.
private _savingPlayersHandle = ([_saveName] spawn {
    params ["_saveName"];
    [] call AS_fnc_getPlayersData;
    // todo: This is bad: we want to wait for every client to answer or timeout.
    sleep 5;  // brute force method of waiting for every client...
    [_saveName] call AS_fnc_savePlayers;
});

[_saveName, "cuentaCA", cuentaCA] call fn_SaveStat;
[_saveName, "smallCAmrk", smallCAmrk] call fn_SaveStat;
[_saveName, "miembros", miembros] call fn_SaveStat;
[_saveName, "antenas", antenasmuertas] call fn_SaveStat;
[_saveName, "mrkAAF", mrkAAF - controles] call fn_SaveStat;
[_saveName, "mrkFIA", mrkFIA - puestosFIA - controles] call fn_SaveStat;
[_saveName, "APCAAFcurrent", APCAAFcurrent] call fn_SaveStat;
[_saveName, "tanksAAFcurrent",tanksAAFcurrent] call fn_SaveStat;
[_saveName, "planesAAFcurrent", planesAAFcurrent] call fn_SaveStat;
[_saveName, "helisAAFcurrent", helisAAFcurrent] call fn_SaveStat;
[_saveName, "fecha", date] call fn_SaveStat;
[_saveName, "skillAAF", skillAAF] call fn_SaveStat;
[_saveName, "destroyedCities", destroyedCities] call fn_SaveStat;
[_saveName, "destroyedBuildings", destroyedBuildings] call fn_SaveStat;
[_saveName, "distanciaSPWN", distanciaSPWN] call fn_SaveStat;
[_saveName, "civPerc", civPerc] call fn_SaveStat;
[_saveName, "minimoFPS", minimoFPS] call fn_SaveStat;
[_saveName, "vehInGarage", vehInGarage] call fn_SaveStat;

[_saveName, "BE_data", ([] call fnc_BE_save)] call fn_SaveStat;

[_saveName] call AS_fnc_saveHQ;

private ["_hrfondo","_resfondo","_veh","_tipoVeh","_contenedores","_arrayEst","_posVeh","_dierVeh","_prestigeOPFOR","_prestigeBLUFOR","_ciudad","_datos","_marcadores","_garrison","_arrayMrkMF","_arrayPuestosFIA","_pospuesto","_tipoMina","_posMina","_detectada","_tipos","_exists","_amigo","_arrayCampsFIA","_enableFTold","_enableMemAcc","_campList"];


// save all units as hr and money.

_resfondo = AS_persistent getVariable "resourcesFIA";
_cargoArray = [caja, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
_cargo_w = _cargoArray select 0;
_cargo_m = _cargoArray select 1;
_cargo_i = _cargoArray select 2;
_cargo_b = _cargoArray select 3;

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
					_precio = AS_data_allCosts getVariable (typeOf _amigo);
					if (!(isNil "_precio")) then {_resfondo = _resfondo + _precio};
				};
				_arsenal = [_amigo, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
				_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
				_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
				_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
				_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
				};
			if (vehicle _amigo != _amigo) then
				{
				_veh = vehicle _amigo;
				_tipoVeh = typeOf _veh;
				if (not(_veh in staticsToSave)) then
					{
					if ((_veh isKindOf "StaticWeapon") or (driver _veh == _amigo)) then
						{
						if ((group _amigo in (hcAllGroups AS_commander)) or (!isMultiplayer)) then
							{
							_resfondo = _resfondo + ([_tipoVeh] call vehiclePrice);
							if (count attachedObjects _veh != 0) then {{_resfondo = _resfondo + ([typeOf _x] call vehiclePrice)} forEach attachedObjects _veh};
							};
						};
					};
				};
			};
		};
	};
} forEach allUnits;

_hrfondo = (AS_persistent getVariable "hr") + ({(alive _x) and (not isPlayer _x) and (_x getVariable ["BLUFORSpawn",false])} count allUnits);
[_saveName, ["resourcesFIA", "hr"], [_resfondo, _hrfondo]] call AS_fnc_savePersistents;

if (isMultiplayer) then {
	{
		_arsenal = [_x, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
		_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
		_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
		_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
		_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
	} forEach playableUnits;
}
else {
	_arsenal = [player, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
	_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
	_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
	_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
	_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
};

// list of locations where static weapons are saved.
_statMrks = [];
{if ((_x in puestos) || (_x in power) || (_x in recursos) || (_x in fabricas) || (_x in puertos) ||  (_x == "FIA_HQ")) then {_statMrks pushBack _x;};} forEach mrkFIA;

// store in "_arrayEst" the list of vehicles.
_arrayEst = [];
{
_veh = _x;
_tipoVeh = typeOf _veh;

_test = [_statMrks, getPos _veh] call BIS_fnc_nearestPosition;
_testDist = _veh distance (getMarkerPos _test);

// saves static weapons everywhere.
if ((_veh isKindOf "StaticWeapon") and (_testDist < 50)) then {
	_posVeh = getPos _veh;
	_dirVeh = getDir _veh;
	_arrayEst = _arrayEst + [[_tipoVeh,_posVeh,_dirVeh]];
};

// saves vehicles close to the HQ.
if (_veh distance getMarkerPos "respawn_west" < 50) then
	{
	if ((not (_veh isKindOf "StaticWeapon")) and 
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
		_dirVeh = getDir _veh;
		_arrayEst = _arrayEst + [[_tipoVeh,_posVeh,_dirVeh]];
		
		_arsenal = [_veh, true] call AS_fnc_getBoxArsenal;  // restricted to locked weapons
		_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
		_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
		_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
		_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
	};
	};
} forEach vehicles - AS_permanent_HQplacements;

[_saveName, "estaticas", _arrayEst] call fn_SaveStat;

[_saveName, _cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_saveArsenal;

_marcadores = mrkFIA - puestosFIA - controles - ciudades;
_garrison = [];
{
_garrison = _garrison + [garrison getVariable [_x,[]]];
} forEach _marcadores;

[_saveName, "garrison",_garrison] call fn_SaveStat;

_arrayMinas = [];
{
_tipoMina = typeOf _x;
_posMina = getPos _x;
_dirMina = getDir _x;
_detectada = false;
if (_x mineDetectedBy side_blue) then {_detectada = true};
_arrayMinas = _arrayMinas + [[_tipoMina,_posMina,_detectada,_dirMina]];
} forEach allMines;

[_saveName, "minas", _arrayMinas] call fn_SaveStat;

_arraypuestosFIA = [];

{
_pospuesto = getMarkerPos _x;
_arraypuestosFIA = _arraypuestosFIA + [_pospuesto];
} forEach puestosFIA;

[_saveName, "puestosFIA", _arraypuestosFIA] call fn_SaveStat;

if (count campList != 0) then {
	_campList = [];
	{
		_posCamp = getMarkerPos (_x select 0);
		_campName = _x select 1;
		_campList = _campList + [[_posCamp, _campName]];
	} forEach campList;
}
else {
	_campList = [];
	{
		_posCamp = getMarkerPos _x;
		_campName = markerText _x;
		_campList = _campList + [[_posCamp, _campName]];
	} forEach campsFIA;
};

[_saveName, "campList", _campList] call fn_SaveStat;

_arrayCampsFIA = [];
{
_pospuesto = getMarkerPos _x;
_arrayCampsFIA = _arrayCampsFIA + [_pospuesto];
} forEach campsFIA;

[_saveName, "campsFIA", _arrayCampsFIA] call fn_SaveStat;

if (!isDedicated) then
	{
	_tipos = [];
	{
	if (_x in misiones) then
		{
		_state = [_x] call BIS_fnc_taskState;
		if (_state == "CREATED") then
			{
			_tipos = _tipos + [_x];
			};
		};
	} forEach ["AS","CON","DES","LOG","RES","CONVOY","DEF_HQ","AtaqueAAF"];

	["tasks",_tipos] call fn_SaveStat;
	};

_datos = [];
{
_datos pushBack [_x,server getVariable _x];
} forEach (aeropuertos + bases);

[_saveName, "idleBases",_datos] call fn_SaveStat;

// if the spawning is faster, let us wait until it is finished.
waitUntil {scriptDone _savingPlayersHandle};

[] call fn_SaveProfile;

savingServer = false;

diag_log "[AS] server: game saved.";
