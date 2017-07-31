#include "macros.hpp"
AS_SERVER_ONLY("fnc_changeForeignSupport.sqf");

// locking to avoid race conditions
waitUntil {isNil "lockForeignSupportChange"};
lockForeignSupportChange = true;

params ["_nato", "_csat"];

private _natoT = AS_P("NATOsupport");
private _csatT = AS_P("CSATsupport");

_natoT = _natoT + _nato;
_csatT = _csatT + _csat;

if (_natoT < 0) then {_natoT = 0};
if (_natoT > 100) then {_natoT = 100};
if (_csatT < 0) then {_csatT = 0};
if (_csatT > 100) then {_csatT = 100};


if (_nato != 0) then {AS_Pset("NATOsupport",_natoT)};
if (_csat != 0) then {AS_Pset("CSATsupport",_csatT)};
lockForeignSupportChange = nil;

private _texto = "";
private _natoSim = "";
if (_nato > 0) then {_natoSim = "+"};

private _csatSim = "";
if (_csat > 0) then {_csatSim = "+"};
if ((_nato != 0) and (_csat != 0)) then
	{
	_texto = format ["<t size='0.6' color='#C1C0BB'>Foreign support change.<br/> <t size='0.5' color='#C1C0BB'><br/>NATO: %3%1<br/>CSAT: %4%2",_nato,_csat,_natoSim,_csatSim]
} else {
	if (_nato != 0) then {_texto = format ["<t size='0.6' color='#C1C0BB'>Foreign support change.<br/> <t size='0.5' color='#C1C0BB'><br/>NATO: %3%1",_nato,_csat,_natoSim]
	} else {
		_texto = format ["<t size='0.6' color='#C1C0BB'>Foreign support change.<br/> <t size='0.5' color='#C1C0BB'><br/>CSAT: %4%2",_nato,_csat,_natoSim,_csatSim]
	};
};

if (_texto != "") then {[petros,"income",_texto] remoteExec ["commsMP",AS_commander]};
