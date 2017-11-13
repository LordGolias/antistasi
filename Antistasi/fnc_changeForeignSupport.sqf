#include "macros.hpp"
AS_SERVER_ONLY("fnc_changeForeignSupport.sqf");

// locking to avoid race conditions
waitUntil {isNil "lockForeignSupportChange"};
lockForeignSupportChange = true;

params ["_nato", "_csat"];

private _natoT = AS_P("NATOsupport");
private _csatT = AS_P("CSATsupport");

// nato,csat: how much it will change.
if (_natoT + _nato < 0) then {
	_nato = -_natoT;
};
if (_natoT + _nato > 100) then {
	_nato = 100 - _natoT;
};
if (_csatT + _csat < 0) then {
	_csat = -_csatT;
};
if (_csatT + _csat > 100) then {
	_csat = 100 - _csatT;
};

if (_nato != 0) then {AS_Pset("NATOsupport",_natoT + _nato)};
if (_csat != 0) then {AS_Pset("CSATsupport",_csatT + _csat)};
lockForeignSupportChange = nil;

// no change, exit
if (_nato == 0 and _csat == 0) exitWith {};

private _getSign = {
	if (_this > 0) exitWith  {
		"+"
	};
	if (_this < 0) exitWith  {
		"-"
	};
	""
};

private _text = "<t size='0.6' color='#C1C0BB'>Foreign support change:<br/> <t size='0.5' color='#C1C0BB'><br/>";
if (_nato != 0) then {
	_text = _text + format["%1: %2%3", AS_NATOname, _nato call _getSign, _nato];
};
if (_csat != 0) then {
	_text = _text + format["%1: %2%3", AS_CSATname, _csat call _getSign, _csat];
};

[petros,"income",_text] remoteExec ["AS_fnc_localCommunication",AS_commander];
