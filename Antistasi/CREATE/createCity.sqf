if (!isServer and hasInterface) exitWith{};
params ["_marcador"];

private _grupos = [];
private _soldados = [];

private _posicion = getMarkerPos (_marcador);

private _num = [_marcador] call sizeMarker; // [200, 800]
_num = round (_num / 100);  // [2, 8]

private ["_grupo","_grp","_params","_datos","_prestigeOPFOR","_prestigeBLUFOR"];

private _data = [_marcador, ["prestigeBLUFOR", "prestigeOPFOR"]] call AS_fnc_getCityAttrs;
private _prestigeBLUFOR = _data select 0;
private _prestigeOPFOR = _data select 1;

private _isAAF = true;
if (_marcador in mrkAAF) then {
	_num = round (_num * _prestigeOPFOR/100);
	_frontera = [_marcador] call isFrontline;
	if (_frontera) then {_num = _num * 2};
	_tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	_params = [_posicion, side_green, _tipogrupo];
}
else {
	_isAAF = false;
	_num = round (_num * _prestigeBLUFOR/100);
	_params = [_posicion, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSentry")];
};

if (_num < 1) then {_num = 1};

// generate _num patrols.
for "_i" from 0 to _num - 1 do {
	if !(spawner getVariable _marcador) exitWith {};
	_grupo = _params call BIS_Fnc_spawnGroup;
	if (_isAAF) then {
		{[_x, false] spawn AS_fnc_initUnitOPFOR; _soldados = _soldados + [_x]} forEach units _grupo;

		// generate dog with some probability.
		if (random 10 < 2.5) then {
			_dog = _grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"];
			[_dog] spawn guardDog;
			_soldados pushBack _dog;
		};
	}
	else {
		{[_x, false] spawn AS_fnc_initUnitFIA; _soldados = _soldados + [_x]} forEach units _grupo;
	};

	// put then on patrol.
	[leader _grupo, _marcador, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos pushBack _grupo;
};

waitUntil {sleep 1;(not (spawner getVariable _marcador)) or ({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)};

// send patrol?
if ((({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)) and (_marcador in mrkAAF)) then {
	[_posicion] remoteExec ["patrolCA",HCattack];
};

// cleanup everything when de-spawn marker.
waitUntil {sleep 1;not (spawner getVariable _marcador)};

{
	// store unit arsenal if:
	// - city is FIA and ...
	//     - was FIA (store FIA units), OR
	//     - was AAF and unit is dead (store dead AAF units)
	if (!(_marcador in mrkAAF) and (!_isAAF or (_isAAF and !alive _x))) then {
		([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
		[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
	};
	if (alive _x) then {
		deleteVehicle _x;
	};
} forEach _soldados;
{deleteGroup _x} forEach _grupos;
