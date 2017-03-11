private ["_marcador","_mrkD"];

_marcador = _this select 0;


_mrkD = format ["Dum%1",_marcador];
if (markerColor _mrkD != "colorBLUFOR") then {_mrkD setMarkerColor "colorBLUFOR"};

if (_marcador in aeropuertos) then {_mrkD setMarkerText format ["FIA Airport: %1",count (garrison getVariable _marcador)];_mrkD setMarkerType "flag_FIA"} else {
if (_marcador in puestos) then {_mrkD setMarkerText format ["FIA Outpost: %1",count (garrison getVariable _marcador)]} else {
if (_marcador in bases) then {_mrkD setMarkerText format ["FIA Base: %1",count (garrison getVariable _marcador)];_mrkD setMarkerType "flag_FIA"} else {
if (_marcador in recursos) then {_mrkD setMarkerText format ["Resource: %1",count (garrison getVariable _marcador)]} else {
if (_marcador in fabricas) then {_mrkD setMarkerText format ["Factory: %1",count (garrison getVariable _marcador)]} else {
if (_marcador in puertos) then {_mrkD setMarkerText format ["Sea Port: %1",count (garrison getVariable _marcador)]} else {
if (_marcador in power) then {_mrkD setMarkerText format ["Power Plant: %1",count (garrison getVariable _marcador)]};
		};};};};};};
