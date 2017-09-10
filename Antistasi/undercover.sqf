#include "macros.hpp"
if (call AS_fnc_controlsAI) exitWith {hint "You cannot go Undercover while you are controlling AI"};

// the player may be temporarly controlling another unit. We check the original unit
// the player cannot become undercover on an AI controlled unit, so this is ok
private _player = player getVariable ["owner", player];

if (captive _player) exitWith {hint "You are already undercover"};

private _heli_spotters = [["base","airfield"], "AAF"] call AS_fnc_location_TS;
private _all_spotters = [["base","airfield","outpost","roadblock","hill", "hillAA"], "AAF"] call AS_fnc_location_TS;

private _arrayCivVeh = arrayCivVeh + [civHeli];

private _compromised = _player getVariable "compromised";
private _reason = "";

private _isMilitaryDressedConditions = [
	{primaryWeapon _player != ""},
	{secondaryWeapon _player != ""},
	{handgunWeapon _player != ""},
	{!(vest _player in AS_FIAvests_undercover)},
	{!(headgear _player in AS_FIAhelmets_undercover)},
	{hmd _player != ""},
	{!(uniform _player in AS_FIAuniforms_undercover)}
];
private _isMilitaryHints = [
	"a weapon",
	"a weapon",
	"a handgun",
	"a military vest",
	"a military helmet",
	"a military head set",
	"a military uniform"
];

private _isMilitaryDressed = {
	{
		if (call _x) exitWith {
			true
		};
	} forEach _isMilitaryDressedConditions;
	false
};

private _fnc_detected = {
	private _detected = false;
	{
		if ((side _x == side_red) and {(_x knowsAbout _player > 1.4) and (_x distance _player < 500)}) exitWith {
			_detected = true;
		};
	} forEach allUnits;
	_detected
};

///// Check whether the player can become undercover
if (vehicle _player != _player) then {
	if (not(typeOf(vehicle _player) in _arrayCivVeh)) then {
		_reason = "You cannot go undercover because you are in a non-civilian vehicle.";
	};
	if (vehicle _player in AS_S("reportedVehs")) then {
		_reason = "You cannot go undercover because you are in a compromised vehicle. Change your vehicle or renew it in the Garage to become undercover.";
	};
} else {
	{
		if (call _x) exitWith {
			_reason = "You cannot go undercover because you are wearing " + (_isMilitaryHints select _forEachIndex);
		};
	} forEach _isMilitaryDressedConditions;
	if (dateToNumber date < _compromised) then {
		_reason = "You cannot go undercover because you are compromised. [use heal and repair in HQ or wait 30m]";
	};
};

if (_reason != "") exitWith {
	hint _reason;
};

["<t color='#1DA81D'>Undercover</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

private _setUndercover = {
	_player setCaptive true;
	// set AI members to be undercovered.
	if (_player == leader group _player) then {
		{if (!isplayer _x) then {[_x] spawn undercoverAI}} forEach units group _player;
	};
};

call _setUndercover;

// loop until we have a reason to not be undercover.
while {_reason == ""} do {
	sleep 1;
	if (!captive _player) exitWith {
		_reason = "reported";
	};

	private _veh = vehicle _player;
	private _type = typeOf _veh;
	if (_veh != _player) then {
		_reason = call {
			if (not(_type in _arrayCivVeh)) exitWith {
				"militaryVehicle"
			};
			if (_veh in AS_S("reportedVehs")) exitWith {
				"compromisedVehicle"
			};
			if (_type != civHeli and
				{count (_veh nearRoads 50) == 0} and
				_fnc_detected) exitWith {
				// no roads within 50m and detected.
				"awayFromRoad"
			};
			if (_type != civHeli and {
				private _base = [_all_spotters, _player] call BIS_fnc_nearestPosition;
				private _position = _base call AS_fnc_location_position;
				private _size = _base call AS_fnc_location_size;
				_player distance _position < _size*2}) exitWith {
					"distanceToLocation"
			};
			if (_type == civHeli and {
				private _base = [_heli_spotters, _player] call BIS_fnc_nearestPosition;
				private _position = _base call AS_fnc_location_position;
				private _size = _base call AS_fnc_location_size;
				_player distance _position < _size*2}) exitWith {
					"distanceToLocation"
			};
			if (hayACE and {_type != civHeli} and
				{false or
					{((position _player nearObjects ["DemoCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_red} or
					{((position _player nearObjects ["SatchelCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_red}} and
				_fnc_detected) exitWith {
				"vehicleWithExplosives"
			};
			""
		};
	} else {
		_reason = call {
			if call _isMilitaryDressed exitWith {
				"militaryDressed"
			};
			if (dateToNumber date < _compromised) exitWith {
				_reason = "compromised"
			};
			if (true and {
				private _loc = [_all_spotters, _player] call BIS_fnc_nearestPosition;
				private _position = _loc call AS_fnc_location_position;
				_player distance2d _position < 300}) exitWith {
				"distanceToLocation"
			};
			""
		};
	};
};

private _setPlayerCompromised = {
	if (captive _player) then {_player setCaptive false};

	// the player only becomes compromised when he is detected
	if (call _fnc_detected) then {
		if (vehicle _player != _player) then {
			AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle _player]);
		};
		_player setVariable ["compromised", (dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30])];
	};
};

call _setPlayerCompromised;

["<t color='#D8480A'>Not undercover</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

switch _reason do {
	case "reported": {
		hint "You cannot remain undercover because you have been reported";
	};
	case "militaryVehicle": {
		hint "You cannot remain undercover on a non-civilian vehicle";
	};
	case "compromisedVehicle": {
		hint "You cannot remain undercover on a compromised vehicle";
	};
	case "vehicleWithExplosives": {
		hint "You cannot remain undercover on a vehicle with spotted explosives";
	};
	case "awayFromRoad": {
		hint "You cannot remain undercover because this vehicle has been compromised because you went too far from the roads";
	};
	case "militaryDressed": {
		hint "You cannot remain undercover because you are wearing military equipment:\n\nweapon in hand\nVest\nHelmet\nNV Googles\nGuerrilla Uniform";
	};
	case "compromised": {
		hint "You cannot remain undercover because you are compromised. [use heal and repair in HQ or wait 30m]";
	};
	case "distanceToLocation": {
		hint "You cannot remain undercover because you are too close to an enemy location";
	};
};
