#include "macros.hpp"

if (AS_P("resourcesFIA") < 5000) exitWith {hint "You do not have enough money to rebuild any Asset. You need 5.000 €"};

private _validLocations = ([["powerplant","factory","resource"], "FIA"] call AS_fnc_location_TS) arrayIntersect destroyedCities;

openMap true;
posicionTel = [];
hint "Click on the location you want to rebuild.";

onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
onMapSingleClick "";

if (count posicionTel == 0) exitWith {};

private _posicionTel = +posicionTel;
posicionTel = nil;

private _location = _posicionTel call AS_fnc_location_nearest;
private _position = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_position;
private _nombre = [_location] call localizar;

if (_position distance _posicionTel > 50) exitWith {hint "You must click near a map marker"};

if (not(_location in _validLocations)) exitWith {hint "You cannot rebuild destroyed cities."};

hint format ["%1 Rebuilt"];

[0,10,_posicionTel] remoteExec ["citySupportChange",2];
[5,0] remoteExec ["prestige",2];
destroyedCities = destroyedCities - [_location];
publicVariable "destroyedCities";
if (_type == "powerplant") then {[_location] call powerReorg};
[0,-5000] remoteExec ["resourcesFIA",2];
