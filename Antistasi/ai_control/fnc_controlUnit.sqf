params ["_unit"];

if (_unit == Petros) exitWith {
    hint "You cannot control Petros";
};

if (player != leader group player) exitWith {hint "You cannot control AI if you are not the squad leader"};
if (isPlayer _unit) exitWith {hint "You cannot control another player"};
if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
if (_unit call AS_medical_fnc_isUnconscious) exitWith {hint "You cannot control an unconscious unit"};
if (captive _unit) exitWith {hint "You cannot control an Undercover unit"};
if (_unit call AS_fnc_getSide != "FIA") exitWith {
    hint "You cannot control a unit that does not belong to FIA";
};
if (call AS_fnc_controlsAI) exitWith {hint "You cannot control AI while you are controlling another AI"};

{
    if (_x != vehicle _x) then {
        [_x] orderGetIn true;
    };
} forEach units group player;

// _unit != player
_unit call AS_fnc_setAIControl;
// _unit == player

_unit addAction [localize "STR_act_returnControl",{selectPlayer leader (group (_this select 0))}];

private _tiempo = 10;
waitUntil {
    sleep 1; hint format ["Time to return control to AI: %1", _tiempo];
    _tiempo = _tiempo - 1; (_tiempo == -1) or {not call AS_fnc_controlsAI}
};
hint "";

removeAllActions _unit;
call AS_fnc_safeDropAIControl;

{[_x] joinsilent group player} forEach units group player;
group player selectLeader player;
