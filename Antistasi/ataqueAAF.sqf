#include "macros.hpp"

private _debug_prefix = "ataqueAAF: ";
private _debug_message = "";

private _objectives = [];
private _count_easy = 0;

private _FIAbases = [["base","airfield"], "FIA"] call AS_fnc_location_TS;

private _useCSAT = true;

private _validTypes = ["base", "airfield", "outpost", "city", "roadblock", "powerplant", "factory", "resource"];

// only attack cities and use CSAT if FIA controls a base or airfield
if ((random 100 > AS_P("CSATsupport")) or (count _FIAbases == 0) or (server getVariable "blockCSAT")) then {
	_validTypes = _validTypes - ["city"];
	_useCSAT = false;
};

private _validLocations = [_validTypes, "FIA"] call AS_fnc_location_TS;
private _enemyLocations = ["FIA","NATO"] call AS_fnc_location_S;

if (count _validLocations == 0) exitWith {
	_debug_message = "posponed: no valid targets";
	AS_ISDEBUG(_debug_prefix + _debug_message);
};

// the potential the AAF has to attack
private _scoreLand = (["apcs"] call AS_fnc_AAFarsenal_count) + 5*(["tanks"] call AS_fnc_AAFarsenal_count);
private _scoreAir = (["armedHelis"] call AS_fnc_AAFarsenal_count) + 5*(["planes"] call AS_fnc_AAFarsenal_count);
if (_useCSAT) then {
	_scoreLand = _scoreLand + 15;
	_scoreAir = _scoreAir + 15;
};

{  // forEach _validLocations
	private _location = _x;
	private _type = _location call AS_fnc_location_type;
	private _position = _location call AS_fnc_location_position;
	private _garrison = _location call AS_fnc_location_garrison;

	if (_type == "_city") then {
		// cities are attacked by CSAT, so no need to compute anything
		private _FIAsupport = [_x, "FIAsupport"] call AS_fnc_location_get;
		private _AAFsupport = [_x, "AAFsupport"] call AS_fnc_location_get;

		// only attack cities that have high FIA and low AAF support
		if ((_AAFsupport < 5) and (_FIAsupport > 70)) then {
			_objectives pushBack _x
		};
	} else {  // non-city
		private _base = [_position, true] call findBasesForCA;
		private _aeropuerto = [_position, true] call findAirportsForCA;

		// short circuit if no valid bases or airfields to attack
		if ((_base != "") or (_aeropuerto != "")) then {
			private _closeEnemylocations = _enemyLocations select {((_x call AS_fnc_location_position) distance _position < AS_P("spawnDistance")/2)};

			(_closeEnemylocations call AS_fnc_AAFattackScore) params ["_scoreNeededLand", "_scoreNeededAir"];

			private _isEasy = (_scoreNeededLand < 4) and (_scoreNeededAir < 4) and (count _garrison < 4) and !(_type in ["base", "airfield"]);

			_debug_message = format ["%1: (%2,%3) (%4,%5) %6", _location, _scoreAir, _scoreNeededAir, _scoreLand, _scoreNeededLand, _isEasy];
			AS_ISDEBUG(_debug_prefix + _debug_message);

			// decide to attack or not depending on the scores
			if (_scoreNeededLand > _scoreLand) then {
				_base = "";
			} else {  // if it is easy,
				if (_isEasy and (_base != "") and (_count_easy < 4)) then {
					if !(_location in smallCAmrk) then {
						_count_easy = _count_easy + 2;
						[_location,_base] remoteExec ["patrolCA",HCattack];
						sleep 15;
					};
				};
			};
			if (_scoreNeededAir > _scoreAir) then {
				_aeropuerto = "";
			}
			else {
				if (_isEasy and (_base == "") and (_aeropuerto != "") and (_count_easy < 4)) then {
					if !(_location in smallCAmrk) then {
						_count_easy = _count_easy + 1;
						[_location,_aeropuerto] remoteExec ["patrolCA",HCattack];
						sleep 15;
					};
				};
			};

			// add the location to the objectives
			if (((_base != "") or (_aeropuerto != "")) and (!_isEasy)) then {
				// increase likelihood of bases and others
				private _cuenta = 1;
				if (_type in ["resource"]) then {_cuenta = 3};
				if (_type in ["powerplant", "factory"]) then {_cuenta = 4};
				if (_type in ["base", "airfield"]) then {_cuenta = 5};

				// amplify the effect to combined attacks or close targets.
				if (_base != "") then {
					if (_aeropuerto != "") then {_cuenta = _cuenta*2};
					if (_location == [_validLocations, _base] call bis_fnc_nearestPosition) then {_cuenta = _cuenta*2};
				};
				for "_i" from 1 to _cuenta do {
					_objectives pushBack _location;
				};
			};
		} else {
			_debug_message = format ["  %1: No valid bases or airfields to attack.", _location];
			AS_ISDEBUG(_debug_prefix + _debug_message);
		};
	};
} forEach _validLocations;

if ((count _objectives > 0) and (_count_easy < 3)) then {
	private _location = selectRandom _objectives;
	if (_location call AS_fnc_location_type != "city") then {
		[_location] remoteExec ["combinedCA",HCattack]
	} else {
		[_location] remoteExec ["CSATpunish",HCattack]
	};
};
