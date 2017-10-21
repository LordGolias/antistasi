params ["_origin", "_destination", "_crew_group", "_cargo_group"];

private _wp600 = _crew_group addWaypoint [_destination, 100];
_wp600 setWaypointBehaviour "CARELESS";
_wp600 setWaypointSpeed "FULL";

private _veh = vehicle (units _crew_group select 0);

waitUntil {sleep 1; (not alive _veh) or (speed _veh < 20) and {_veh distance _destination < 300}};

if not alive _veh exitWith {};

private _ropping = _cargo_group spawn SHK_Fastrope_fnc_AIs;
waitUntil {scriptDone _ropping};

private _wp601 = _cargo_group addWaypoint [_destination, 0];
_wp601 setWaypointType "SAD";
_wp601 setWaypointBehaviour "AWARE";
_cargo_group setCombatMode "RED";

// send the helicopter home
_crew_group addWaypoint [_origin, 0];
