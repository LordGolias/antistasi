params ["_position", "_faction"];

_position = _position findEmptyPosition [20,200, "Land_HelipadSquare_F"];
if (count _position == 0) exitWith {
    [[], [], []]
};

private _objects = [
	["Land_SandbagBarricade_01_half_F",[-1.17114,2.7998,0.00133133],177.685,1,0,[0,-0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[-2.84399,-1.31934,0.000164032],87.4029,1,0,[0,0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[-1.09058,-2.93262,-0.000862122],359.863,1,0,[0,0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[-2.9231,1.24609,0.000165939],87.4029,1,0,[0,0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[1.39697,2.86816,0.0011158],177.685,1,0,[0,-0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[2.92505,1.35742,-3.62396e-005],267.743,1,0,[0,0],"","",true,false],
	["Land_SandbagBarricade_01_half_F",[2.98706,-1.21094,5.53131e-005],267.743,1,0,[0,0],"",""]
];
private _vehicles = [_position, 0, _objects] call BIS_fnc_ObjectsMapper;
{_x setVectorUp (surfacenormal (getPosATL _x))} forEach _vehicles;

private _mortarType = [_faction, "static_mortar"] call AS_fnc_getEntity;
private _gunnerType = [_faction, "gunner"] call AS_fnc_getEntity;

private _group = createGroup (_faction call AS_fnc_getFactionSide);
private _veh = _mortarType createVehicle _position;
_vehicles pushBack _veh;
[_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";
[_veh, _faction] call AS_fnc_initVehicle;
private _unit = ([_position, 0, _gunnerType, _group] call bis_fnc_spawnvehicle) select 0;
[_unit, _faction, false] call AS_fnc_initUnit;
_unit moveInGunner _veh;
[[_unit], [_group], _vehicles]
