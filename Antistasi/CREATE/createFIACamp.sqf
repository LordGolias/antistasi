if (!isServer and hasInterface) exitWith {};
params ["_location"];

private _posicion = _location call AS_fnc_location_position;
_posicion = _posicion findEmptyPosition [5,50,"I_Heli_Transport_02_F"];

private _objs = [_posicion, floor(random 361), selectRandom AS_campList] call BIS_fnc_ObjectsMapper;
private _soldiers = [];
private _groups = [];
private _vehicles = [];

private _campBox = objNull;
{
	call {
		if (typeof _x == campCrate) exitWith {_campBox = _x;};
		if (typeof _x == "Land_MetalBarrel_F") exitWith {[[_x,"refuel"],"flagaction"] call BIS_fnc_MP;};
		if (typeof _x == "Land_Campfire_F") exitWith {_x inflame true;};
	};
	_surface = surfaceNormal (position _x);
	_x setVectorUp _surface;
} forEach _objs;

[[_campBox,"heal_camp"],"flagaction"] call BIS_fnc_MP;
// add option to access the Arsenal and unload from truck. (to caja)
[_campBox] call emptyCrate;
_campBox addaction [localize "STR_act_arsenal", {_this call accionArsenal;}, [], 6, true, false, "", "(isPlayer _this) and (_this == _this getVariable ['owner',objNull])",5];
_campBox addAction [localize "STR_act_unloadCargo", "[] call vaciar"];

// Create the garrison
(_location call AS_fnc_createFIAgarrison) params ["_soldados1", "_grupos1", "_vehiculos1"];
_soldiers append _soldados1;
_groups append _grupos1;
_vehicles append _vehiculos1;

private _initialCount = count _soldiers;

private _wasDestroyed = false;
private _wasAbandoned = _initialCount == 0;
waitUntil {sleep 5;
	_wasDestroyed = !_wasAbandoned and ({alive _x} count _soldiers == 0);
	_wasAbandoned or !(_location call AS_fnc_location_spawned) or _wasDestroyed
};

if (_wasDestroyed) then {
	[["TaskFailed", ["", "Camp Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
};

// wait until despawn or be removed by the player.
waitUntil {sleep 5;
	!(_location call AS_fnc_location_spawned)
};

if (_wasDestroyed) then {
	_location call AS_fnc_location_delete;

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
} else {
	[_campBox, caja] call munitionTransfer;
};

{
	// if not destroyed, collect all weapons (dead and alive). Otherwise, only alive
	if (!_wasDestroyed or (alive _x)) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
		deleteVehicle _x;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldiers;
{deleteGroup _x} forEach _groups;
{deleteVehicle _x} forEach _objs;
{if (!(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehicles;
