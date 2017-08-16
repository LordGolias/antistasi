#include "../macros.hpp"
AS_CLIENT_ONLY("AS_fnc_addAction.sqf");

params ["_object","_type"];

#define IS_PLAYER "(isPlayer _this) and (_this == _this getVariable ['owner',_this])"
#define IS_COMMANDER "(isPlayer _this) and (_this == _this getVariable ['owner',_this]) and (_this == AS_commander)"


switch _type do {
	case "unit": {_object addAction [localize "STR_act_recruitUnit", {call AS_fncUI_RecruitUnitMenu},nil,0,false,true,"",IS_PLAYER];};
	case "vehicle": {_object addAction [localize "STR_act_buyVehicle", {call AS_fncUI_buyVehicleMenu},nil,0,false,true,"",IS_PLAYER];};
	case "mission": {petros addAction [localize "STR_act_missionRequest", {call AS_fncUI_manageMissionsMenu},nil,0,false,true,"",IS_COMMANDER];};
	case "camion": {_object addAction [localize "STR_act_loadAmmobox", "actions\transfer.sqf",nil,0,false,true]};
	case "remove": {
		for "_i" from 0 to (_object addAction ["",""]) do {
			_object removeAction _i;
		};
	};
	case "refugiado": {_object addAction [localize "STR_act_orderRefugee", "actions\liberaterefugee.sqf",nil,0,false,true]};
	case "prisionero": {_object addAction [localize "STR_act_liberate", "actions\liberatePOW.sqf",nil,0,false,true]};
	case "interrogar": {_object addAction [localize "STR_act_interrogate", "actions\interrogar.sqf",nil,0,false,true,"",IS_PLAYER]};
	case "capturar": {_object addAction [localize "STR_act_offerToJoin", "actions\capturar.sqf",nil,0,false,true,"",IS_PLAYER]};
	case "buildHQ": {_object addAction [localize "STR_act_buildHQ", {[] remoteExec ["AS_fnc_HQbuild", 2]},nil,0,false,true,"",IS_PLAYER]};
	case "seaport": {_object addAction ["Buy Boat", "actions\buyBoat.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "steal": {_object addAction ["Steal Static", "actions\stealStatic.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "garage": {
		if isMultiplayer then {
			_object addAction [localize "STR_act_persGarage", {[true] spawn garage},nil,0,false,true,"",IS_PLAYER]
		} else {
			_object addAction ["FIA Garage", {[false] spawn garage},nil,0,false,true,"",IS_PLAYER]
		};
	};
	case "heal_camp": {_object addAction [localize "STR_act_useMed", "actions\heal.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "refuel": {_object addAction [localize "STR_act_refuel", "actions\refuel.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "buy_exp": {_object addAction [localize "STR_act_buy", {CreateDialog "exp_menu";},nil,0,false,true,"",IS_PLAYER];};
	case "jam": {_object addAction [localize "STR_act_jamCSAT", "actions\jamLRRAdio.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "toggle_device": {_object addAction [localize "STR_act_toggleDevice", "Scripts\toggleDevice.sqf",nil,0,false,true,"",IS_PLAYER];};
	case "unload_pamphlets": {_object addAction [localize "STR_act_pamphlets", {server setVariable ["pr_unloading_pamphlets", true, true]; [[_this select 0,"remove"],"AS_fnc_addAction"] call BIS_fnc_MP;},nil,0,false,true,"",IS_PLAYER];};
	case "moveObject" : {_object addAction [localize "STR_act_moveAsset", "actions\moveObject.sqf",nil,0,false,true,"",IS_COMMANDER]};
	case "deploy" : {_object addAction [localize "STR_act_buildPad", {[_this select 0, _this select 1] remoteExec ["fnc_deployPad", 2]},nil,0,false,true,"",IS_COMMANDER]};
	case "arsenal" : {_object addAction [localize "STR_act_arsenal", "actions\arsenal.sqf",nil,0,false,true,"","(isPlayer _this)"]};
	case "emptyCrate" : {_object addAction [localize "STR_act_unloadCargo", "actions\emptyToArsenal.sqf",nil,0,false,true,"","(isPlayer _this)"]};

	default {
		diag_log format ["[AS] Error: AS_fnc_addAction: invalid action type '%1'", _type];
	};
};
