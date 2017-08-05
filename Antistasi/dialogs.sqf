#include "macros.hpp"

AS_UIfnc_change_var = {
    params ["_var", "_amount", ["_bound", nil], ["_message", "%1"]];

    if (_var == "minAISkill" and _amount > 0) then {
        _bound = AS_P("maxAISkill");
    };
    if (_var == "maxAISkill" and _amount < 0) then {
        _bound = AS_P("minAISkill");
    };

    private _newValue = AS_P(_var) + _amount;
    if (_amount < 0 and (!isNil "_bound")) then {
        _newValue = (_newValue max _bound);
    };
    if (_amount > 0 and (!isNil "_bound")) then {
        _newValue = (_newValue min _bound);
    };
    AS_Pset(_var, _newValue);

    if (_var in ["minAISkill", "maxAISkill"]) then {
        hint format ["min AI skill between [%1,%2]", AS_P("minAISkill"), AS_P("maxAISkill")];
    } else {
        if (_var == "cleantime") then {
            _newValue = _newValue/60;
        };
        if (_var == "civPerc") then {
            _newValue = _newValue*100;
        };
        hint format [_message, _newValue];
    };
};

AS_UIfnc_toggle_bool = {
    params ["_var", "_onMessage", "_offMessage"];
    if (AS_P(_var)) then {
        AS_Pset(_var,false);
        hint _offMessage;
    } else {
        AS_Pset(_var,true);
        hint _onMessage;
    };
};

AS_fncUI_toggleElegibility = {
    if not isMultiplayer exitWith {
        hint "Not possible: in single player you are always the commander.";
    };

    private _player = player getVariable ["owner", player];

    private _text = "";

    private _eligible = _player getVariable ["elegible", true];

    if (_player == AS_commander) then {
        ["resigned"] remoteExec ["AS_fnc_chooseCommander", 2];
        _text = "You resigned as commander. Someone suitable will take the command.";
    } else {
        if _eligible then {
            _player setVariable ["elegible", false, true];
            _text = "You are no longer eligible to be commander.";
        } else {
            _player setVariable ["elegible", true, true];
            _text = "You are now elegible to be commander.";
        };
    };
};

AS_fncUI_donateMoney = {
    params [["_toCursorTarget", false]];

    if (player != player getVariable ["owner", player]) exitWith {
    	hint "You can't donate when you are controlling an AI";
    };

    if ((player getVariable "money") < 100) exitWith {
    	hint "You have less than 100 € to donate";
    };

    if not _toCursorTarget exitWith {
    	[-100] call resourcesPlayer;
    	[0, 100] remoteExec ["resourcesFIA", 2];
    	player setVariable ["score", (player getVariable ["score", 0]) + 2,true];

    	hint "You have donated 100 € to FIA. This will raise your status among FIA forces";
    };

    private _target = cursortarget;

    if (!isPlayer _target) exitWith {
    	hint "You must be looking to a player in order to give him money (and he must not be controlling an AI)";
    };
    if (_target != _target getVariable ["owner", _target]) exitWith {
    	hint "You can't donate to a controlled AI";
    };

    [-100] call resourcesPlayer;
    _target setVariable ["money", (_target getVariable "money") + 100, true];
    hint format ["You donated 100 € to %1", name _target];
};


call compile preProcessFileLineNumbers "dialogs\recruitUnit.sqf";
call compile preProcessFileLineNumbers "dialogs\recruitSquad.sqf";
call compile preProcessFileLineNumbers "dialogs\recruitGarrison.sqf";
call compile preProcessFileLineNumbers "dialogs\manageLocations.sqf";
call compile preProcessFileLineNumbers "dialogs\manageMissions.sqf";
call compile preProcessFileLineNumbers "dialogs\buyVehicle.sqf";
call compile preProcessFileLineNumbers "dialogs\HQmenu.sqf";
