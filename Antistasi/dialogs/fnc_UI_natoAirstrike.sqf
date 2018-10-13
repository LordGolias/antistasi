#include "../macros.hpp"
if (AS_P("NATOsupport") < 10) exitWith {
	hint "You lack of enough NATO Support to make this request"
};
if (!([player] call AS_fnc_hasRadio)) exitWith {
	hint "You need a radio in your inventory to be able to give orders to other squads"
};
params ["_tipo"];

posicionTel = [];

hint "Select the spot from which the plane will start to drop the bombs";

openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

private _pos1 = posicionTel;
posicionTel = [];

private _mrkorig = createMarker [format ["BRStart%1",random 1000], _pos1];
_mrkorig setMarkerShape "ICON";
_mrkorig setMarkerType "hd_destroy";
_mrkorig setMarkerColor "ColorRed";
_mrkOrig setMarkerText "Bomb Run Init";

hint "Select the map position to which the plane will exit to calculate plane's route vector";

onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {deleteMarker _mrkOrig};

private _pos2 = +posicionTel;
posicionTel = [];

private _ang = [_pos1,_pos2] call BIS_fnc_dirTo;

private _central = [_pos1, 100, _ang] call BIS_fnc_relPos;
private _ciudad = [call AS_location_fnc_cities,_central] call BIS_fnc_nearestPosition;

if (_central distance (_ciudad call AS_location_fnc_position) < (_ciudad call AS_location_fnc_size) * 1.5) exitWith {
	hint format ["That path is very close to %1.\n\nNATO won't perform any bomb run that may cause civilian casualties",_ciudad];
	deleteMarker _mrkOrig;
	openMap false
};

[-10,0] remoteExec ["AS_fnc_changeForeignSupport",2];

private _mrkDest = createMarker [format ["BRFin%1",random 1000], _pos2];
_mrkDest setMarkerShape "ICON";
_mrkDest setMarkerType "hd_destroy";
_mrkDest setMarkerColor "ColorRed";
_mrkDest setMarkerText "Bomb Run Exit";

//openMap false;

private _angorig = _ang - 180;

private _origpos = [_pos1, 2500, _angorig] call BIS_fnc_relPos;
private _finpos = [_pos2, 2500, _ang] call BIS_fnc_relPos;

private _planeType = selectRandom (["NATO", "planes"] call AS_fnc_getEntity);
private _planefn = [_origpos, _ang, _planeType, ("NATO" call AS_fnc_getFactionSide)] call bis_fnc_spawnvehicle;
private _plane = _planefn select 0;
_plane setPosATL [getPosATL _plane select 0, getPosATL _plane select 1, 1000];
_plane disableAI "TARGET";
_plane disableAI "AUTOTARGET";
_plane flyInHeight 100;

driver _plane sideChat "Starting Bomb Run. ETA 30 seconds.";
private _wp1 = group _plane addWaypoint [_pos1, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "LIMITED";
_wp1 setWaypointBehaviour "CARELESS";
if (_tipo == "CARPET") then {_wp1 setWaypointStatements ["true", "[this,""CARPET""] execVM 'AI\airbomb.sqf'"]};
if (_tipo == "NAPALM") then {_wp1 setWaypointStatements ["true", "[this,""NAPALM""] execVM 'AI\airbomb.sqf'"]};
if (_tipo == "HE") then {_wp1 setWaypointStatements ["true", "[this] execVM 'AI\airbomb.sqf'"]};


private _wp2 = group _plane addWaypoint [_pos2, 1];
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointType "MOVE";

private _wp3 = group _plane addWaypoint [_finpos, 2];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "FULL";
_wp3 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this; deleteGroup (group this)"];

waitUntil {sleep 1; (currentWaypoint group _plane == 4) or (!canMove _plane)};

deleteMarker _mrkOrig;
deleteMarker _mrkDest;
if ((!canMove _plane) and (!isNull _plane)) then {
	sleep AS_P("cleantime");
	{deleteVehicle _x} forEach crew _plane; deleteVehicle _plane;
	deleteGroup group _plane;
};
