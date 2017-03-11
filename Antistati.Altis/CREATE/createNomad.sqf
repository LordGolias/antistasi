if (!isServer and hasInterface) exitWith {};

_marcador = _this select 0;
_posicion = getMarkerPos _marcador;

_bldgs = nearestObjects [_position, ["house"], 10];
_posbldg = [];
_bldg = _bldgs select 0;
while {count _posbldg < 3} do
    {
    _bldg = _bldgs call BIS_Fnc_selectRandom;
    _posbldg = [_bldg] call BIS_fnc_buildingPositions;
    if (count _posbldg < 3) then {_bldgs = _bldgs - [_bldg]};
    };

_max = (count _posbldg) - 1;
_rnd = floor random _max;
_posDealer = _posbldg select _rnd;

_grpDealer = createGroup side_blue;
_dealer = _grpDealer createUnit ["C_Nikos_aged", _posDealer, [], 0, "FORM"] ;
_dealer setIdentity "Nomad";
_dealer disableAI "move";
_dealer setunitpos "up";

[[_dealer,"bm_mission"],"flagaction"] call BIS_fnc_MP;


waitUntil {sleep 5; (not(spawner getVariable _marcador)) or (not(_marcador in nomadPos))};

if ({alive _x} count units _grupo == 0) then
	{
	nomadPos = nomadPos - [_marcador]; publicVariable "nomadPos";
	marcadores = marcadores - [_marcador]; publicVariable "marcadores";
	deleteMarker _marcador;
	[["TaskFailed", ["", "Nomad is gone"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};

{deleteVehicle _x} forEach units _grpDealer;
deleteGroup _grpDealer;