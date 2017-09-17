#include "../../macros.hpp"

if (AS_P("resourcesFIA") < 5000) exitWith {
    hint "You do not have enough money to rebuild any Asset. You need 5.000 €"
};
closeDialog 0;

// todo: add helper markers
openMap true;
posicionTel = [];
hint "Select the location you want to rebuild.";

onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
onMapSingleClick "";
private _posicionTel = +posicionTel;
posicionTel = nil;

if (count _posicionTel == 0) exitWith {hint "Canceled."};

private _location = _posicionTel call AS_location_fnc_nearest;
private _position = _location call AS_location_fnc_position;
private _type = _location call AS_location_fnc_position;
private _side = _location call AS_location_fnc_side;

if (_position distance _posicionTel > 50) exitWith {hint "You must click near a map marker"};
if not (_type in ["powerplant","factory","resource"]) exitWith {hint "You can only rebuild power plants, factories and resource locations."};
if not (_side == "FIA") exitWith {hint "You can only rebuild locations you control"};
if not (_location in AS_P("destroyedLocations")) exitWith {hint "Chosen location is not destroyed"};

[_location] remoteExec ["AS_fnc_rebuildLocation", 2];
hint format ["%1 rebuilt", [_location] call AS_fnc_location_name];
