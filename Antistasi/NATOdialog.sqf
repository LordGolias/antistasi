#include "macros.hpp"
params ["_type"];

if (!allowPlayerRecruit) exitWith {hint "Server is very loaded. \nWait one minute or change FPS settings in order to fulfill this request"};
if (count (_type call AS_fnc_active_missions) != 0) exitWith {hint "NATO is already busy with this kind of mission"};
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};

private _bases = [["base"], "FIA"] call AS_fnc_location_TS;
private _aeropuertos = [["airfield"], "FIA"] call AS_fnc_location_TS;

if (_type in ["NATOArty", "NATOArmor", "NATORoadblock"] and (count _bases == 0)) exitWith {
	hint "You need to conquer at least one base to perform this action"
};

_costeNATO = 5;
_textoHint = "";

switch (_type) do {
	case "NATOCA": {
		_costeNATO = 20;
		_textohint = "Click on the base or airport you want NATO to attack";
	};
	case "NATOArmor": {
		_costeNATO = 20;
		_textohint = "Click on the base from which you want NATO to attack";
	};
	case "NATOAmmo": {
		_costeNATO = 5;
		_textohint = "Click on the spot where you want the Ammodrop";
	};
	case "NATOArty": {
		_costeNATO = 10;
		_textohint = "Click on the base from which you want Artillery Support";
	};
	case "NATOCAS": {
		_costeNATO = 10;
		_textohint = "Click on the airport from which you want NATO to attack";
	};
	case "NATORoadblock": {
		_costeNATO = 10;
		_textohint = "Click on the spot where you want NATO to setup a roadblock";
	};
	case "NATOQRF": {
		_costeNATO = 10;
		_textohint = "Click on the base or airport/carrier from which you want NATO to dispatch a QRF";
	};
};

_NATOSupp = AS_P("NATOsupport");

if (_NATOSupp < _costeNATO) exitWith {hint format ["We lack of enough NATO Support in order to proceed with this request (%1 needed)",_costeNATO]};

if (_type == "NATOCAS") exitWith {};
if (_type == "NATOUAV") exitWith {[] remoteExec [_type,HCattack]};

posicionTel = [];

hint format ["%1",_textohint];

openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

_posicionTel =+ posicionTel;
if ((_type != "NATOArmor") or (_type == "NATORoadblock")) then {openMap false};

// break, in case no valid point of origin was selected
_salir = false;

// location for the QRF to depart from -- default: NATO carrier
_loc = "spawnNATO";


// roadblocks, only allowed on roads
if (_type == "NATORoadblock") exitWith {
	_check = isOnRoad _posicionTel;
	if !(_check) exitWith {hint "Roadblocks can only be placed on roads."};
	[_posicionTel] remoteExec [_type,HCattack];
};

if (_type == "NATOAmmo") exitWith {[_posiciontel,_NATOSupp] remoteExec [_type, HCattack]};

private _location = _posicionTel call AS_fnc_location_nearest;
private _position = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
private _side = _location call AS_fnc_location_side;

if (_type == "NATOQRF") exitWith {
	_sitioName = "the NATO carrier";
	if (_type in ["base", "arfield"]) then {
		_loc = _location;
		_sitioName = [_location] call localizar;
	};

	posicionTel = [];
	hint format ["QRF departing from %1. Mark the target for the QRF.",_sitioName];

	openMap true;
	onMapSingleClick "posicionTel = _pos;";

	waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
	onMapSingleClick "";

	if (!visibleMap) exitWith {};

	_destino =+ posicionTel;
	openMap false;

	if (surfaceIsWater _destino) exitWith {hint "No LCS available this decade, QRF is restricted to land."};
	hint "QRF inbound.";
	[_loc,_destino] remoteExec ["NATOQRF",HCattack];
};

if (_posicionTel distance _position > 50) exitWith {hint "You must click near a map marker"};

if (_type == "NATOArty") exitWith {
	if (_type != "base") exitWith {hint "Artillery support can only be obtained from bases."};
	[_location] remoteExec ["NATOArty", HCattack];
};

if (_type == "NATOArmor") then {
	if (_type != "base") then {
		_salir = true;
		hint "You must click near a friendly base";
	}
	else {
		posicionTel = [];
		hint "Click on the Armored Column destination";

		openMap true;
		onMapSingleClick "posicionTel = _pos;";

		waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
		onMapSingleClick "";

		if (!visibleMap) then {_salir = true};

		_posicionTel =+ posicionTel;
		openMap false;
		_destino = _posicionTel call AS_fnc_location_nearest;
		if (_posicionTel distance (_destino call AS_fnc_location_position) > 50) then {
			hint "You must click near a map marker";
			_salir = true
		}
		else {
			[[_location,_destino], "CREATE\NATOArmor.sqf"] remoteExec ["execVM",HCattack];
		};
	};
};

if (_type == "NATOCA") then {
	if !(_type in ["base", "outpost", "airfield", "outpostAA"]) then {_salir = true; hint "NATO won't attack this kind of zone."};
	if (_side == "FIA") then {_salir = true; hint "NATO Attacks may be only ordered on AAF controlled zones"};
};

if (_salir) exitWith {};

if (_type == "NATOCA") then {
	[_location] remoteExec [_type,HCattack];
};
