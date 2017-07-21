#include "macros.hpp"
AS_SERVER_ONLY("resourcesFIA.sqf");

waitUntil {sleep 5; isNil "AS_resourcesIsChanging"};
AS_resourcesIsChanging = true;

params [["_hr", 0], ["_resourcesFIA", 0]];

private _hrT = AS_P("hr");
private _resourcesFIAT = AS_P("resourcesFIA");

_hrT = _hrT + _hr;
_resourcesFIAT = round (_resourcesFIAT + _resourcesFIA);

if (_hrT > 0) then {
	_hrT = _hrT min (["HR"] call fnc_BE_permission);
};
_hrT = _hrT max 0;
_resourcesFIAT = _resourcesFIAT max 0;

AS_Pset("hr", _hrT);
AS_Pset("resourcesFIA", _resourcesFIAT);
AS_resourcesIsChanging = nil;

private _texto = "";
private _hrSim = "";
if (_hr > 0) then {_hrSim = "+"};

private _resourcesFIASim = "";
if (_resourcesFIA > 0) then {_resourcesFIASim = "+"};
if ((_hr != 0) and (_resourcesFIA != 0)) then {
	_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1<br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]
} else {
	if (_hr != 0) then {
		_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1",_hr,_resourcesFIA,_hrSim]
	} else {
		_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]
	};
};

if (_texto != "") then {
	[petros,"income",_texto] remoteExec ["commsMP", AS_commander]
};
