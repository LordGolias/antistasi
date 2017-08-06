AS_fnc_controlsAI = {
    // whether the player controls an ai
    player getVariable ["owner", player] != player
};

AS_fnc_setAIControl = {
    if (_this getVariable ["owner", _this] != _this) exitWith {
        diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control a controlled unit", _this];
    };
    if (call AS_fnc_controlsAI) exitWith {
        diag_log format ["[AS] Error: AS_fnc_setAIControl: trying to control unit while controlling a unit", player];
    };

    _this setVariable ["owner", player, true];
    selectPlayer _this;
};


AS_fnc_dropAIcontrol = {
    private _owner = player getVariable ["owner", player];
    if (_owner == player) exitWith {
        diag_log format ["[AS] Error: AS_fnc_dropAIcontrol: cannot drop control without controlling a unit", player];
    };

    player setVariable ["owner", nil, true];
    selectPlayer _owner;
};


AS_fnc_safeDropAIcontrol = {
    if (call AS_fnc_controlsAI) exitWith {
    	player call AS_fnc_dropAIcontrol;
        true
    };
    false
};


AS_fnc_completeDropAIcontrol = {
    if (call AS_fnc_safeDropAIcontrol) then {
        {[_x] joinsilent group player} forEach units group player;
        group player selectLeader player;
    };
};
