if (!isServer) exitWith {};

if (savingServer) exitWith {"Server data save is still in process" remoteExecCall ["hint",AS_commander]};
savingServer = true;

call AS_fnc_savePlayers;

	["cuentaCA", cuentaCA] call fn_SaveStat;
	["smallCAmrk", smallCAmrk] call fn_SaveStat;
	["miembros", miembros] call fn_SaveStat;
	["antenas", antenasmuertas] call fn_SaveStat;
	["mrkAAF", mrkAAF - controles] call fn_SaveStat;
	["mrkFIA", mrkFIA - puestosFIA - controles] call fn_SaveStat;
	["APCAAFcurrent", APCAAFcurrent] call fn_SaveStat;
	["tanksAAFcurrent",tanksAAFcurrent] call fn_SaveStat;
	["planesAAFcurrent", planesAAFcurrent] call fn_SaveStat;
	["helisAAFcurrent", helisAAFcurrent] call fn_SaveStat;
	["fecha", date] call fn_SaveStat;
	["skillAAF", skillAAF] call fn_SaveStat;
	["destroyedCities", destroyedCities] call fn_SaveStat;
	["destroyedBuildings", destroyedBuildings] call fn_SaveStat;
	["distanciaSPWN", distanciaSPWN] call fn_SaveStat;
	["civPerc", civPerc] call fn_SaveStat;
	["minimoFPS", minimoFPS] call fn_SaveStat;
	["vehInGarage", vehInGarage] call fn_SaveStat;

	["BE_data", ([] call fnc_BE_save)] call fn_SaveStat;

[] call AS_fnc_saveHQ;

private ["_hrfondo","_resfondo","_veh","_tipoVeh","_contenedores","_arrayEst","_posVeh","_dierVeh","_prestigeOPFOR","_prestigeBLUFOR","_ciudad","_datos","_marcadores","_garrison","_arrayMrkMF","_arrayPuestosFIA","_pospuesto","_tipoMina","_posMina","_detectada","_tipos","_exists","_amigo","_arrayCampsFIA","_enableFTold","_enableMemAcc","_campList"];


// save all units as hr and money.

_resfondo = server getVariable "resourcesFIA";
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
					_precio = server getVariable (typeOf _amigo);
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

_hrfondo = (server getVariable "hr") + ({(alive _x) and (not isPlayer _x) and (_x getVariable ["BLUFORSpawn",false])} count allUnits);
[["resourcesFIA", "hr"], [_resfondo, _hrfondo]] call AS_fnc_saveServer;

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


["estaticas", _arrayEst] call fn_SaveStat;

[_cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_saveArsenal;

_marcadores = mrkFIA - puestosFIA - controles - ciudades;
_garrison = [];
{
_garrison = _garrison + [garrison getVariable [_x,[]]];
} forEach _marcadores;

["garrison",_garrison] call fn_SaveStat;

_arrayMinas = [];
{
_tipoMina = typeOf _x;
_posMina = getPos _x;
_dirMina = getDir _x;
_detectada = false;
if (_x mineDetectedBy side_blue) then {_detectada = true};
_arrayMinas = _arrayMinas + [[_tipoMina,_posMina,_detectada,_dirMina]];
} forEach allMines;

["minas", _arrayMinas] call fn_SaveStat;

_arraypuestosFIA = [];

{
_pospuesto = getMarkerPos _x;
_arraypuestosFIA = _arraypuestosFIA + [_pospuesto];
} forEach puestosFIA;

["puestosFIA", _arraypuestosFIA] call fn_SaveStat;

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

["campList", _campList] call fn_SaveStat;

_arrayCampsFIA = [];
{
_pospuesto = getMarkerPos _x;
_arrayCampsFIA = _arrayCampsFIA + [_pospuesto];
} forEach campsFIA;

["campsFIA", _arrayCampsFIA] call fn_SaveStat;

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

["idleBases",_datos] call fn_SaveStat;

[] call fn_SaveProfile;

savingServer = false;

_text = "Savegame Done.\n\nYou won't lose your stats in the event of a game update.\n\nRemember: if you want to preserve any vehicle, it must be near the HQ Flag with no AI inside.\nIf AI inside, you will save the funds you spent on it.\n\nAI will be refunded\n\nStolen and purchased Static Weapons need to be ASSEMBLED in order to get saved. Disassembled weapons may get saved in your ammobox\n\nMounted Statics (Mortar/AA/AT squads) won't get saved, but you will be able to recover the cost.\n\nSame for assigned vehicles more than 50 mts far from HQ";
[petros,"save",_text] remoteExec ["commsMP",AS_commander];
diag_log "[AS] server: game saved.";