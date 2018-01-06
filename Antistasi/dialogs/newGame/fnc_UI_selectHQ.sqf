params ["_isNewGame"];

private _enemyLocations = "AAF" call AS_location_fnc_S;
if _isNewGame then {
    // first-time location can be close to roadblocks and they are removed
    _enemyLocations = _enemyLocations - ("roadblock" call AS_location_fnc_T);
	openMap true;
} else {
	openMap [true,true];
};

// This is for placement only: moving the HQ still allows to place it anywhere.
private _minDistanceToLocation = 500;
// min distance from enemy troops to do not get killed on placement.
private _minDistanceToEnemy = 500;


// Add markers to simplify the selection
private _tempMarkers = [];
{
    private _mrk = createMarker [format ["initialHelper%1",_x], _x call AS_location_fnc_position];
    _mrk setMarkerShape "ELLIPSE";
    _mrk setMarkerSize [_minDistanceToLocation, _minDistanceToLocation];
    _mrk setMarkerColor "ColorGreen";
    _mrk setMarkerAlpha 0.1;
    _tempMarkers pushBack _mrk;
} forEach _enemyLocations;

// wait until a valid position (or cancelled for a new game)
private _position = getMarkerPos "FIA_HQ";
while {true} do {

	AS_map_position = [];
	onMapSingleClick "AS_map_position = +_pos; true";

	waitUntil {sleep 1;(count AS_map_position > 0) or (_isNewGame and not visiblemap)};
	onMapSingleClick "";
	if (_isNewGame and not visiblemap) exitWith {};
	_position = +AS_map_position;
	private _closest = ([_enemyLocations, _position] call BIS_fnc_nearestPosition);
	private _closestEnemyLocation = _closest call AS_location_fnc_position;

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
	if (_validLocation and not _isNewGame) then {
		{
            if ((side _x == side_red) and {_x distance _position < _minDistanceToEnemy}) exitWith {
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

_position
