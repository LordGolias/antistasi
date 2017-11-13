#include "../../macros.hpp"
params ["_missionType"];

#define MIN_DISTANCE_FOR_SELECTION 200

if (count (_missionType call AS_mission_fnc_active_missions) != 0) exitWith {
	hint (AS_NATOname + " is already busy with this kind of mission");
};
if (!([player] call AS_fnc_hasRadio)) exitWith {
	hint "You need a radio in your inventory to be able to give orders to other squads";
};

private _bases = [["base"], "FIA"] call AS_location_fnc_TS;
private _airfields = [["airfield"], "FIA"] call AS_location_fnc_TS;

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
		_requiredSupport = 10
	};
	case "nato_attack": {
		_requiredSupport = 30;
		_textohint = format ["Click on location you want %1 to attack", AS_NATOname];
	};
	case "nato_armor": {
		_requiredSupport = 30;
		_textohint = "Click on the location you want the armor to stay";
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
		_textohint = format ["Click on the airport from which you want %1 to attack", AS_NATOname];
	};
	case "nato_roadblock": {
		_requiredSupport = 10;
		_textohint = format ["Click on the spot where you want %1 to setup a roadblock", AS_NATOname];
	};
	case "nato_qrf": {
		_requiredSupport = 30;
		_textohint = format ["Click on the airport from which you want %1 to dispatch a QRF", AS_NATOname];
	};
};

if (AS_P("NATOsupport") < _requiredSupport) exitWith {
	hint format ["We lack %1 Support for this request (%2 needed)", AS_NATOname, _requiredSupport];
};

if (_missionType == "nato_uav") exitWith {
	[_missionType, _requiredSupport] remoteExec ["AS_mission_fnc_create", 2];
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
	[_missionType, _requiredSupport, [["position", _posiciontel]]] remoteExec ["AS_mission_fnc_create", 2];
};

if (_missionType == "nato_ammo") exitWith {
	[_missionType, _requiredSupport, [["position", _posiciontel]]] remoteExec ["AS_mission_fnc_create", 2];
};

// below this point all missions require the location nearby the chosen position
private _location = _posicionTel call AS_location_fnc_nearest;
private _position = _location call AS_location_fnc_position;
private _type = _location call AS_location_fnc_type;
if (_posicionTel distance _position > MIN_DISTANCE_FOR_SELECTION) exitWith {
	hint "You must select a location";
};

if (_missionType == "nato_qrf") exitWith {
	// default origin
	if not (_location in _airfields) exitWith {
		hint (AS_NATOname + " QRF must start from an airfield");
	};
	hint format ["QRF departing from %1. Mark the target for the QRF.", [_location] call AS_fnc_location_name];
	private _destination = call _get_mapPosition;
	if (count _destination == 0) exitWith {};

	[_missionType, _requiredSupport, [["origin", _location], ["destinationPos", _destination]]] remoteExec ["AS_mission_fnc_create", 2];
};

if (_missionType == "nato_artillery") exitWith {
	if (_type != "base") exitWith {
		hint "Artillery support can only be obtained from bases.";
	};
	[_missionType, _requiredSupport, [["origin", _location]]] remoteExec ["AS_mission_fnc_create", 2];
};


private _exit = false;
if (_missionType == "nato_attack") then {
	if (_location call AS_location_fnc_side == "FIA") exitWith {
		_exit = true;
		hint "The location to attack must not be controlled by FIA";
	};
	if !(_type in ["base", "outpost", "airfield", "outpostAA"]) exitWith {
		_exit = true;
		hint (AS_NATOname + " will not attack this type of location.");
	};
};
if _exit exitWith {};

private _origin = "";
if (_missionType == "nato_attack" and (count _airfields + count _bases == 0)) then {
	// we can only attack from spawnNATO, so we skip the choice
	_origin = "spawnNATO";
	_posicionTel = getMarkerPos _origin;
} else {
	hint format ["Click on a location for the %1 to start from", AS_NATOname];
	_posicionTel = call _get_mapPosition;
	if (count _posicionTel != 0 and {_posicionTel distance (getMarkerPos "spawnNATO") < MIN_DISTANCE_FOR_SELECTION}) then {
		_origin = "spawnNATO";
	};
};
if (count _posicionTel == 0) exitWith {};
if (_origin == "") then {
	_origin = _posicionTel call AS_location_fnc_nearest;
};

if (_origin != "spawnNATO" and {_origin call AS_location_fnc_side != "FIA"}) exitWith {
	hint "You must select a friendly location";
};

if (_missionType == "nato_armor") exitWith {
	if not (_origin in _bases) exitWith {
		hint "You must select a base";
	};
	[_missionType, _requiredSupport, [["origin", _origin], ["destinationPos", _position]]] remoteExec ["AS_mission_fnc_create", 2];
};

if (_missionType == "nato_attack") exitWith {
	if not (_origin in (_bases+_airfields+["spawnNATO"])) exitWith {
		hint "You must select a base or airfield";
	};
	[_missionType, _requiredSupport, [["origin", _origin], ["destination", _location]]] remoteExec ["AS_mission_fnc_create", 2];
};
