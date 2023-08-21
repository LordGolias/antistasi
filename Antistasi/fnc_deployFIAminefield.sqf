#include "macros.hpp"
params ["_type"];

if (count ("fia_minefield" call AS_mission_fnc_active_missions) != 0) exitWith {
	hint "We can only deploy one minefield at a time.";
	createDialog "AS_createminefield";
};

if (!([player] call AS_fnc_hasRadio)) exitWith {
	hint "You need a radio in your inventory to be able to give orders to other squads";
	createDialog "AS_createminefield";
};

private _possibleMines = (["AAF", _type] call AS_fnc_getEntity);


private _allMags = magazineCargo caja;
private _availableMines = []; // mines per type
private _totalAvailableMines = 0;
{
	private _mag = _x call AS_fnc_mineMag;
	private _amount = {_x == _mag} count _allMags;
	_availableMines pushBack _amount;
	_totalAvailableMines = _totalAvailableMines + _amount;
} forEach _possibleMines;

if (_totalAvailableMines == 0) exitWith {
	hint "you have no mines available";
	createDialog "AS_createminefield";
};

private _vehicleType = selectRandom (["FIA", "vans"] call AS_fnc_getEntity);
private _cost = 2*("Explosives Specialist" call AS_fnc_getCost) +
	(_vehicleType call AS_fnc_getFIAvehiclePrice);
private _hr = 2;
if ((AS_P("resourcesFIA") < _cost) or (AS_P("hr") < _hr)) exitWith {
	hint format ["Not enought resources to recruit a mine deploying team (%1 € and %2 HR needed)",_cost,_hr];
	createDialog "AS_createminefield";
};

openMap true;
AS_mapPosition = [];
hint "Click on the position you wish to build the minefield. Mines will be positioned within 100m of this position.";

onMapSingleClick "AS_mapPosition = _pos;";

waitUntil {sleep 1; (count AS_mapPosition > 0) or (not visiblemap)};
onMapSingleClick "";

if (count AS_mapPosition == 0) exitWith {
	hint "Operation cancelled";
	createDialog "AS_createminefield";
};
private _locationPosition = +AS_mapPosition;
AS_mapPosition = nil;

private _locationMrk = createMarker ["minefield", _locationPosition];
_locationMrk setMarkerShape "ELLIPSE";
_locationMrk setMarkerSize [100,100];
_locationMrk setMarkerColor "ColorBlack";

// select mine positions
hint "Click to add mine positions within the minefield. Press backspace to (repeately) delete the last added position. Press Enter to confirm the selection or close the map to cancel.";
openMap true;
AS_mapPositions = [];
AS_minesMarkers = [];
AS_confirmLocations = false;
AS_availableMines = _totalAvailableMines;

onMapSingleClick {
	private _position = _pos;
	if (AS_availableMines == count AS_mapPositions) exitWith {
		hint "You do not have more mines in the box";
	};
	if (([AS_mapPositions,_position] call BIS_fnc_nearestPosition) distance _position < 3) exitWith {
		hint "Mine too close from another mine";
	};
	if (_position distance _locationPosition > 100) exitWith {
		hint "Mine too far from minefield";
	};
	AS_mapPositions pushBack _position;
	private _mrk = createMarker [format ["Mine%1", count AS_minesMarkers], _position];
	_mrk setMarkerShape "ELLIPSE";
	_mrk setMarkerSize [3,3];
	_mrk setMarkerColor "ColorRed";
	AS_minesMarkers pushBack _mrk;
	hint format ["You have %1 mine(s) more available in the arsenal to add", AS_availableMines - (count AS_mapPositions)];
};

// 12 is the map
waituntil {!isnull (finddisplay 12)};
// todo: check that we do not need to remove this event handler.
(findDisplay 12) displayAddEventHandler ["KeyDown", {
	params ["_control", "_key", "_shift", "_ctrl", "_alt"];
	if (_key in [0x1C, 0x9C]) exitWith {  // enter
		AS_confirmLocations = true;
		openMap false;
		hint "Locations confirmed.";
	};
	if (_key == 0x0E) exitWith {  // backspace
		if (count AS_mapPositions != 0) then {
			AS_mapPositions deleteAt (count AS_mapPositions - 1);
			deleteMarker (AS_minesMarkers select (count AS_minesMarkers - 1));
			AS_minesMarkers deleteAt (count AS_minesMarkers - 1);
			hint format ["You have %1 mine(s) more available in the arsenal to add", AS_availableMines - (count AS_mapPositions)];
		};
		true
	};
	false
}];

waitUntil {sleep 0.5; (not visiblemap)};
onMapSingleClick "";

// store relevant results
private _positions = +AS_mapPositions;

// delete everything in the end
deleteMarker _locationMrk;
{
	deleteMarker _x;
} forEach AS_minesMarkers;
AS_minesMarkers = nil;
AS_mapPositions = nil;
AS_availableMines = nil;

// without confirmation, we just cancel everything
if !(AS_confirmLocations) exitWith {
	AS_confirmLocations = nil;
	hint "Operation cancelled";
	createDialog "AS_createminefield";
};
AS_confirmLocations = nil;

// build the array [[mag1, mag2, ...], [amount1, amount2, ...]] of used arrays
private _usedMines = [[], []];
private _remaining = count _positions; // sum of all used mines.
{
	private _amount = 0;
	if ((_availableMines select _forEachIndex) < _remaining) then {
		_amount = _availableMines select _forEachIndex;
		_remaining = _remaining - (_availableMines select _forEachIndex);
	} else {
		_amount = _remaining;
		_remaining = 0;
	};
	(_usedMines select 0) pushBack (_x call AS_fnc_mineMag);
	(_usedMines select 1) pushBack _amount;

	if (_remaining == 0) exitWith {};
} forEach _possibleMines;

// pay price and remove mines from box
[-_hr,-_cost] remoteExec ["AS_fnc_changeFIAmoney",2];

waitUntil {not AS_S("lockTransfer")};
AS_Sset("lockTransfer", true);
([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
_cargo_m = [_cargo_m, _usedMines, false] call AS_fnc_mergeCargoLists;  // false -> remove from _cargo_m
[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;
AS_Sset("lockTransfer", false);

// create the mission
private _mission = ["establish_fia_minefield", ""] call AS_mission_fnc_add;
[_mission, "status", "active"] call AS_mission_fnc_set;
[_mission, "mines_cargo", _usedMines] call AS_mission_fnc_set;
[_mission, "position", _locationPosition] call AS_mission_fnc_set;
[_mission, "positions", _positions] call AS_mission_fnc_set;
[_mission, "vehicle", _vehicleType] call AS_mission_fnc_set;
[_mission, "cost", _cost] call AS_mission_fnc_set;

// create the mission that will build the minefield.
[_mission] remoteExec ["AS_mission_fnc_activate", 2];
