fnc_QRF_gunship = {
	params ["_vehGroup", "_origin", "_dest", "_duration"];

	[_vehGroup, _origin, _dest] call fnc_QRF_approachTarget;
	[_vehGroup, _origin, _dest, 300, _duration] call fnc_QRF_loiter;
};

fnc_QRF_leadVehicle = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroup", "_duration"];

	[_vehGroup, _origin, _dest, _mrk, _infGroup, _duration] call fnc_QRF_groundAssault;
};

fnc_QRF_truck = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration"];

	[_vehGroup, _origin, _dest, _mrk, _infGroups, _duration, "ground"] call fnc_QRF_dismountTroops;
};

fnc_QRF_airCavalry = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration", "_type"];

	if (_type == "rope") then {
		[_vehGroup, _origin, _dest, _mrk, _infGroups, _duration] call fnc_QRF_fastrope;
	};
	if (_type == "land") then {
	 	[_vehGroup, _origin, _dest, _mrk, _infGroups, _duration, "air"] call fnc_QRF_dismountTroops;
	};
};

fnc_QRF_approachTarget = {
	params ["_vehGroup", "_origin", "_dest"];

	private _dist = _origin distance2d _dest;
	private _dir = _origin getDir _dest;
	private _div = (floor (_dist / 150)) - 1;

	_x1 = _origin select 0;
	_y1 = _origin select 1;
	_x2 = _dest select 0;
	_y2 = _dest select 1;

	_x3 = (_x1 + _div*_x2) / (_div + 1);
	_y3 = (_y1 + _div*_y2) / (_div + 1);
	_z3 = 50;

	private _approachPos = [_x3, _y3, _z3];

	_wp100 = _vehGroup addWaypoint [_approachPos, 50];
	_wp100 setWaypointSpeed "FULL";
	_wp100 setWaypointBehaviour "CARELESS";
};

fnc_QRF_loiter = {
	params ["_vehGroup", "_origin", "_dest", "_radius", "_duration"];

	_wp101 = _vehGroup addWaypoint [_dest, 50];
	_wp101 setWaypointType "LOITER";
	_wp101 setWaypointLoiterType "CIRCLE";
	_wp101 setWaypointLoiterRadius _radius;
	_wp101 setWaypointCombatMode "YELLOW";
	_wp101 setWaypointSpeed "LIMITED";

	sleep _duration;
	[_vehGroup, _origin] spawn fnc_QRF_RTB;
};

fnc_QRF_groundAssault = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroup", "_duration"];

	if (typeName _infGroup == "STRING") then {
		_dest = [_dest, _origin, -20] call findSafeRoadToUnload;
		_wp200 = _vehGroup addWaypoint [_dest, 0];
		_wp200 setWaypointSpeed "FULL";
		_wp200 setWaypointBehaviour "CARELESS";
		_wp200 setWaypointType "TR UNLOAD";
		_wp300 = _infGroup addWaypoint [_dest, 0];
		_wp300 setWaypointType "GETOUT";
		_wp300 synchronizeWaypoint [_wp200];
		_wp301 = _infGroup addWaypoint [_mrk, 0];
		_wp301 setWaypointType "SAD";
		_wp301 setWaypointBehaviour "COMBAT";
		_infGroup setCombatMode "RED";
	} else {
		_wp300 = _vehGroup addWaypoint [_dest, 20];
		_wp300 setWaypointSpeed "FULL";
		_wp300 setWaypointBehaviour "CARELESS";
		_wp300 setWaypointType "SAD";

		waitUntil {sleep 5; ((units _vehGroup select 0) distance _dest < 50) || ({alive _x} count units _vehGroup == 0)};
	};

	0 = [leader _vehGroup, _mrk, "COMBAT", "SPAWNED", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	sleep _duration;

	[_vehGroup, _origin] spawn fnc_QRF_RTB;
	if (!isNil "_infGroup") then {
		[_infGroup, _origin] spawn fnc_QRF_RTB;
	};
};

fnc_QRF_dismountTroops = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration", "_type"];

	private _infGroup1 = _infGroups;
	private _infGroup2 = "";

	if (typeName _infGroups == "ARRAY") then {
		_infGroup1 = _infGroups select 0;
		_infGroup2 = _infGroups select 1;
	};

	if (_type == "ground") then {
		_dest = [_dest, _origin, 0] call findSafeRoadToUnload;
	};

	_wp400 = _vehGroup addWaypoint [_dest, 0];
	_wp400 setWaypointBehaviour "CARELESS";
	_wp400 setWaypointSpeed "FULL";
	_wp400 setWaypointType "TR UNLOAD";
	_wp401 = _infGroup1 addWaypoint [_dest, 0];
	_wp401 setWaypointType "GETOUT";
	_wp401 synchronizeWaypoint [_wp400];
	if (typeName _infGroups == "ARRAY") then {
		_wp501 = _infGroup2 addWaypoint [_dest, 0];
		_wp501 setWaypointType "GETOUT";
		_wp501 synchronizeWaypoint [_wp400];
	};

	_wp402 = _infGroup1 addWaypoint [_mrk call AS_fnc_location_position, 0];
	_wp402 setWaypointType "SAD";
	_wp402 setWaypointBehaviour "AWARE";
	_infGroup1 setCombatMode "RED";

	_wp502 = "";
	if (typeName _infGroups == "ARRAY") then {
		_wp502 = _infGroup2 addWaypoint [_mrk call AS_fnc_location_position, 0];
		_wp502 setWaypointType "SAD";
		_wp502 setWaypointBehaviour "AWARE";
		_infGroup2 setCombatMode "RED";
	};

	waitUntil {sleep 5; ((units _infGroup1 select 0) distance _dest < 50) || ({alive _x} count units _vehGroup == 0)};

	_infGroup1 setCurrentWaypoint _wp402;
	[_vehGroup, _origin] spawn fnc_QRF_RTB;
	if (typeName _infGroups == "ARRAY") then {
		//0 = [leader _infGroup2, _mrk, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_infGroup2 setCurrentWaypoint _wp502;
	};

	sleep _duration;

	[_infGroup1, _origin] spawn fnc_QRF_RTB;
	if (typeName _infGroups == "ARRAY") then {
		[_infGroup2, _origin] spawn fnc_QRF_RTB;
	};
};

fnc_QRF_fastrope = {
	params ["_vehGroup", "_origin", "_dest", "_mrk", "_infGroups", "_duration"];

	private _infGroup1 = _infGroups;
	private _infGroup2 = "";

	if (typeName _infGroups == "ARRAY") then {
		_infGroup1 = _infGroups select 0;
		_infGroup2 = _infGroups select 1;
	};

	_wp600 = _vehGroup addWaypoint [_dest, 10];
	_wp600 setWaypointBehaviour "CARELESS";
	_wp600 setWaypointSpeed "FULL";

	private _veh = vehicle (units _infGroup1 select 0);

	waitUntil {sleep 1; ((not alive _veh) || (speed _veh < 20)) && (_veh distance _dest < 300)};

	_infGroup1 call SHK_Fastrope_fnc_AIs;
	if (typeName _infGroups == "ARRAY") then {
		sleep 2;
		(_infGroups select 1) call SHK_Fastrope_fnc_AIs;
	};

	_wp601 = _infGroup1 addWaypoint [_mrk call AS_fnc_location_position, 0];
	_wp601 setWaypointType "SAD";
	_wp601 setWaypointBehaviour "AWARE";
	_infGroup1 setCombatMode "RED";

	if (typeName _infGroups == "ARRAY") then {
		//0 = [leader _infGroup2, _mrk, "AWARE", "SPAWNED","NOVEH", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		_wp602 = _infGroup2 addWaypoint [_mrk call AS_fnc_location_position, 0];
		_wp602 setWaypointType "SAD";
		_wp602 setWaypointBehaviour "AWARE";
		_infGroup2 setCombatMode "RED";
	};

	[_vehGroup, _origin] spawn fnc_QRF_RTB;

	sleep _duration;

	[_infGroup1, _origin] spawn fnc_QRF_RTB;
	if (typeName _infGroups == "ARRAY") then {
		[_infGroup2, _origin] spawn fnc_QRF_RTB;
	};
};

fnc_QRF_RTB = {
	params ["_vehGroup", "_dest"];

	{_x disableAI "AUTOCOMBAT"} forEach units _vehGroup;

	while { !({alive _x} count units _vehGroup == 0) && !({_x distance2D _dest > 200} count units _vehGroup == 0)} do
	{
		{_x disableAI "AUTOCOMBAT"} forEach units _vehGroup;

		_wp700 = _vehGroup addWaypoint [_dest, 0];
		_wp700 setWaypointSpeed "FULL";
		_wp700 setWaypointBehaviour "CARELESS";
		_wp700 setWaypointCombatMode "GREEN";

		_vehGroup setCurrentWaypoint _wp700;
		sleep 5;
	};

	waitUntil {sleep 1; ({alive _x} count units _vehGroup == 0) || ({_x distance2D _dest > 200} count units _vehGroup == 0)};
	{deleteVehicle _x} forEach units _vehGroup + [vehicle leader _vehGroup]; deleteGroup _vehGroup;
};
