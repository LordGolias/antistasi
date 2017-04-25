#include "../macros.hpp"
params ["_type"];

if ("Mines" in misiones) exitWith {
	hint "We can only deploy one minefield at a time.";
	createDialog "AS_createminefield";
};

if (!([player] call hasRadio)) exitWith {
	hint "You need a radio in your inventory to be able to give orders to other squads";
	createDialog "AS_createminefield";
};

private _mag = _type call AS_fnc_mineMag;
private _availableMines = {_x == _mag} count (magazineCargo caja);
if (_availableMines == 0) exitWith {
	hint format ["you have no '%1' available", _mag];
	createDialog "AS_createminefield";
};

private _cost = 2*(AS_data_allCosts getVariable "Explosives Specialist") +
	([(AS_FIArecruitment getVariable "land_vehicles") select 0] call FIAvehiclePrice);
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
AS_availableMines = _availableMines;

AS_fncUI_addMine = {
	private _position = _this;
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
onMapSingleClick "_pos call AS_fncUI_addMine;";

AS_fncUI_keyPressed = {
	params ["_control","_key","_shift", "_control", "_alt"];
	if (_key in [0x1C, 0x9C]) exitWith {  // enter
		AS_confirmLocations = true;
		openMap false;
		hint "Locations confirmed.";
	};
	if (_key == 0x0E) exitWith {  // backspace
		if (count AS_mapPositions != 0) then {
			AS_mapPositions deleteAt (count mapPositions - 1);
			deleteMarker (AS_minesMarkers select (count AS_minesMarkers - 1));
			AS_minesMarkers deleteAt (count AS_minesMarkers - 1);
			hint format ["You have %1 mine(s) more available in the arsenal to add", AS_availableMines - (count AS_mapPositions)];
		};
		true
	};
	false
};

// 12 is the map
waituntil {!isnull (finddisplay 12)};
// todo: check that we do not need to remove this event handler.
(findDisplay 12) displayAddEventHandler ["KeyDown", AS_fncUI_keyPressed];

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
AS_fncUI_addMine = nil;
AS_fncUI_keyPressed = nil;
AS_availableMines = nil;

// without confirmation, we just cancel everything
if !(AS_confirmLocations) exitWith {
	AS_confirmLocations = nil;
	hint "Operation cancelled";
	createDialog "AS_createminefield";
};
AS_confirmLocations = nil;

// create the mission that will build the minefield.
[_type, _locationPosition, _positions] remoteExec ["AS_missionFIAminefield",2];
