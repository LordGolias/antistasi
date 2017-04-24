#include "macros.hpp"
AS_SERVER_ONLY("resourcesAAF.sqf");
if (!isPlayer AS_commander) exitWith {};

private ["_resourcesAAF","_coste"];

waitUntil {sleep 5; isNil "AS_resourcesIsChanging"};
AS_resourcesIsChanging = true;
_coste = _this select 0;

if (isNil "_coste") then {_coste = 0};

_resourcesAAF = AS_P("resourcesAAF");
_resourcesAAF = _resourcesAAF + _coste;
if (_resourcesAAF < 0) then {_resourcesAAF = 0};
AS_Pset("resourcesAAF",_resourcesAAF);
AS_resourcesIsChanging = nil;
