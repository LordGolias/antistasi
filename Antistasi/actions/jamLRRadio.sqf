_l1 = ["Petros", "CSAT frequencies jammed already."];
_l2 = ["Petros", "No technicians available."];
_l3 = ["Petros", "Not enough juice."];

if (server getVariable "blockCSAT") exitWith {[[_l1],"DIRECT",0.15] execVM "createConv.sqf";};
if ((server getVariable "jTime") > dateToNumber date) exitWith {[[_l2],"DIRECT",0.15] execVM "createConv.sqf";};


_s = antenas;
_c = 0;

if (count _s > 0) then {
	for "_i" from 0 to (count _s - 1) do {
		_antenna = _s select _i;
		private _location = (getPos _antenna) call AS_fnc_location_nearest;
		if (_location call AS_fnc_location_side == "FIA") then {_c = _c + 1};
	};
};

if (_c < 1) exitWith {[[_l3],"DIRECT",0.15] execVM "createConv.sqf"};
_jDuration = 20 + (_c * 10);
_delay = 20 + (10 * (round (_c / 3)));
_cd = 60 + (_c * 20);


_text = format ["CSAT will be able to burn through the jamming in %1 minutes.", _jDuration];

_l5 = ["Petros", "CSAT has lost the bleeps, the sweeps, and the creeps."];
_l6 = ["Petros", _text];
[[_l5, _l6],"SIDE",0.15] execVM "createConv.sqf";

[_delay * 60, false] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];

_jtime = dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + _cd];

server setVariable ["jTime", _jtime, true];
server setVariable ["blockCSAT", true, true];

sleep (_jDuration * 60);

server setVariable ["blockCSAT", false, true];
