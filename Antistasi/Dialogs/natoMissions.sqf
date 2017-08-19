#include "../macros.hpp"
params ["_missionType"];

if (count (_missionType call AS_fnc_active_missions) != 0) exitWith {
	hint "NATO is already busy with this kind of mission";
};
if (!([player] call hasRadio)) exitWith {
	hint "You need a radio in your inventory to be able to give orders to other squads";
};

private _bases = [["base"], "FIA"] call AS_fnc_location_TS;
private _airfields = [["airfield"], "FIA"] call AS_fnc_location_TS;

if (_missionType in ["nato_artillery", "nato_armor", "nato_roadblock"] and (count _bases == 0)) exitWith {
	hint "You need to capture at least one base to perform this action";
};

private _get_mapPosition = {
	posicionTel = [];
	openMap true;
	onMapSingleClick "posicionTel = _pos;";
	waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
	onMapSingleClick "";
	openMap false;
	private _posicionTel =+ posicionTel;
	posicionTel = nil;
	_posicionTel
};

private _requiredSupport = 5;
private _textoHint = "";

switch _missionType do {
	case "nato_uav": {
		_requiredSupport = 5
	};
	case "nato_attack": {
		_requiredSupport = 30;
		_textohint = "Click on the base or airport you want NATO to attack";
	};
	case "nato_armor": {
		_requiredSupport = 30;
		_textohint = "Click on the base from which you want NATO to attack";
	};
	case "nato_ammo": {
		_requiredSupport = 5;
		_textohint = "Click on the spot where you want the ammo drop";
	};
	case "nato_artillery": {
		_requiredSupport = 10;
		_textohint = "Click on the base from which you want Artillery Support";
	};
	case "nato_cas": {
		_requiredSupport = 10;
		_textohint = "Click on the airport from which you want NATO to attack";
	};
	case "nato_roadblock": {
		_requiredSupport = 10;
		_textohint = "Click on the spot where you want NATO to setup a roadblock";
	};
	case "nato_qrf": {
		_requiredSupport = 30;
		_textohint = "Click on the airport from which you want NATO to dispatch a QRF";
	};
};

if (AS_P("NATOsupport") < _requiredSupport) exitWith {
	hint format ["We lack NATO Support for this request (%1 needed)", _requiredSupport];
};

if (_missionType == "nato_uav") exitWith {
	[_missionType, _requiredSupport] remoteExec ["AS_fnc_mission_create", 2];
};

hint format ["%1",_textohint];
private _posicionTel = call _get_mapPosition;
hint "";
if (count _posicionTel == 0) exitWith {};

// roadblock only allowed on roads
if (_missionType == "nato_roadblock") exitWith {
	if not isOnRoad _posicionTel exitWith {
		hint "Roadblocks can only be placed on roads.";
	};
	[_missionType, _requiredSupport, [["position", _posiciontel]]] remoteExec ["AS_fnc_mission_create", 2];
};

if (_missionType == "nato_ammo") exitWith {
	[_missionType, _requiredSupport, [["position", _posiciontel]]] remoteExec ["AS_fnc_mission_create", 2];
};

// below this point all missions require the location nearby the chosen position
private _location = _posicionTel call AS_fnc_location_nearest;
private _position = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;
if (_posicionTel distance _position > 50) exitWith {hint "You must click near a map marker"};

if (_missionType == "nato_qrf") exitWith {
	// default origin
	if not (_location in _airfields) exitWith {
		hint "NATO QRF must start from an airfield";
	};
	hint format ["QRF departing from %1. Mark the target for the QRF.", [_location] call localizar];
	private _destination = call _get_mapPosition;
	if (count _destination == 0) exitWith {};

	[_missionType, _requiredSupport, [["origin", _location], ["destinationPos", _destination]]] remoteExec ["AS_fnc_mission_create", 2];
};

if (_missionType == "nato_artillery") exitWith {
	if (_type != "base") exitWith {
		hint "Artillery support can only be obtained from bases.";
	};
	[_missionType, _requiredSupport, [["origin", _location]]] remoteExec ["AS_fnc_mission_create", 2];
};

hint "Click on a position to position the column on";
private _posicionTel = call _get_mapPosition;
if (count _posicionTel == 0) exitWith {};
private _destination = _posicionTel call AS_fnc_location_nearest;

if (_missionType == "nato_armor") exitWith {
	if not (_location in _bases) exitWith {
		hint "You must select a friendly base";
	};
	[_missionType, _requiredSupport, [["origin", _location], ["destinationPos", _posicionTel]]] remoteExec ["AS_fnc_mission_create", 2];
};

if (_missionType == "nato_attack") exitWith {
	if (_posicionTel distance (_destination call AS_fnc_location_position) > 50) exitWith {
		hint "You must click near a map marker";
	};
	if !(_type in ["base", "outpost", "airfield", "outpostAA"]) exitWith {
		hint "NATO will not attack this type of location."
	};
	private _side = _destination call AS_fnc_location_side;
	if (_side == "FIA") exitWith {
		hint "NATO Attacks may be only ordered on AAF locations"
	};
	[_missionType, _requiredSupport, [["origin", _location], ["destination", _destination]]] remoteExec ["AS_fnc_mission_create", 2];
};
