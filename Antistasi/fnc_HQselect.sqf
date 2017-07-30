#include "macros.hpp"

private _hqInitialPlacement = isNil "placementDone";
private _hqDestroyed = !_hqInitialPlacement;

if (_hqDestroyed) then {
	AS_commander allowDamage false;
	"Petros is Dead" hintC "Petros has been killed. You lost part of your assets and need to select a new HQ position far from the enemies.";
} else {
	diag_log "[AS] INFO: New Game selected.";
	hint "Select the position you want to put your HQ.
          \nClose the map to start in the default position.
          \nChoose wisely: game changes a lot with the initial position!
          \nYou can move your HQ later.";
};

private _enemyLocations = "AAF" call AS_fnc_location_S;
if (_hqDestroyed) then {
	openMap [true,true];
}
else {
	_enemyLocations = _enemyLocations - ("roadblock" call AS_fnc_location_T);  // first-time location can be close to controllers.
	openMap true;
};

// +100 so the location is not spawned every time.
// This is for placement only: moving the HQ still allows to place it anywhere.
private _minDistanceToLocation = AS_P("spawnDistance") + 100;
// min distance from enemy troops to do not get killed on placement.
private _minDistanceToEnemy = 500;


// Add markers to simplify the selection
private _tempMarkers = [];
{
    private _mrk = createMarker [format ["initialHelper%1",_x], _x call AS_fnc_location_position];
    _mrk setMarkerShape "ELLIPSE";
    _mrk setMarkerSize [_minDistanceToLocation, _minDistanceToLocation];
    _mrk setMarkerColor "ColorGreen";
    _mrk setMarkerAlpha 0.1;
    _tempMarkers pushBack _mrk;
} forEach _enemyLocations;

// wait until a valid position (or cancelled for initial placement)
private _position = getMarkerPos "FIA_HQ";
while {true} do {

	AS_map_position = [];
	onMapSingleClick "AS_map_position = +_pos; true";

	waitUntil {sleep 1;(count AS_map_position > 0) or (!_hqDestroyed and not visiblemap)};
	onMapSingleClick "";
	if (!_hqDestroyed and not visiblemap) exitWith {};
	_position = +AS_map_position;
	private _closest = ([_enemyLocations, _position] call BIS_fnc_nearestPosition);
	private _closestEnemyLocation = _closest call AS_fnc_location_position;

	private _validLocation = true;
	if (_closestEnemyLocation distance _position < _minDistanceToLocation) then {
		_validLocation = false;
		hint "That is too close from the enemy. Select another place.";
	};
	if (_validLocation and surfaceIsWater _position) then {
		_validLocation = false;
		hint "Selected position cannot be in water";
	};

	// check if there is any enemy in the surroundings.
	if (_validLocation and _hqDestroyed) then {
		{
            if ((side _x == side_green) or (side _x == side_red) and {_x distance _position < _minDistanceToEnemy}) exitWith {
				_validLocation = false;
				hint "There are enemies in the surroundings. Select another place.";
			};
		} forEach allUnits;
	};

	if (_validLocation) exitWith {};
};
openmap [false,false];
AS_map_position = nil;

{
    deleteMarker _x;
} forEach _tempMarkers;

[_position] remoteExec ["AS_fnc_HQplace", 2];

if _hqInitialPlacement then {
	createDialog "boost_menu";
};
