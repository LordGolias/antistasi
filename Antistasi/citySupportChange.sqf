private ["_opfor","_blufor","_pos","_city","_datos","_numCiv","_numVeh","_roads"];

waitUntil {!cityIsSupportChanging};
cityIsSupportChanging = true;
_opfor = _this select 0;
_blufor = _this select 1;
_pos = _this select 2;

private _city = "";
if (typeName _pos == typeName "") then {
	_city = _pos
} else {
	_city = [call AS_fnc_location_cities, _pos] call BIS_fnc_nearestPosition;
};

private _FIAsupport = [_city, "FIAsupport"] call AS_fnc_location_get;
private _AAFsupport = [_city, "AAFsupport"] call AS_fnc_location_get;

if (_AAFsupport + _FIAsupport > 100) then {
	_AAFsupport = round (_AAFsupport / 2);
	_FIAsupport = round (_FIAsupport / 2);
};

if ((_blufor > 0) && ((_FIAsupport > 90) || (_FIAsupport + _AAFsupport > 90))) then {
	_blufor = 0;
	_opfor = _opfor - 5;
}
else {
	if ((_opfor > 0) && ((_AAFsupport > 90) || (_FIAsupport + _AAFsupport > 90))) then {
		_opfor = 0;
		_blufor = _blufor - 5;
	};
};

if (_AAFsupport + _FIAsupport + _opfor > 100) then {
	_opfor = 100 - (_AAFsupport + _FIAsupport);
};
_AAFsupport = _AAFsupport + _opfor;

if (_AAFsupport + _FIAsupport + _blufor > 100) then {
	_blufor = 100 - (_AAFsupport + _FIAsupport);
};
_FIAsupport = _FIAsupport + _blufor;


if (_AAFsupport > 99) then {_AAFsupport = 99};
if (_FIAsupport > 99) then {_FIAsupport = 99};
if (_AAFsupport < 1) then {_AAFsupport = 1};
if (_FIAsupport < 1) then {_FIAsupport = 1};

if (_FIAsupport + _AAFsupport < 5) then {_AAFsupport = 1; _FIAsupport = 5};

[_city, "FIAsupport", _FIAsupport] call AS_fnc_location_set;
[_city, "AAFsupport", _AAFsupport] call AS_fnc_location_set;

cityIsSupportChanging = false;
true
