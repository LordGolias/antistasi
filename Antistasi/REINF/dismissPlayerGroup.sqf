if (player != leader group player) exitWith {hint "You cannot dismiss anyone if you are not the squad leader"};

private ["_units","_hr","_resourcesFIA","_unit","_groupToDelete"];

_units = _this select 0;

player globalChat "You are no longer needed in this group.";

_ai = false;

// if only 1 player in the group.
if ({isPlayer _x} count units group player == 1) then {
	_ai = true;
	_groupToDelete = createGroup side_blue;
};

{
	if (!isPlayer _x) then {
		if (typeOf _x != "b_g_survivor_F") then
			{
			[_x] join _groupToDelete;
			namesFIASoldiers = namesFIASoldiers + [name _x];
			};
	}
	else {
		// send the player to a new group.
		[_x] join (createGroup side_blue);
	};
} forEach _units;

if (recruitCooldown < time) then {recruitCooldown = time + 60} else {recruitCooldown = recruitCooldown + 60};

if (_ai) then {
	_cargo_w = [[], []];
	_cargo_m = [[], []];
	_cargo_i = [[], []];
	_cargo_b = [[], []];

	// order units to return to the HQ.
	{_x domove getMarkerPos "respawn_west"} forEach units _groupToDelete;

	_tiempo = time + 120;

	// wait until all units are in the HQ.
	waitUntil {
		sleep 1; (time > _tiempo) or ({(_x distance getMarkerPos "respawn_west" < 50) and (alive _x)} count units _groupToDelete == {alive _x} count units _groupToDelete)};

	_hr = 0;
	_resourcesFIA = 0;

	{
		_unit = _x;
		if ((alive _unit) and (not(_x getVariable "inconsciente"))) then {
			_resourcesFIA = _resourcesFIA + (server getVariable (typeOf _unit));
			_hr = _hr + 1;

			_arsenal = [_unit, true] call AS_fnc_getUnitArsenal;  // restricted to locked weapons
			_cargo_w = [_cargo_w, _arsenal select 0] call AS_fnc_mergeCargoLists;
			_cargo_m = [_cargo_m, _arsenal select 1] call AS_fnc_mergeCargoLists;
			_cargo_i = [_cargo_i, _arsenal select 2] call AS_fnc_mergeCargoLists;
			_cargo_b = [_cargo_b, _arsenal select 3] call AS_fnc_mergeCargoLists;
		};
	} forEach units _groupToDelete;
	deleteGroup _groupToDelete;

	[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b] call AS_fnc_populateBox;

	if (!isMultiplayer) then {
		[_hr,_resourcesFIA/2] remoteExec ["resourcesFIA",2];
	} else {
		[_hr,0] remoteExec ["resourcesFIA",2];
		[_resourcesFIA/2] call resourcesPlayer;
	};
};
