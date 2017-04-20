if (!isServer and hasInterface) exitWith {};
params ["_location"];

private _position = _location call AS_fnc_location_position;
private _type = _location call AS_fnc_location_type;

private _soldiers = [];
private _groups = [];
private _vehicles = [];

// Create the garrison
(_location call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
_soldiers append _soldados1;
_groups append _grupos1;
_vehicles append _vehiculos1;

if (_type == "roadblock") then {
	private _tam = 1;
	private _road = [];
	while {count _road == 0} do {
		_road = _position nearRoads _tam;
		if (count _road > 0) exitWith {};
		_tam = _tam + 5;
	};
	_roadcon = roadsConnectedto (_road select 0);
	_dirveh = [_road select 0, _roadcon select 0] call BIS_fnc_DirTo;

	_veh = "C_Offroad_01_F" createVehicle getPos (_road select 0);
	_vehicles pushBack _veh;
	_veh setDir _dirveh + 90;
	_veh lock 3;
	[_veh, "FIA"] call AS_fnc_initVehicle;
};
if (_type == "watchpost") then {
	{
		_x setBehaviour "STEALTH";
		_x setCombatMode "GREEN";
	} forEach _groups;
};

private _campBox = objNull;
if (_type == "camp") then {
	// find a suitable position
	_position = _position findEmptyPosition [5,50,"I_Heli_Transport_02_F"];

	// spawn the camp objects
	private _objs = ([_position, floor(random 361), selectRandom AS_campList] call BIS_fnc_ObjectsMapper);
	{
		call {
			if (typeof _x == campCrate) exitWith {_campBox = _x;};
			if (typeof _x == "Land_MetalBarrel_F") exitWith {[[_x,"refuel"],"flagaction"] call BIS_fnc_MP;};
			if (typeof _x == "Land_Campfire_F") exitWith {_x inflame true;};
		};
		_x setVectorUp (surfaceNormal (position _x));
	} forEach _objs;

	_vehicles append _objs;

	// adds options to access the box
	[[_campBox,"heal_camp"],"flagaction"] call BIS_fnc_MP;
	[_campBox] call emptyCrate;
	_campBox addaction [localize "STR_act_arsenal", {_this call accionArsenal;}, [], 6, true, false, "", "(isPlayer _this) and (_this == _this getVariable ['owner',objNull])",5];
	_campBox addAction [localize "STR_act_unloadCargo", {[] call vaciar}];
};

private _wasDestroyed = false;
private _wasAbandoned = (count _soldiers) == 0;  // abandoned when it has no garrison
waitUntil {sleep 5;
	_wasDestroyed = !_wasAbandoned and ({alive _x} count _soldiers == 0);
	_wasAbandoned or !(_location call AS_fnc_location_spawned) or _wasDestroyed
};

if (_wasDestroyed) then {
	[5,-5,_position] remoteExec ["citySupportChange",2];

	switch (_type) do {
		case "roadblock": {
			[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		};
		case "watchpost": {
			[["TaskFailed", ["", "Roadblock Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		};
		case "camp": {
			[["TaskFailed", ["", "Camp Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		};
		default {
			[["TaskFailed", ["", "Location Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
		};
	};
};

waitUntil {sleep 1;
	_wasAbandoned or !(_location call AS_fnc_location_spawned)
};

if (_wasAbandoned or _wasDestroyed) then {
	_location call AS_fnc_location_delete;
};

if (_wasDestroyed) then {
	if (_type == "camp") then {
		// remove 10% of every item (rounded up) from caja
	    ([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
	    {
	        _values = _x select 1;
	        for "_i" from 0 to (count _values - 1) do {
	            _new_value = ceil ((_values select _i)*0.9);
	            _values set [_i, _new_value];
	        };
	    } forEach [_cargo_w, _cargo_m, _cargo_i, _cargo_b];
	    [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;
	};
} else {
	if (_type == "camp") then {
		[_campBox, caja] call munitionTransfer;
	};
};

{
	if (!_wasDestroyed and (alive _x)) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldiers;
{deleteGroup _x} forEach _groups;
{if (!_wasDestroyed and !(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehicles;
