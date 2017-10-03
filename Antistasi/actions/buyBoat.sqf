#include "../macros.hpp"
private ["_chequeo","_pos","_veh","_newPos","_coste"];

if ([position player, 500] call AS_fnc_enemiesNearby) exitWith {
	Hint "You cannot buy vehicles with enemies nearby";
};

_coste = boatFIAcost;

if (AS_P("resourcesFIA") < _coste) exitWith {hint format ["You need %1 € to buy a boat",_coste]};

_ang = 0;
_dist = 200;

while {true} do
	{
	_pos = [position player, _dist, _ang] call BIS_Fnc_relPos;
	if (surfaceIsWater _pos) then
		{
		while {true} do
			{
			_dist = _dist - 5;
			_newPos = [position player, _dist, _ang] call BIS_Fnc_relPos;
			if (!(surfaceIsWater _newPos)) exitWith {_chequeo = true};
			};
		};
	if (_chequeo) exitWith {};
	_ang = _ang + 31;
	};

_veh = boatFIA createVehicle _pos;

[_veh, "FIA"] call AS_fnc_initVehicle;
player reveal _veh;
[0,-200] remoteExec ["AS_fnc_changeFIAmoney",2];
hint "Boat purchased";
