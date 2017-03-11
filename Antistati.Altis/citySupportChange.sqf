private ["_opfor","_blufor","_pos","_ciudad","_datos","_numCiv","_numVeh","_roads","_prestigeOPFOR","_prestigeBLUFOR"];

waitUntil {!cityIsSupportChanging};
cityIsSupportChanging = true;
_opfor = _this select 0;
_blufor = _this select 1;
_pos = _this select 2;
if (typeName _pos == typeName "") then {_ciudad = _pos} else {_ciudad = [ciudades, _pos] call BIS_fnc_nearestPosition};
_datos = server getVariable _ciudad;
if (!(_datos isEqualType [])) exitWith {citySupportChanging = true; diag_log format ["Error in citysupportchange.sqf. Passed %1 as reference",_pos]};
_numCiv = _datos select 0;
_numVeh = _datos select 1;
_prestigeOPFOR = _datos select 2;
_prestigeBLUFOR = _datos select 3;

if (_prestigeOPFOR + _prestigeBLUFOR > 100) then {
	_prestigeOPFOR = round (_prestigeOPFOR / 2);
	_prestigeBLUFOR = round (_prestigeBLUFOR / 2);
};

if ((_blufor > 0) && ((_prestigeBLUFOR > 90) || (_prestigeBLUFOR + _prestigeOPFOR > 90))) then {
	_blufor = 0;
	_opfor = _opfor - 5;
}
else {
	if ((_opfor > 0) && ((_prestigeOPFOR > 90) || (_prestigeBLUFOR + _prestigeOPFOR > 90))) then {
		_opfor = 0;
		_blufor = _blufor - 5;
	};
};

if (_prestigeOPFOR + _prestigeBLUFOR + _opfor > 100) then {
	_opfor = 100 - (_prestigeOPFOR + _prestigeBLUFOR);
};
_prestigeOPFOR = _prestigeOPFOR + _opfor;

if (_prestigeOPFOR + _prestigeBLUFOR + _blufor > 100) then {
	_blufor = 100 - (_prestigeOPFOR + _prestigeBLUFOR);
};
_prestigeBLUFOR = _prestigeBLUFOR + _blufor;


if (_prestigeOPFOR > 99) then {_prestigeOPFOR = 99};
if (_prestigeBLUFOR > 99) then {_prestigeBLUFOR = 99};
if (_prestigeOPFOR < 1) then {_prestigeOPFOR = 1};
if (_prestigeBLUFOR < 1) then {_prestigeBLUFOR = 1};

if (_prestigeBLUFOR + _prestigeOPFOR < 5) then {_prestigeOPFOR = 1; _prestigeBLUFOR = 5};

_datos = [_numCiv, _numVeh,_prestigeOPFOR,_prestigeBLUFOR];

server setVariable [_ciudad,_datos,true];
cityIsSupportChanging = false;
true