#include "../macros.hpp"
params ["_unit"];

_unit setCaptive true;

_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
_unit setUnitPos "UP";

// save and remove gear:
private _behaviour = behaviour _unit;
private _primaryWeapon = primaryWeapon _unit call BIS_fnc_baseWeapon;
private _primaryWeaponItems = primaryWeaponItems _unit;
private _secondaryWeapon = secondaryWeapon _unit;
private _secondaryWeaponItems = secondaryWeaponItems _unit;
private _handGunWeapon = handGunWeapon _unit call BIS_fnc_baseWeapon;
private _handgunItems = handgunItems _unit;
private _headgear = headgear _unit;
private _hmd = hmd _unit;

// remove equipment
_unit setBehaviour "CARELESS";
_unit removeWeaponGlobal _primaryWeapon;
_unit removeWeaponGlobal _secondaryWeapon;
_unit removeWeaponGlobal _handGunWeapon;
removeHeadGear _unit;
_unit unlinkItem _hmd;

private _detectingLocations = [["base","roadblock","outpost","outpostAA"], "AAF"] call AS_location_fnc_TS;
while {(captive player) and (captive _unit)} do {
	sleep 1;
	private _type = typeOf vehicle _unit;
	// vehicle reported.
	if ((vehicle _unit != _unit) and (not(_type in arrayCivVeh) || vehicle _unit in AS_S("reportedVehs"))) exitWith {};

	private _location = [_detectingLocations, _unit] call BIS_fnc_nearestPosition;
	private _position = _location call AS_location_fnc_position;
	private _size = _location call AS_location_fnc_size;
	if (_unit distance _position < _size*2) exitWith {_unit setCaptive false};
};

if (!captive _unit) then {_unit groupChat "Shit, they have spotted me!"} else {_unit setCaptive false};
if (captive player) then {sleep 5};

_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit setUnitPos "AUTO";

// load and add gear.
private _sinMochi = false;
if ((backpack _unit == "") and (_secondaryWeapon == "")) then {
	_sinMochi = true;
	_unit addbackpack "B_AssaultPack_blk";
};
{if (_x != "") then {[_unit, _x, 1, 0] call BIS_fnc_addWeapon};} forEach [_primaryWeapon,_secondaryWeapon,_handGunWeapon];
{_unit addPrimaryWeaponItem _x} forEach _primaryWeaponItems;
{_unit addSecondaryWeaponItem _x} forEach _secondaryWeaponItems;
{_unit addHandgunItem _x} forEach _handgunItems;
if (_sinMochi) then {removeBackpack _unit};
_unit addHeadgear _headgear;
_unit linkItem _hmd;
_unit setBehaviour _behaviour;
