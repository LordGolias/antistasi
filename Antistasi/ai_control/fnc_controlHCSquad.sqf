if (player != AS_commander) exitWith {hint "Only Commander has the ability to control HC units"};
params ["_group"];
private _unit = leader _group;

if (_unit call AS_medical_fnc_isUnconscious) exitWith {hint "You cannot control an unconscious unit"};
if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
if (_unit call AS_fnc_getSide != "FIA") exitWith {
    hint "You cannot control a squad that does not belong to FIA";
};

while {(count (waypoints _group)) > 0} do {
    deleteWaypoint ((waypoints _group) select 0);
};

_group addwaypoint [getpos _unit, 0];

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

player addAction [localize "STR_act_returnControl", AS_fnc_dropAIcontrol];

private _tiempo = 10;
waitUntil {sleep 1;
    hint format ["Time to return control to AI: %1", _tiempo];
    _tiempo = _tiempo - 1; (_tiempo < 0) or {not call AS_fnc_controlsAI}
};
hint "";

removeAllActions _unit;
call AS_fnc_safeDropAIControl;

{[_x] joinsilent group player} forEach units group player;
group player selectLeader player;
