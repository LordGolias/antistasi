#include "../macros.hpp"
params ["_location"];

private _side = _location call AS_fnc_location_side;
private _minesData = ([_location, "mines"] call AS_fnc_location_get);

private _mines = [];
{
	_x params ["_type", "_pos", "_dir"];
	private _mine = createMine [_type, _pos, [], 0];
	_mine setDir _dir;
	_mines pushBack _mine;

	if (_side == "FIA") then {
		side_blue revealMine _mine;
	};
	if (_side == "AAF") then {
		side_green revealMine _mine;
	};
} forEach _minesData;

waitUntil {sleep 1; !(_location call AS_fnc_location_spawned)};

if ({!isNull _x} count _mines == 0) then {
	// if no mines left, delete location
	_location call AS_fnc_location_remove;
} else {
	// else, remove the missing mines
	for "_i" from 0 to (count _minesData - 1) do {
		if (isNull (_mines select _i)) then {
			_minesData deleteAt _i;
		};
	};
	([_location, "mines", _minesData] call AS_fnc_location_set);
};

{
	deleteVehicle _x;
} forEach _mines;
