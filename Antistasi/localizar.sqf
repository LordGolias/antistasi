private ["_pos","_sitio","_ciudad","_texto"];

_sitio = _this select 0;

_pos = getMarkerPos _sitio;

_texto = "";

if (_sitio in colinas) then {_texto = format ["Observation Post at Mount %1",[_sitio,false] call AS_fnc_getLocationName]}
else
{
if (_sitio in ciudades) then {_texto = format ["%1",[_sitio,false] call AS_fnc_getLocationName]}
else
{
_ciudad = [ciudades,_pos] call BIS_fnc_nearestPosition;
_ciudad = [_ciudad,false] call AS_fnc_getLocationName;
if (_sitio in power) then {_texto = format ["Powerplant near %1",_ciudad]};
if (_sitio in bases) then {_texto = format ["%1 Base",_ciudad]};
if (_sitio in aeropuertos) then {_texto = format ["%1 Airport",_ciudad]};
if (_sitio in recursos) then {_texto = format ["Resource near %1",_ciudad]};
if (_sitio in fabricas) then {_texto = format ["Factory near %1",_ciudad]};
if ((_sitio in puestos) or (_sitio in colinas))then {_texto = format ["Outpost near %1",_ciudad]};
if (_sitio in puertos) then {_texto = format ["Seaport near %1",_ciudad]};
if (_sitio in controles) then {_texto = format ["Roadblock near %1",_ciudad]};
};
};
_texto