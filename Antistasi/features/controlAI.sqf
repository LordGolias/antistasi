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


AS_fncUI_controlUnit = {
    closeDialog 0;
    if ((count groupselectedUnits player != 1) and (count hcSelected player != 1)) exitWith {
        hint "You must select either a squad from the HC or a unit from your squad";
    };
    if (count groupselectedUnits player == 1) then {
        [groupselectedUnits player select 0] spawn AS_fnc_controlUnit;
    };
    if (count hcSelected player == 1) then {
        [hcSelected player select 0] spawn AS_fnc_controlHCSquad;
    };
};


AS_fnc_controlUnit = {
    params ["_unit"];

    if (_unit == Petros) exitWith {
    	hint "You cannot control Petros";
    };

    if (player != leader group player) exitWith {hint "You cannot control AI if you are not the squad leader"};
    if (isPlayer _unit) exitWith {hint "You cannot control another player"};
    if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
    if (_unit call AS_fnc_isUnconscious) exitWith {hint "You cannot control an unconscious unit"};
    if (captive _unit) exitWith {hint "You cannot control an Undercover unit"};
    if ((not(typeOf _unit in AS_allFIASoldierClasses)) and ([_unit] call AS_fnc_getFIAUnitType != "Survivor")) exitWith {hint "You cannot control a unit which does not belong to FIA"};
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
};


AS_fnc_controlHCSquad = {
    if (player != AS_commander) exitWith {hint "Only Commander has the ability to control HC units"};
    params ["_group"];
    private _unit = leader _group;

    if (_unit call AS_fnc_isUnconscious) exitWith {hint "You cannot control an unconscious unit"};
    if (!alive _unit) exitWith {hint "You cannot control a dead unit"};
    if ((not(typeOf _unit in AS_allFIASoldierClasses)) and ([_unit] call AS_fnc_getFIAUnitType != "Survivor")) exitWith {
        hint "You cannot control a unit which does not belong to FIA"
    };

    while {(count (waypoints _group)) > 0} do {
        deleteWaypoint ((waypoints _group) select 0);
    };

    private _wp = _group addwaypoint [getpos _unit, 0];

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
};
