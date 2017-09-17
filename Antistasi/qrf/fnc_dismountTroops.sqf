params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration", "_type"];

private _infGroup1 = _infGroups;
private _infGroup2 = "";

if (typeName _infGroups == "ARRAY") then {
    _infGroup1 = _infGroups select 0;
    _infGroup2 = _infGroups select 1;
};

if (_type == "ground") then {
    _dest = [_dest, _origin, 0] call AS_fnc_getSafeRoadToUnload;
};

private _wp400 = _vehGroup addWaypoint [_dest, 0];
_wp400 setWaypointBehaviour "CARELESS";
_wp400 setWaypointSpeed "FULL";
_wp400 setWaypointType "TR UNLOAD";
private _wp401 = _infGroup1 addWaypoint [_dest, 0];
_wp401 setWaypointType "GETOUT";
_wp401 synchronizeWaypoint [_wp400];
if (typeName _infGroups == "ARRAY") then {
    private _wp501 = _infGroup2 addWaypoint [_dest, 0];
    _wp501 setWaypointType "GETOUT";
    _wp501 synchronizeWaypoint [_wp400];
};

private _wp402 = _infGroup1 addWaypoint [_mrk call AS_location_fnc_position, 0];
_wp402 setWaypointType "SAD";
_wp402 setWaypointBehaviour "AWARE";
_infGroup1 setCombatMode "RED";

private _wp502 = "";
if (typeName _infGroups == "ARRAY") then {
    _wp502 = _infGroup2 addWaypoint [_mrk call AS_location_fnc_position, 0];
    _wp502 setWaypointType "SAD";
    _wp502 setWaypointBehaviour "AWARE";
    _infGroup2 setCombatMode "RED";
};

waitUntil {sleep 5; ((units _infGroup1 select 0) distance _dest < 50) || ({alive _x} count units _vehGroup == 0)};

_infGroup1 setCurrentWaypoint _wp402;
[_vehGroup, _origin] spawn AS_QRF_fnc_RTB;
if (typeName _infGroups == "ARRAY") then {
    //0 = [leader _infGroup2, _mrk, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
    _infGroup2 setCurrentWaypoint _wp502;
};

sleep _duration;

[_infGroup1, _origin] spawn AS_QRF_fnc_RTB;
if (typeName _infGroups == "ARRAY") then {
    [_infGroup2, _origin] spawn AS_QRF_fnc_RTB;
};
