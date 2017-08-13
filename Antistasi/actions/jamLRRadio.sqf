if (server getVariable "blockCSAT") exitWith {
	hint "CSAT frequencies already jammed.";
};
if ((server getVariable ["timeToNextJam", 0]) > dateToNumber date) exitWith {
	hint format ["No technicians available. Wait more %1 minutes", server getVariable "timeToNextJam"];
};

private _antenasFIA = 0;
{
	private _location = _x call AS_fnc_location_nearest;
	if (_location call AS_fnc_location_side == "FIA") then {
		_antenasFIA = _antenasFIA + 1
	};
} forEach AS_antenasPos_alive;

private _jDuration = 20 + (_antenasFIA * 10);
private _cd = 20 + (_antenasFIA * 20);

hint format ["CSAT has lost radio signal and will not be able to attack in the next %1 minutes.", _jDuration];

private _jtime = dateToNumber [date select 0, date select 1, date select 2, date select 3, (date select 4) + _cd];

server setVariable ["timeToNextJam", _jtime, true];
server setVariable ["blockCSAT", true, true];

sleep (_jDuration * 60);

server setVariable ["blockCSAT", false, true];
