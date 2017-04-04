if (!isServer) exitWith {};
params ["_saveName"];

petros allowdamage false;

[_saveName] call AS_fnc_loadPersistents;
[_saveName] call AS_fnc_loadArsenal;
[true] call fnc_MAINT_arsenal;

[_saveName, "campList"] call fn_LoadStat; publicVariable "campList";
[_saveName, "campsFIA"] call fn_LoadStat; publicVariable "campsFIA";
[_saveName, "puestosFIA"] call fn_LoadStat; publicVariable "puestosFIA";
[_saveName, "mrkFIA"] call fn_LoadStat; mrkFIA = mrkFIA + puestosFIA; publicVariable "mrkFIA";
[_saveName, "mrkAAF"] call fn_LoadStat;
[_saveName, "destroyedCities"] call fn_LoadStat;
[_saveName, "minas"] call fn_LoadStat;
[_saveName, "cuentaCA"] call fn_LoadStat;
[_saveName, "antenas"] call fn_LoadStat;
[_saveName, "planesAAFcurrent"] call fn_LoadStat;
[_saveName, "helisAAFcurrent"] call fn_LoadStat;
[_saveName, "APCAAFcurrent"] call fn_LoadStat;
[_saveName, "tanksAAFcurrent"] call fn_LoadStat;
[_saveName, "fecha"] call fn_LoadStat;
[_saveName, "garrison"] call fn_LoadStat;
[_saveName, "skillAAF"] call fn_LoadStat;
[_saveName, "distanciaSPWN"] call fn_LoadStat;
[_saveName, "civPerc"] call fn_LoadStat;
[_saveName, "minimoFPS"] call fn_LoadStat;
[_saveName, "smallCAmrk"] call fn_LoadStat;
[_saveName, "miembros"] call fn_LoadStat;
[_saveName, "vehInGarage"] call fn_LoadStat;
[_saveName, "destroyedBuildings"] call fn_LoadStat;
[_saveName, "idleBases"] call fn_LoadStat;

_marcadores = mrkFIA + mrkAAF + campsFIA;

// sets ownership of locations.
{
_posicion = getMarkerPos _x;
_cercano = [_marcadores,_posicion] call BIS_fnc_nearestPosition;
if (_cercano in mrkFIA) then
	{
	mrkAAF = mrkAAF - [_x];
	mrkFIA = mrkFIA + [_x];
	}
else
	{
	mrkAAF = mrkAAF + [_x];
	};
} forEach controles;

// remaining markers is AAF.
{
	if ((not(_x in mrkAAF)) and (not(_x in mrkFIA)) and (_x != "FIA_HQ")) then {
		mrkAAF pushBack _x
	};
} forEach marcadores;

_marcadores = _marcadores + controles;

// sets markers depending on ownership, blackouts cities resources and factories, destroys stuff.
{
if (_x in mrkFIA) then
	{
	private ["_mrkD"];
	if (_x != "FIA_HQ") then
		{
		_mrkD = format ["Dum%1",_x];
		_mrkD setMarkerColor "colorBLUFOR";
		};
	if (_x in aeropuertos) then
		{
		_mrkD setMarkerText format ["FIA Airport: %1",count (garrison getVariable _x)];
		_mrkD setMarkerType "flag_FIA";
		planesAAFmax = planesAAFmax - 1;
	    helisAAFmax = helisAAFmax - 2;
	    };
	if (_x in bases) then
		{
		_mrkD setMarkerText format ["FIA Base: %1",count (garrison getVariable _x)];
		_mrkD setMarkerType "flag_FIA";
		APCAAFmax = APCAAFmax - 2;
    	tanksAAFmax = tanksAAFmax - 1;
		};
	if (_x in puestos) then
		{
		_mrkD setMarkerText format ["FIA Outpost: %1",count (garrison getVariable _x)];
		};
	if (_x in ciudades) then
		{
		_power = [power, getMarkerPos _x] call BIS_fnc_nearestPosition;
		if ((not (_power in mrkFIA)) or (_power in destroyedCities)) then
			{
			[_x,false] spawn apagon;
			};
		if (_x in destroyedCities) then {[_x] call destroyCity};
		};
	if ((_x in recursos) or (_x in fabricas)) then
		{
		if (_x in recursos) then {_mrkD setMarkerText format ["Resource: %1",count (garrison getVariable _x)]} else {_mrkD setMarkerText format ["Factory: %1",count (garrison getVariable _x)]};
		
		_power = [power, getMarkerPos _x] call BIS_fnc_nearestPosition;
		if ((not (_power in mrkFIA))  or (_power in destroyedCities)) then
			{
			[_x,false] spawn apagon;
			};
		if (_x in destroyedCities) then {[_x] call destroyCity};
		};
	if (_x in puertos) then
		{
		_mrkD setMarkerText format ["Sea Port: %1",count (garrison getVariable _x)];
		};
	if (_x in power) then
		{
		_mrkD setMarkerText format ["Power Plant: %1",count (garrison getVariable _x)];
		if (_x in destroyedCities) then {[_x] call destroyCity};
		};
	};

if (_x in mrkAAF) then
	{
	if (_x in ciudades) then
		{
		_power = [power, getMarkerPos _x] call BIS_fnc_nearestPosition;
		if ((not (_power in mrkAAF))  or (_power in destroyedCities)) then
			{
			[_x,false] spawn apagon;
			};
		if (_x in destroyedCities) then {[_x] call destroyCity};
		};
	if ((_x in recursos) or (_x in fabricas)) then
		{
		_power = [power, getMarkerPos _x] call BIS_fnc_nearestPosition;
		if ((not (_power in mrkAAF))  or (_power in destroyedCities)) then
			{
			[_x,false] spawn apagon;
			};
		if (_x in destroyedCities) then {[_x] call destroyCity};
		};
	if ((_x in power) and (_x in destroyedCities)) then {[_x] call destroyCity};
	};


} forEach _marcadores;

{
	if (not (_x in _marcadores)) then {
		if (_x != "FIA_HQ") then {
			_marcadores pushBack _x;
			mrkAAF pushback _x;
		} else {
			mrkAAF = mrkAAF - ["FIA_HQ"];
			mrkFIA pushBackUnique "FIA_HQ";
		}
	}
} forEach marcadores;//por si actualizo zonas.

marcadores = _marcadores;
publicVariable "marcadores";
publicVariable "mrkAAF";
publicVariable "mrkFIA";

[_saveName] call AS_fnc_loadHQ;
[_saveName, "estaticas"] call fn_LoadStat;//tiene que ser el último para que el sleep del borrado del contenido no haga que despawneen

//call AAFassets;

if (isMultiplayer) then {
	{
        _jugador = _x;
        if ([_jugador] call isMember) then
            {
            {_jugador removeMagazine _x} forEach magazines _jugador;
            {_jugador removeWeaponGlobal _x} forEach weapons _jugador;
            removeBackpackGlobal _jugador;
            };
        _pos = (getMarkerPos "respawn_west") findEmptyPosition [2, 10, typeOf (vehicle _jugador)];
        _jugador setPos _pos;
	} forEach playableUnits;

    call AS_fnc_loadPlayers;

} else {
	{player removeMagazine _x} forEach magazines player;
	{player removeWeaponGlobal _x} forEach weapons player;
	removeBackpackGlobal player;

	_pos = (getMarkerPos "respawn_west") findEmptyPosition [2, 10, typeOf (vehicle player)];
	player setPos _pos;
};

[_saveName, "BE_data"] call fn_LoadStat;

diag_log format ['[AS] Server: game "%1" loaded', _saveName];
petros allowdamage true;

// resume existing attacks in 25 seconds.
[_saveName] spawn {
    params ["_saveName"];
    sleep 25;
    [_saveName, "tasks"] call fn_LoadStat;

    _tmpCAmrk = + smallCAmrk;
    smallCAmrk = [];

    {
    _base = [_x] call findBasesForCA;
    //if (_x == "puesto_13") then {_base = ""};
    _radio = [_x] call radioCheck;
    if ((_base != "") and (_radio) and (_x in mrkFIA) and (not(_x in smallCAmrk))) then
        {
        [_x] remoteExec ["patrolCA",HCattack];
        smallCAmrk pushBackUnique _x;
        };
    } forEach _tmpCAmrk;
    publicVariable "smallCAmrk";
};
