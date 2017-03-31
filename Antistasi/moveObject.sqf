if (player != AS_commander) exitWith {hint "Only Player Commander is allowed to move assets"};
if (vehicle player != player) exitWith {hint "You cannot move assets while in a vehicle"};

_cosa = _this select 0;
_jugador = _this select 1;
_id = _this select 2;

_location = position petros;
_distance = 30;
_attachPoint = [0,2,1];
if (count _this > 3) then {
	_location = getMarkerPos ([mrkFIA, _jugador] call BIS_fnc_nearestPosition);
	_distance = 50;
	_bbr = boundingBoxReal _cosa;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	if (_maxHeight > 2.5) then {
		_attachPoint = [0,2,1.5];
	};
	if (_maxHeight > 3) then {
		_attachPoint = [0,2,2];
	};
};

if (position _cosa distance _location > _distance) exitWith {hint "Asset is too far from the flag."};

_cosa removeAction _id;
_cosa attachTo [player,_attachPoint];
player setVariable ["ObjAttached", true, true];

player addAction [localize "STR_act_dropAsset", {
	params ["_obj", "_caller", "_actionID"];
	_obj removeAction _actionID;
	_obj setVariable ["ObjAttached", nil, true];
	{detach _x} forEach attachedObjects _obj;
	}, nil, 0, false, true, "", "_target getVariable ['ObjAttached', false]"];

_checkAttachments = {
	private _return = false;
	{
		if !(isNull _x) exitWith {_return = true};
	} forEach attachedObjects _jugador;
	_return;
};

waitUntil {sleep 1; (vehicle player != player) or (player distance _location > _distance) or (!alive player) or (!isPlayer player) or !(call _checkAttachments)};

{detach _x} forEach attachedObjects player;

_cosa addAction [localize "STR_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)", 5];

_cosa setPosATL [getPosATL _cosa select 0,getPosATL _cosa select 1,0];

if (vehicle player != player) exitWith {hint "You cannot move assets while in a vehicle"};

if  (player distance _location > _distance) exitWith {hint format ["You cannot move assets farther than %1m from the flag.", _distance]};