private ["_unit","_behaviour","_primaryWeapon","_secondaryWeapon","_handGunWeapon","_headgear","_hmd","_list","_primaryWeaponItems","_secondaryWeaponItems","_handgunItems","_bases"];

_unit = _this select 0;
_unit setCaptive true;

_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
_unit setUnitPos "UP";

// save and remove gear:
_behaviour = behaviour _unit;
_primaryWeapon = primaryWeapon _unit call BIS_fnc_baseWeapon;
_primaryWeaponItems = primaryWeaponItems _unit;
_secondaryWeapon = secondaryWeapon _unit;
_secondaryWeaponItems = secondaryWeaponItems _unit;
_handGunWeapon = handGunWeapon _unit call BIS_fnc_baseWeapon;
_handgunItems = handgunItems _unit;
_headgear = headgear _unit;
_hmd = hmd _unit;

// remove equipment
_unit setBehaviour "CARELESS";
_unit removeWeaponGlobal _primaryWeapon;
_unit removeWeaponGlobal _secondaryWeapon;
_unit removeWeaponGlobal _handGunWeapon;
removeHeadGear _unit;
_unit unlinkItem _hmd;

_unit addEventHandler ["FIRED", {
	_unit = _this select 0;
	if (captive _unit) then {
		if ({((side _x== side_red) or (side _x== side_green)) and ((_x knowsAbout _unit > 1.4) || (_x distance _unit < 200))} count allUnits > 0) then {
			_unit setCaptive false;
			if (vehicle _unit != _unit) then {
				{if (isPlayer _x) then {[_x,false] remoteExec ["setCaptive",_x]}} forEach ((assignedCargo (vehicle _unit)) + (crew (vehicle _unit)));
			};
		}
		else {
			// someone may report it.
			_ciudad = [ciudades,_unit] call BIS_fnc_nearestPosition;
			_size = [_ciudad] call sizeMarker;
			_datos = server getVariable _ciudad;
			if (random 100 < _datos select 2) then {
				if (_unit distance getMarkerPos _ciudad < _size * 1.5) then {
					_unit setCaptive false;
				};
			};
		};
	};
}];

_bases = bases + puestos + controles;
while {(captive player) and (captive _unit)} do {
	sleep 1;
	_type = typeOf vehicle _unit;
	// vehicle reported.
	if ((vehicle _unit != _unit) and (not(_type in arrayCivVeh) || vehicle _unit in reportedVehs)) exitWith {};
	
	_base = [_bases, _unit] call BIS_fnc_nearestPosition;
	_size = [_base] call sizeMarker;
	if ((_base in mrkAAF) and (_unit distance getMarkerPos _base < _size*2)) exitWith {_unit setCaptive false};
	//if ((primaryWeapon _unit != "") or (secondaryWeapon _unit != "") or (handgunWeapon _unit != "")) exitWith {};
};

_unit removeAllEventHandlers "FIRED";
if (!captive _unit) then {_unit groupChat "Shit, they have spotted me!"} else {_unit setCaptive false};
if (captive player) then {sleep 5};

_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit setUnitPos "AUTO";

// load and add gear.
_sinMochi = false;
if ((backpack _unit == "") and (_secondaryWeapon == "")) then {
	_sinMochi = true;
	_unit addbackpack "B_AssaultPack_blk";
};
{if (_x != "") then {[_unit, _x, 1, 0] call BIS_fnc_addWeapon};} forEach [_primaryWeapon,_secondaryWeapon,_handGunWeapon];
{_unit addPrimaryWeaponItem _x} forEach _primaryWeaponItems;
{_unit addSecondaryWeaponItem _x} forEach _secondaryWeaponItems;
{_unit addHandgunItem _x} forEach _handgunItems;
if (_sinMochi) then {removeBackpack _unit};
_unit addHeadgear _casco;
_unit linkItem _hmd;
_unit setBehaviour _behaviour;
