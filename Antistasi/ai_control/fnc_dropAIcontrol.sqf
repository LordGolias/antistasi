private _owner = player getVariable ["owner", player];
if (_owner == player) exitWith {
    diag_log format ["[AS] Error: AS_fnc_dropAIcontrol: cannot drop control without controlling a unit", player];
};

player setVariable ["owner", nil, true];
selectPlayer _owner;
