#include "macros.hpp"
private ["_resourcesAAF","_prestigeCSAT","_coste","_destroyedCities","_destroyed","_nombre"];

_resourcesAAF = AS_P("resourcesAAF");

_prestigeCSAT = AS_P("prestigeCSAT");

waitUntil {!resourcesIsChanging};
resourcesIsChanging = true;

_multiplicador = 1;

if (!isMultiplayer) then {_multiplicador = 2};

_cuenta = count (mrkFIA - puestosFIA - ["FIA_HQ"] - ciudades);

if (_resourcesAAF > 5000) then
	{
	_destroyedCities = destroyedCities - mrkFIA - ciudades;
	if (count _destroyedCities > 0) then
		{
		{
		_destroyed = _x;
		if ((_resourcesAAF > 5000) and (not(spawner getVariable _destroyed))) then
			{
			_resourcesAAF = _resourcesAAF - 5000;
			destroyedCities = destroyedCities - [_destroyed];
			publicVariable "destroyedCities";
			[10,0,getMarkerPos _destroyed] remoteExec ["citySupportChange",2];
			[-5,0] remoteExec ["prestige",2];
			if (_destroyed in power) then {[_destroyed] call powerReorg};
			_nombre = [_destroyed] call localizar;
			[["TaskFailed", ["", format ["%1 rebuilt by AAF",_nombre]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			};
		} forEach _destroyedCities;
		}
	else
		{
		if ((count antenasMuertas > 0) and (not("REP" in misiones))) then
			{
			{
			if ((_resourcesAAF > 5000) and (not("REP" in misiones))) then
				{
				_marcador = [marcadores, _x] call BIS_fnc_nearestPosition;
				if ((_marcador in mrkAAF) and (not(spawner getVariable _marcador))) then
					{
					[_marcador,_x] remoteExec ["REP_Antena",HCattack];
					_resourcesAAF = _resourcesAAF - (5000*_multiplicador);
					};
				};
			} forEach antenasMuertas;
			};
		};
	};

if (_cuenta == 0) exitWith {resourcesIsChanging = false};

if (((planesAAFcurrent < planesAAFmax) and (helisAAFcurrent > 3)) and (_cuenta > 6)) then
	{
	if (_resourcesAAF > (17500*_multiplicador)) then
		{
		if (count planesAAF < 2) then {
			planesAAF = planesAAF + planes;
			publicVariable "planesAAF"
			};
		planesAAFcurrent = planesAAFcurrent + 1;
		publicVariable "planesAAFcurrent";
		_resourcesAAF = _resourcesAAF - (17500*_multiplicador);
		};
	};
if (((tanksAAFcurrent < tanksAAFmax) and (APCAAFcurrent > 3)) and (_cuenta > 5) and (planesAAFcurrent != 0)) then
	{
	if (_resourcesAAF > (10000*_multiplicador)) then
		{
		_length = count (vehAAFAT - vehTank);
		if (_length == count vehAAFAT) then {
			vehAAFAT = vehAAFAT + vehTank;
			publicVariable "vehAAFAT";
			};
		tanksAAFcurrent = tanksAAFcurrent + 1; publicVariable "tanksAAFcurrent";
	    _resourcesAAF = _resourcesAAF - (10000*_multiplicador);
		};
    };
if (((helisAAFcurrent < helisAAFmax) and ((helisAAFcurrent < 4) or (planesAAFcurrent > 3))) and (_cuenta > 3)) then
	{
	if (_resourcesAAF > (10000*_multiplicador)) then
		{
		_length = count (planesAAF - heli_armed);
		if (_length == count planesAAF) then {
			planesAAF = planesAAF + heli_armed;
			publicVariable "planesAAF"
			};
		helisAAFcurrent = helisAAFcurrent + 1; publicVariable "helisAAFcurrent";
		_resourcesAAF = _resourcesAAF - (7000*_multiplicador);
		};
	};
if ((APCAAFcurrent < APCAAFmax) and ((tanksAAFcurrent > 2) or (APCAAFcurrent < 4)) and (_cuenta > 2)) then
	{
	if (_resourcesAAF > (5000*_multiplicador)) then
		{
		_length = count (vehAAFAT - vehAPC);
		if (_length == count vehAAFAT) then {
	        vehAAFAT = vehAAFAT +  vehAPC;
			publicVariable "vehAAFAT";
	        };
		_length = count (vehAAFAT - vehIFV);
	    if (_length == count vehAAFAT) then {
	        vehAAFAT = vehAAFAT +  vehIFV;
			publicVariable "vehAAFAT";
	        };
	    APCAAFcurrent = APCAAFcurrent + 1; publicVariable "APCAAFcurrent";
	    _resourcesAAF = _resourcesAAF - (5000*_multiplicador);
		};
	};

_skillFIA = AS_P("skillFIA");
_skillAAF = AS_P("skillAAF");
if ((_skillAAF < (_skillFIA + 4)) && (_skillAAF < AS_maxSkill)) then {
	_coste = 1000 + (1.5*(_skillAAF *750));
	if (_coste < _resourcesAAF) then {
        AS_Pset("skillAAF",_skillAAF + 1);
        _skillAAF = _skillAAF + 1;
		_resourcesAAF = _resourcesAAF - _coste;
		{
			_coste = AS_data_allCosts getVariable _x;
			_coste = round (_coste + (_coste * (_skillAAF/280)));
			AS_data_allCosts setVariable [_x,_coste,true];
		} forEach soldadosAAF;
	};
};

if (_resourcesAAF > 2000) then
	{
	{
	if (_resourcesAAF < 2000) exitWith {};
	if ([_x] call isFrontline) then
		{
		_cercano = [mrkFIA,getMarkerPos _x] call BIS_fnc_nearestPosition;
		_minefieldDone = false;
		_minefieldDone = [_cercano,_x] call minefieldAAF;
		if (_minefieldDone) then {_resourcesAAF = _resourcesAAF - 2000};
		};
	} forEach (bases - mrkFIA);
	};
_resourcesAAF = round _resourcesAAF;

AS_Pset("resourcesAAF",_resourcesAAF);

resourcesIsChanging = false;