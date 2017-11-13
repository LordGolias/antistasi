/*
parameters
0: target location (marker)
1: duration of the script's runtime (integer, minutes)
2: timing of the waves with regards to the starting time (array of integers, minutes after script call)
3: wave specifications: "QRF_air/land_mixed/destroy/transport_small/large", "CSAT" (array of strings)
4: (optional) object to add the stop action to (object)

If origin is an airport/carrier, the QRF will consist of air cavalry. Otherwise it'll be ground forces in MRAPs/trucks.

Example: ["Paros", 15, [2, 3, 10], ["QRF_air_transport_small", "QRF_land_mixed_large", "Attack"]] spawn AS_fnc_spawnAttackWaves;
*/
#include "../macros.hpp"
params ["_targetMarker", "_duration", "_waveIntervals", "_waveSpecs"];

private _targetLocation = _targetMarker call AS_location_fnc_position;

// break if timing and specs of waves don't match
if !(count _waveIntervals == count _waveSpecs) exitWith {diag_log format ["Script failure: number and type of waves do not match -- intervals: %1; types: %2", _waveIntervals, _waveSpecs]};

if not isNil {AS_S("waves_active")} exitWith {diag_log "Script failure: attack waves already active."};

private _endTime = dateToNumber ([date select 0, date select 1, date select 2, date select 3, (date select 4) + _duration]);

AS_Sset("waves_active", true);

// find closest base
private _bases = [];
{
	private _posBase = _x call AS_location_fnc_position;
	if ((_targetLocation distance _posBase < 7500) and
		(_targetLocation distance _posBase > 1500) and
		!(_x call AS_location_fnc_spawned)) then {
			_bases pushBack _x
		};
} forEach (["base", "AAF"] call AS_location_fnc_TS);

private _base = "";
if (count _bases > 0) then {
	_base = [_bases, _targetLocation] call BIS_fnc_nearestPosition;
};

// find closest airport
private _airports = [];
{
	private _posAirport = _x call AS_location_fnc_position;
	if ((_targetLocation distance _posAirport < 7500) and
		(_targetLocation distance _posAirport > 1500) and
		!(_x call AS_location_fnc_spawned)) then {
			_airports pushBack _x;
		};
} forEach (["airfield", "AAF"] call AS_location_fnc_TS);

private _airport = "";
if (count _airports > 0) then {
	_airport = [_airports, _targetLocation] call BIS_fnc_nearestPosition;
};

// create marker at target location
private _mrk = createMarkerLocal [format ["Attack-%1", random 100], _targetLocation];
_mrk setMarkerShapeLocal "RECTANGLE";
_mrk setMarkerSizeLocal [150,150];
_mrk setMarkerTypeLocal "hd_warning";
_mrk setMarkerColorLocal "ColorRed";
_mrk setMarkerBrushLocal "DiagGrid";
_mrk setMarkerAlpha 0;

// trigger of wave types
private _triggerWave = {
	params ["_waveType"];

    switch _waveType do {

    	// QRF, air, small
    	case "QRF_air_mixed_small": {
   			if !(_airport == "") then {
   				[[_airport, _targetLocation, _targetMarker, _duration, "mixed", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};
    	case "QRF_air_transport_small": {
   			if !(_airport == "") then {
   				[[_airport, _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};
    	case "QRF_air_destroy_small": {
   			if !(_airport == "") then {
   				[[_airport, _targetLocation, _targetMarker, _duration, "destroy", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};

      // QRF, air, large
      case "QRF_air_mixed_large": {
        if !(_airport == "") then {
          [[_airport, _targetLocation, _targetMarker, _duration, "mixed", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };
      case "QRF_air_transport_large": {
        if !(_airport == "") then {
          [[_airport, _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };
      case "QRF_air_destroy_large": {
        if !(_airport == "") then {
          [[_airport, _targetLocation, _targetMarker, _duration, "destroy", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };

    	// QRF, land, small
    	case "QRF_land_mixed_small": {
   			if !(_base == "") then {
   				[[_base, _targetLocation, _targetMarker, _duration, "mixed", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};
    	case "QRF_land_transport_small": {
   			if !(_base == "") then {
   				[[_base, _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};
    	case "QRF_land_destroy_small": {
   			if !(_base == "") then {
   				[[_base, _targetLocation, _targetMarker, _duration, "destroy", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			}
   			else {
   				[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
   			};
    	};

      // QRF, land, large
      case "QRF_land_mixed_large": {
        if !(_base == "") then {
          [[_base, _targetLocation, _targetMarker, _duration, "mixed", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };
      case "QRF_land_transport_large": {
        if !(_base == "") then {
          [[_base, _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };
      case "QRF_land_destroy_large": {
        if !(_base == "") then {
          [[_base, _targetLocation, _targetMarker, _duration, "destroy", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        }
        else {
          [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
        };
      };

    	// CSAT
      case "CSAT_small": {
        [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
      };
      case "CSAT_large": {
        [["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "large"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
      };

      // default: CSAT, small
    	default {
        diag_log format ["Incorrect call of QRF. Details: %1; %2; %3; %4", _targetLocation, _duration, _waveIntervals, _waveSpecs];
    		[["spawnCSAT", _targetLocation, _targetMarker, _duration, "transport", "small"], "AS_movement_fnc_sendEnemyQRF"] remoteExec ["AS_scheduler_fnc_execute", 2]
    	};
    };
};

// times at which the waves will be dispatched
private _waveTimes = [];
for "_i" from 0 to (count _waveIntervals - 1) do {
	_waveTimes pushBack dateToNumber ([date select 0, date select 1, date select 2, date select 3, (date select 4) + (_waveIntervals select _i)]);
};

private _nrOfWaves = count _waveTimes;
private _waveIndex = 0;
private _currentWave = 0;

// while attacks are going on
while {(dateToNumber date < _endTime) and AS_S("waves_active") and {_waveIndex < _nrOfWaves}} do {
	_currentWave = _waveTimes select _waveIndex;

	// wait until it is time to send the next wave
	while {(dateToNumber date < _endTime) and AS_S("waves_active") and {_waveIndex < _nrOfWaves}} do {
		if (dateToNumber date > _currentWave) exitWith {
			_waveIndex = _waveIndex + 1;
		};
		sleep 10;
	};
	if (AS_S("waves_active") and {_waveIndex < _nrOfWaves}) then {
		[_waveSpecs select (_waveIndex - 1)] call _triggerWave;
	};
	sleep 1;
};

AS_Sset("waves_active", false);

deleteMarker _mrk;
