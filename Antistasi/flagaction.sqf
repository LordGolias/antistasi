private ["_flag","_tipo"];

if (isDedicated) exitWith {};

_flag = _this select 0;
_tipo = _this select 1;

switch _tipo do {
	case "take": {removeAllActions _flag; _flag addAction [localize "STR_act_takeFlag", {[[_this select 0, _this select 1],"mrkWIN"] call BIS_fnc_MP;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]};
	case "unit": {_flag addAction [localize "STR_act_recruitUnit", {call AS_fncUI_RecruitUnitMenu},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "vehicle": {_flag addAction [localize "STR_act_buyVehicle", {nul = createDialog "vehicle_option";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "mission": {petros addAction [localize "STR_act_missionRequest", {nul=CreateDialog "mission_menu";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "misCiv": {_flag addAction [localize "STR_act_missionRequest", {nul=CreateDialog "misCiv_menu";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "misMil": {_flag addAction [localize "STR_act_missionRequest", {nul=CreateDialog "misMil_menu";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "camion": {_flag addAction [localize "STR_act_loadAmmobox", "Municion\transfer.sqf",nil,0,false,true]};
	case "remove":
	{
	//removeAllActions _flag
	for "_i" from 0 to (_flag addAction ["",""]) do
		{
		_flag removeAction _i;
		};
	};
	case "refugiado": {_flag addAction [localize "STR_act_orderRefugee", "AI\liberaterefugee.sqf",nil,0,false,true]};
	case "prisionero": {_flag addAction [localize "STR_act_liberate", "AI\liberatePOW.sqf",nil,0,false,true]};
	case "interrogar": {_flag addAction [localize "STR_act_interrogate", "AI\interrogar.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]};
	case "capturar": {_flag addAction [localize "STR_act_offerToJoin", "AI\capturar.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]};
	case "buildHQ": {_flag addAction [localize "STR_act_buildHQ", {[] spawn buildHQ},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]};
	case "seaport": {_flag addAction ["Buy Boat", "REINF\buyBoat.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "steal": {_flag addAction ["Steal Static", "REINF\stealStatic.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "garage":
		{
		if (isMultiplayer) then
			{
			_flag addAction [localize "STR_act_persGarage", {nul = [true] spawn garage},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]
			}
		else
			{
			_flag addAction ["FIA Garage", {nul = [false] spawn garage},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"]
			};
		};
	case "heal_camp": {_flag addAction [localize "STR_act_useMed", "heal.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "refuel": {_flag addAction [localize "STR_act_refuel", "refuel.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "conversation": {_flag addAction [localize "STR_act_talk", "AI\conversation.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "buy_exp": {_flag addAction [localize "STR_act_buy", {nul=CreateDialog "exp_menu";},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "jam": {_flag addAction [localize "STR_act_jamCSAT", "jamLRRAdio.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "toggle_device": {_flag addAction [localize "STR_act_toggleDevice", "Scripts\toggleDevice.sqf",nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "unload_pamphlets": {_flag addAction [localize "STR_act_pamphlets", {server setVariable ["pr_unloading_pamphlets", true, true]; [[_this select 0,"remove"],"flagaction"] call BIS_fnc_MP;},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];};
	case "moveObject" : {_flag addAction [localize "STR_act_moveAsset", "moveObject.sqf",nil,0,false,true,"","(_this == AS_commander)"]};
	case "deploy" : {_flag addAction [localize "STR_act_buildPad", {[_this select 0, _this select 1] remoteExec ["fnc_deployPad", 2]},nil,0,false,true,"","(_this == AS_commander)"]};
};
