#include "macros.hpp"
if (call AS_fnc_controlsAI) exitWith {hint "You cannot go Undercover while you are controlling AI"};
if (captive player) exitWith {hint "You are in Undercover already"};

// bases spots non-heli
private _bases = [["base","outpost","roadblock"], "AAF"] call AS_fnc_location_TS;
// locs spots everything
private _locs = [["base","outpost","roadblock","hillAA","hill"], "AAF"] call AS_fnc_location_TS;

private _arrayCivVeh = arrayCivVeh + [civHeli];

private _compromised = player getVariable "compromised";
private _reason = "";

private _isMilitaryDressed = (primaryWeapon player != "") or
				 (secondaryWeapon player != "") or
				 (handgunWeapon player != "") or
				 (!(vest player in AS_FIAvests_undercover)) or
				 (!(headgear player in AS_FIAhelmets_undercover)) or
				 (hmd player != "") or
				 (!(uniform player in AS_FIAuniforms_undercover));
private _detectedCondition = {
	private _detected = false;
	{
		if ((side _x == side_red) and {(_x distance player < 350) or {(_x knowsAbout player > 1.4) and (_x distance player < 500)}}) exitWith {
			_detected = true;
		};
	} forEach allUnits;
	_detected
};
if (vehicle player != player) then {
	if (not(typeOf(vehicle player) in _arrayCivVeh)) then {
		hint "You cannot go undercover in a non-civilian vehicle.";
		_reason = "Init"
	};
	if (vehicle player in AS_S("reportedVehs")) then {
		hint "You cannot go undercover in a reported vehicle. Change your vehicle or renew it in the Garage to become undercover.";
		_reason = "Init";
	};
} else {
	if (_isMilitaryDressed) then {
		hint "You cannot go undercover with military gear:\n\nweapon in hand\nVest\nHelmet\nNV Googles\nGuerrilla Uniform.";
		_reason = "Init";
	};
	if (dateToNumber date < _compromised) then {
		hint "You cannot go undercover because you were reported in the past 30 minutes. Return to the HQ to become undercover.";
		_reason = "Init";
	};
};

if (_reason != "") exitWith {};

if (call _detectedCondition) exitWith {
	hint "You cannot become undercover while enemies are spotting you.";
	if (vehicle player != player) then {
		{
			if ((isPlayer _x) and (captive _x)) then {
				[_x,false] remoteExec ["setCaptive",_x];
				AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle player]);
			};
		} forEach ((crew (vehicle player)) + (assignedCargo (vehicle player)) - [player]);
	};
};


private _base = [_bases, player] call BIS_fnc_nearestPosition;
private _position = _base call AS_fnc_location_position;
private _size = _base call AS_fnc_location_size;
if (player distance _position < 1.5*_size) exitWith {hint "You cannot become Undercover near Bases, Outposts or Roadblocks"};

["<t color='#1DA81D'>Incognito</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

player setCaptive true;
private _player = player getVariable ["owner", player]; // the player may be temporarly controlling another unit.

private _setPlayerCompromised = {
	_player setVariable ["compromised", (dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30])];
};

// set AI members to be undercovered.
if (_player == leader group _player) then {
	{if (!isplayer _x) then {[_x] spawn undercoverAI}} forEach units group _player;
};

// loop until we have a reason to not be undercover.
while {_reason == ""} do {
	sleep 1;
	if (!captive player) exitWith {
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
				_detectedCondition) exitWith {
				// no roads within 50m and detected.
				"awayFromRoad"
			};
			if (_type != civHeli and {
				private _base = [_bases, _player] call BIS_fnc_nearestPosition;
				private _position = _base call AS_fnc_location_position;
				private _size = _base call AS_fnc_location_size;
				_player distance _position < _size*2}) exitWith {
					"distanceToLocation"
			};
			if (hayACE and {_type != civHeli} and
				{false or
					{((position player nearObjects ["DemoCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_red} or
					{((position player nearObjects ["SatchelCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_red}} and
				_detectedCondition) exitWith {
				"vehicleWithExplosives"
			};
			""
		};
	} else {
		_reason = call {
			if (_isMilitaryDressed and _detectedCondition) exitWith {
				"detectedDressed";
			};
			if _isMilitaryDressed exitWith {
				"militaryDressed";
			};
			if (dateToNumber date < _compromised) exitWith {
				_reason = "compromised";
			};
			if (true and {
				private _loc = [_locs, _player] call BIS_fnc_nearestPosition;
				private _position = _loc call AS_fnc_location_position;
				_player distance2d _position < 300}) exitWith {
				"distanceToLocation";
			};
			""
		};
	};
};

if (captive _player) then {_player setCaptive false};

["<t color='#D8480A'>Overt</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

switch _reason do {
	case "reported": {
		hint "You have been reported or spotted by the enemy";
		if (vehicle _player != _player) then {
			AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle _player]);
		}
		else {
			call _setPlayerCompromised;
		};
	};
	case "militaryVehicle": {hint "You entered in a non-civilian vehicle"};
	case "compromisedVehicle": {hint "You entered in a reported vehicle"};
	case "vehicleWithExplosives": {
		hint "Explosives spotted on your vehicle";
		AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle _player]);
	};
	case "awayFromRoad": {
		hint "You went far from roads and have been spotted";
		AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle _player]);
	};
	case "militaryDressed": {
		hint "You cannot stay undercover with military gear:\n\nweapon in hand\nVest\nHelmet\nNV Googles\nGuerrilla Uniform";
	};
	case "detectedDressed": {
		hint "The enemy spotted you with military gear.";
		call _setPlayerCompromised;
	};
	case "compromised": {hint "You left your vehicle and you are still compromised."};
	case "distanceToLocation": {
		hint "You went too close to an enemy facility and were spotted.";
		if (vehicle _player != _player) then {
			AS_Sset("reportedVehs", AS_S("reportedVehs") + [vehicle _player]);
		}
		else {
			call _setPlayerCompromised;
		};
	};
};
