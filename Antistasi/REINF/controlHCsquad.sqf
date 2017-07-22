if (player != AS_commander) exitWith {hint "Only Commander has the ability to control HC units"};

params ["_groups"];
private _grupo = _groups select 0;
private _unit = leader _grupo;

if (_unit getVariable ["inconsciente",false]) exitWith {hint "You cannot control an unconscious unit"};
if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
if ((not(typeOf _unit in AS_allFIASoldierClasses)) and ([_unit] call AS_fnc_getFIAUnitType != "Survivor")) exitWith {
    hint "You cannot control a unit which does not belong to FIA"
};

while {(count (waypoints _grupo)) > 0} do {
    deleteWaypoint ((waypoints _grupo) select 0);
};

private _wp = _grupo addwaypoint [getpos _unit, 0];

{
    if (_x != vehicle _x) then {
    	[_x] orderGetIn true;
	};
} forEach units group player;

hcShowBar false;
hcShowBar true;

// _unit != player
_unit call AS_fnc_setAIControl;
// _unit == player

player addAction [localize "STR_act_returnControl",{selectPlayer (player getVariable ["owner",player])}];

private _tiempo = 10;
waitUntil {sleep 1;
    hint format ["Time to return control to AI: %1", _tiempo];
    _tiempo = _tiempo - 1; (_tiempo < 0) or {not call AS_fnc_controlsAI}
};
hint "";

removeAllActions player;
call AS_fnc_safeDropAIControl;

{[_x] joinsilent group player} forEach units group player;
group player selectLeader player;
