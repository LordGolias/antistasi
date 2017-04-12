if (player != player getVariable ["owner",player]) exitWith {hint "You cannot go Undercover while you are controlling AI"};
if (captive player) exitWith {hint "You are in Undercover already"};

private ["_compromised","_reason","_bases","_arrayCivVeh","_player","_size","_base","_isMilitaryDressed", "_detectedCondition", "_setPlayerCompromised"];

_bases = bases + puestos + controles;
_locs = (bases + aeropuertos + puestos + colinas) arrayIntersect mrkAAF;
_arrayCivVeh = arrayCivVeh + [civHeli];

_compromised = player getVariable "compromised";
_reason = "";

_isMilitaryDressed = (primaryWeapon player != "") or
				 (secondaryWeapon player != "") or
				 (handgunWeapon player != "") or
				 (!(vest player in AS_FIAvests_undercover)) or
				 (!(headgear player in AS_FIAhelmets_undercover)) or
				 (hmd player != "") or
				 (!(uniform player in AS_FIAuniforms_undercover));
_detectedCondition = {((side _x == side_red) or (side _x == side_green)) and
					  (
						((_x knowsAbout player > 1.4) and (_x distance player < 500)) or
						(_x distance player < 350)
						)
					 };
_setPlayerCompromised = {_player setVariable ["compromised", (dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + 30])];};

if (vehicle player != player) then
	{
	if (not(typeOf(vehicle player) in _arrayCivVeh)) then {
		hint "You cannot go undercover in a non-civilian vehicle.";
		_reason = "Init"
	};
	if (vehicle player in reportedVehs) then {
		hint "You cannot go undercover in a reported vehicle. Change your vehicle or renew it in the Garage to become undercover.";
		_reason = "Init";
	};
}
else {
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

if (_detectedCondition count allUnits > 0) exitWith {
	hint "You cannot become undercover while enemies are spotting you.";
	if (vehicle player != player) then {
		{
		if ((isPlayer _x) and (captive _x)) then {[_x,false] remoteExec ["setCaptive",_x]; reportedVehs pushBackUnique (vehicle player); publicVariable "reportedVehs"}
		} forEach ((crew (vehicle player)) + (assignedCargo (vehicle player)) - [player]);
	};
};

_base = [_bases, player] call BIS_fnc_nearestPosition;
_size = [_base] call sizeMarker;
if ((_base in mrkAAF) and (player distance getMarkerPos _base < _size*2)) exitWith {hint "You cannot become Undercover near Bases, Outposts or Roadblocks"};

["<t color='#1DA81D'>Incognito</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

player setCaptive true;
_player = player getVariable ["owner", player]; // the player may be temporarly controlling other unit.

// set AI members to be undercovered.
if (_player == leader group _player) then {
	{if (!isplayer _x) then {[_x] spawn undercoverAI}} forEach units group _player;
};

// loop until we have a reason to not be undercover.
while {_reason == ""} do {
	sleep 1;
	if (!captive player) then {
		_reason = "reported";
	}
	else {
		_veh = vehicle _player;
		_type = typeOf _veh;

		if (_veh != _player) then {
			if (not(_type in _arrayCivVeh)) then {
				_reason = "militaryVehicle";
			}
			else {
				if (_veh in reportedVehs) then {
					_reason = "compromisedVehicle";
				}
				else {
					if (_type != civHeli) then {
						// is not on road and no roads within 50m and is detected.
						if (not(isOnRoad position _veh) and (count (_veh nearRoads 50) == 0) and (_detectedCondition count allUnits > 0)) then {
							_reason = "awayFromRoad"
						};
						if (hayACE) then {
			  				if (((position player nearObjects ["DemoCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_green) then {
								_reason = "vehicleWithExplosives";
							};
							if (((position player nearObjects ["SatchelCharge_Remote_Ammo", 5]) select 0) mineDetectedBy side_green) then {
								_reason = "vehicleWithExplosives";
							};
						};
					};
				};
			};
		}
		else {
			if (_isMilitaryDressed) then {
				if (_detectedCondition count allUnits > 0) then {
					_reason = "detectedDressed"
				}
				else {
					_reason = "militaryDressed"
				};
			};
			if (dateToNumber date < _compromised) then {
				_reason = "compromised";
			};
		};

		if (_reason == "") then {
			if (_type != civHeli) then {
				_base = [_bases, _player] call BIS_fnc_nearestPosition;
				_size = [_base] call sizeMarker;
				// distance to an AA site.
				if ((_base in mrkAAF) and (_player distance getMarkerPos _base < _size*2)) then {
					_reason = "distanceToLocation";
				};
			}
			else {
				// distance to a location.
				_loc = [_locs, _player] call BIS_fnc_nearestPosition;
				if (_player distance2d getMarkerPos _loc < 300) then {
					_reason = "distanceToLocation";
				};
			};
		};
	};
};

if (captive _player) then {_player setCaptive false};

["<t color='#D8480A'>Overt</t>",0,0,4,0,0,4] spawn bis_fnc_dynamicText;

switch _reason do {
	case "reported": {
		hint "You have been reported or spotted by the enemy";
		if (vehicle _player != _player) then {
			reportedVehs pushBackUnique (vehicle _player); publicVariable "reportedVehs";
		}
		else {
			call _setPlayerCompromised;
		};
	};
	case "militaryVehicle": {hint "You entered in a non-civilian vehicle"};
	case "compromisedVehicle": {hint "You entered in a reported vehicle"};
	case "vehicleWithExplosives": {
		hint "Explosives spotted on your vehicle";
		reportedVehs pushBackUnique (vehicle _player); publicVariable "reportedVehs";
	};
	case "awayFromRoad": {
		hint "You went far from roads and have been spotted";
		reportedVehs pushBackUnique (vehicle _player); publicVariable "reportedVehs";
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
			reportedVehs pushBackUnique (vehicle _player); publicVariable "reportedVehs";
		}
		else {
			call _setPlayerCompromised;
		};
	};
};
