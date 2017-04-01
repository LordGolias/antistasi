if (!isServer and hasInterface) exitWith {};

private ["_marcador","_posicion","_grupo","_campGroup","_fire"];

_objs = [];

_marcador = _this select 0;
_posicion = getMarkerPos _marcador;

_camp = selectRandom AS_campList;
_posicion = _posicion findEmptyPosition [5,50,"I_Heli_Transport_02_F"];
_objs = [_posicion, floor(random 361), _camp] call BIS_fnc_ObjectsMapper;

sleep 2;

private _campBox = objNull;
{
	call {
		if (typeof _x == campCrate) exitWith {_campBox = _x;};
		if (typeof _x == "Land_MetalBarrel_F") exitWith {[[_x,"refuel"],"flagaction"] call BIS_fnc_MP;};
		if (typeof _x == "Land_Campfire_F") exitWith {_fire = _x;};
	};
	_surface = surfaceNormal (position _x);
	_x setVectorUp _surface;
} forEach _objs;

[[_campBox,"heal_camp"],"flagaction"] call BIS_fnc_MP;
// add option to access the Arsenal and unload from truck. (to caja)
[_campBox] call emptyCrate;
_campBox addaction [localize "STR_act_arsenal", {_this call accionArsenal;}, [], 6, true, false, "", "(isPlayer _this) and (_this == _this getVariable ['owner',objNull])",5];
_campBox addAction [localize "STR_act_unloadCargo", "[] call vaciar"];

_grupo = [_posicion, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M")] call BIS_Fnc_spawnGroup;
_grupo setBehaviour "STEALTH";
_grupo setCombatMode "GREEN";

{[_x, false] call AS_fnc_initUnitFIA;} forEach units _grupo;

_fire inflame true;

waitUntil {sleep 5; (not(spawner getVariable _marcador)) or ({alive _x} count units _grupo == 0) or (not(_marcador in campsFIA))};

// camp is lost if this condition is true.
private _wasDestroyed = ({alive _x} count units _grupo == 0);
if (_wasDestroyed) then {
	campsFIA = campsFIA - [_marcador]; publicVariable "campsFIA";
	campList = campList - [[_marcador, markerText _marcador]]; publicVariable "campList";
	usedCN = usedCN - [markerText _marcador]; publicVariable "usedCN";
	marcadores = marcadores - [_marcador]; publicVariable "marcadores";
	deleteMarker _marcador;
	[["TaskFailed", ["", "Camp Lost"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;

    // remove 20% of every item (rounded up)
    ([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
    {
        _values = _x select 1;
        for "_i" from 0 to (count _values - 1) do {
            _new_value = ceil ((_values select _i)*0.8);
            _values set [_i, _new_value];
        };
    } forEach [_cargo_w, _cargo_m, _cargo_i, _cargo_b];
    [caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;
};

// wait until despawn or be removed by the player.
waitUntil {sleep 5; (not(spawner getVariable _marcador)) or (not(_marcador in campsFIA))};

if (!_wasDestroyed) then {
    [_campBox, caja] call munitionTransfer;
};

{
	if (!_wasDestroyed and alive _x) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach units _grupo;
deleteGroup _grupo;

_fire inflame false;
sleep 2;
{deleteVehicle _x} forEach _objs;