if (player != AS_commander) exitWith {hint "Only Player Commander is allowed to move assets"};
if (vehicle player != player) exitWith {hint "You cannot move assets while in a vehicle"};

params ["_vehicle","_player","_EHid", ["_arguments", nil]];

if (_player != player) exitWith {
	diag_log "[AS] Error: moveObject called from not-player.";
};

private _attachPoint = [0,2,1];  // default attach point

private _position = "FIA_HQ" call AS_location_fnc_position;
private _distance = 30;

if (!isNil "_arguments") then {
	private _nearest = (["FIA" call AS_location_fnc_S, player] call BIS_fnc_nearestPosition);
	_position = _nearest call AS_location_fnc_position;
	_distance = 50;

	private _bbr = boundingBoxReal _vehicle;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;
	private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	if (_maxHeight > 2.5) then {
		private _attachPoint = [0,2,1.5];
	};
	if (_maxHeight > 3) then {
		private _attachPoint = [0,2,2];
	};
};

if (position _vehicle distance _position > _distance) exitWith {hint "Asset is too far from the flag."};

_vehicle removeAction _EHid;
_vehicle attachTo [player,_attachPoint];
player setVariable ["ObjAttached", _vehicle, true];

private _EHid = _player addAction [localize "STR_act_dropAsset", {
	params ["_obj", "_caller", "_actionID"];
	_obj removeAction _actionID;
	detach (_obj getVariable "ObjAttached");
	_obj setVariable ["ObjAttached", nil];
	}, nil, 0, false, true, "", "!isNull (_target getVariable ['ObjAttached',objNull])"];

waitUntil {sleep 1;
	(vehicle player != player) or  // not inside a vehicle
	(player distance _position > _distance) or // too far
	(!alive player) or (!isPlayer player) or // not inside a vehicle
	isNull (player getVariable ['ObjAttached',objNull])  // object dropped
};

// detach it if other conditions were satisfied
if !(isNull (player getVariable ['ObjAttached',objNull])) then  {
	detach (player getVariable 'ObjAttached');
	player setVariable ["ObjAttached", nil];
};

// add the action back
_vehicle addAction [localize "STR_act_moveAsset", "actions\moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)", 5];

player removeAction _EHid;

player allowDamage false;
_vehicle setPosATL [getPosATL _vehicle select 0,getPosATL _vehicle select 1,0];

private _vehDistance = position _vehicle distance _position;
if (_vehDistance > _distance) then {
	hint format ["You cannot move assets farther than %1m from the location.", _distance];
	// it became unreachable to move again. Find a position where it is reachable
	private _pos = position _vehicle;
	while {_pos distance _position > _distance} do {
		_pos = [_vehicle, _vehDistance - _distance + 3, random 360] call BIS_Fnc_relPos;
	};
	_vehicle setPos _pos;
};
player allowDamage true;

if (vehicle player != player) exitWith {hint "You dropped the asset to enter in the vehicle"};
