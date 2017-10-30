#include "../macros.hpp"
AS_SERVER_ONLY("fnc_deployAAFminefield.sqf");

private _deployMinefield = {
    params ["_base", "_location"];
    private _posbase = _base call AS_location_fnc_position;
    private _FIAposition = _location call AS_location_fnc_position;
    private _angOrig = [_posbase,_FIAposition] call BIS_fnc_dirTo;

    // position to find
    private _position = [];

    private _distance = 300;
    private _searchAng = 5;
    private _searchAmplitude = 50;
    // find a suitable spot for mines that is:
    // 	- in land
    //	- far from spawned location
    //	- far from location
    // 	- far from road
    // 	- without mines closeby
    private _pos = [];
    private _found = false;
    private _ang = _angOrig;
    for "_i" from 1 to (_searchAmplitude/_searchAng) do {
    	_position = [_posbase, _distance, _ang] call BIS_Fnc_relPos;

    	if (!surfaceIsWater _position) then {
    		private _nearest = _position call AS_location_fnc_nearest;
    		if (not(_nearest call AS_location_fnc_spawned)) then {
    			private _size = _nearest call AS_location_fnc_size;
    			private _nearestPos = _nearest call AS_location_fnc_position;
    			if ((_position distance _nearestPos) > (_size + 100)) then {
    				private _roads = _position nearRoads 101;
    				if (count _roads == 0) then {
    					_found = true;
    				};
    			};
    		};
    	};
    	if (_found) exitWith {};

    	// +5 (+5), -10 (-5), +15 (+10), ... so it searches the 45 arc starting from the middle
    	// last _i, ang = _angOrig + _searchAmplitude/2;
    	if (_i % 2 == 1) then {
    		_ang = _ang + _searchAng*_i;
    	} else {
    		_ang = _ang - _searchAng*_i;
    	};
    };
    if (!_found) exitWith {false};

    [_position, "AAF"] call AS_fnc_addMinefield;
    true
};

private _deployed = false;
{
    if ((_x call AS_fnc_location_isFrontline) and !(_x call AS_location_fnc_spawned)) then {
        private _closeBy = ["FIA" call AS_location_fnc_S, _x call AS_location_fnc_position] call BIS_fnc_nearestPosition;
        _deployed = [_x,_closeBy] call _deployMinefield;
    };
    if (_deployed) exitWith {};
} forEach (["base", "AAF"] call AS_location_fnc_TS);

_deployed
