// usage: Activate via radio trigger, on act: [] execVM "AS_fnc_activateAirstrike.sqf";
params ["_location", "_tipoavion"];

private ["_wp1","_wp2","_wp3","_tipoavion","_lado"];

private _posicion = _location call AS_location_fnc_position;

if (_tipoavion in (["CSAT", "planes"] call AS_fnc_getEntity)) then {_lado = side_red};
if (_tipoAvion in (["NATO", "planes"] call AS_fnc_getEntity)) then {_lado = side_blue};

private _ang = random 360;
private _angorig = _ang + 180;

private _pos1 = [_posicion, 400, _angorig] call BIS_Fnc_relPos;
private _origpos = [_posicion, 4500, _angorig] call BIS_fnc_relPos;
private _pos2 = [_posicion, 200, _ang] call BIS_Fnc_relPos;
private _finpos = [_posicion, 4500, _ang] call BIS_fnc_relPos;

private _planefn = [_origpos, _ang, _tipoavion, _lado] call bis_fnc_spawnvehicle;
private _plane = _planefn select 0;
private _planeCrew = _planefn select 1;
private _grupoplane = _planefn select 2;
_plane setPosATL [getPosATL _plane select 0, getPosATL _plane select 1, 1000];
_plane disableAI "TARGET";
_plane disableAI "AUTOTARGET";
_plane flyInHeight 100;


_wp1 = _grupoplane addWaypoint [_pos1, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "LIMITED";
_wp1 setWaypointBehaviour "CARELESS";
if (_lado == side_red) then {
	if ((_location call AS_location_fnc_type) in ["base", "airfield"]) then
		{
		_wp1 setWaypointStatements ["true", "[this] execVM 'AI\airbomb.sqf'"];
		}
	else {
		if (_location call AS_location_fnc_type == "city") then {
			_wp1 setWaypointStatements ["true", "[this,""NAPALM""] execVM 'AI\airbomb.sqf'"];
		} else {
			_wp1 setWaypointStatements ["true", "[this,""CLUSTER""] execVM 'AI\airbomb.sqf'"];
		};
	};
} else {
	_wp1 setWaypointStatements ["true", "[this] execVM 'AI\airbomb.sqf'"];
};

_wp2 = _grupoplane addWaypoint [_pos2, 1];
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointType "MOVE";

_wp3 = _grupoplane addWaypoint [_finpos, 2];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "FULL";
_wp3 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew this; deleteVehicle this"];

waitUntil {sleep 2; (currentWaypoint _grupoplane == 4) or (!canMove _plane)};

{deleteVehicle _x} forEach _planeCrew;
deleteVehicle _plane;
deleteGroup _grupoplane;
