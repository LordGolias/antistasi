private _deleteControl = {
	params ["_control", "_location"];
	private _pos = _control call AS_fnc_location_position;
	private _closest = [call AS_fnc_locations,_pos] call BIS_fnc_nearestPosition;

	if (_closest == _location) then {
		waitUntil {sleep 1; !(_control call AS_fnc_location_spawned)};
		[_control,"side","FIA"] call AS_fnc_location_set;
	};
};

{
	[_x, _this] spawn _deleteControl;
} forEach control_points;
