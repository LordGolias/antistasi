if (isDedicated) exitWith {};

if !(server getVariable ["enableWpnProf", false]) exitWith {};

#define OFF_AIM [1.5, 2.5, 2.5]
#define RIF_AIM [1, 3, 3]
#define LAT_AIM [1, 3, 3]
#define AR_AIM [1.5, 1, 3]
#define ENG_AIM [3, 4, 4]
#define MED_AIM [3, 4, 4]
#define AMM_AIM [1, 3, 3]
#define MRK_AIM [1, 2, 1]
#define TL_AIM [1.5, 2.5, 2.5]

#define OFF_REC [1.5, 2, 2]
#define RIF_REC [1, 2.5, 2.5]
#define LAT_REC [1, 2.5, 2.5]
#define AR_REC [1, 1, 2]
#define ENG_REC [2, 3, 3]
#define MED_REC [2, 3, 3]
#define AMM_REC [1, 2.5, 2.5]
#define MRK_REC [1.5, 2.5, 1]
#define TL_REC [1.5, 2, 2]

#define MSG_HGH "<t color='#1DA81D' size = '.8'>You are very familiar with this type of weapon.</t>"
#define MSG_LOW "<t color='#f59900' size='.45' align='center'>Warning! You lack the proficiency to effectively operate this weapon.</t>"

private _class = typeOf player;

_fnc_text = {
	params ["_text"];
	[_text,[0.2 * safeZoneW + safeZoneX, 1 * safezoneH + safezoneY],[0.03 * safezoneH + safezoneY, 1 * safezoneH + safezoneY],3,0,0,16] spawn BIS_fnc_dynamicText;
};

_fnc_adjust = {
	params ["_aim", "_recoil"];

	if (([primaryWeapon player] call BIS_fnc_baseWeapon) in mguns) exitWith {
		player setCustomAimCoef (_aim select 1);
		player setUnitRecoilCoefficient (_recoil select 1);
		if ((_aim select 1) > (_aim select 0)) then {[MSG_LOW] call _fnc_text};
	};
	if (([primaryWeapon player] call BIS_fnc_baseWeapon) in srifles) exitWith {
		player setCustomAimCoef (_aim select 2);
		player setUnitRecoilCoefficient (_recoil select 2);
		if ((_aim select 2) > (_aim select 0)) then {[MSG_LOW] call _fnc_text};
	};

	player setCustomAimCoef (_aim select 0);
	player setUnitRecoilCoefficient (_recoil select 0);
};

switch (_class) do {
	case "B_G_officer_F": {[OFF_AIM, OFF_REC] call _fnc_adjust};
	case "B_G_Soldier_F":  {[RIF_AIM, RIF_REC] call _fnc_adjust};
	case "B_G_Soldier_LAT_F": {[LAT_AIM, LAT_REC] call _fnc_adjust};
	case "B_G_Soldier_AR_F": {[AR_AIM, AR_REC] call _fnc_adjust};
	case "B_G_engineer_F":  {[ENG_AIM, ENG_REC] call _fnc_adjust};
	case "B_G_medic_F":  {[MED_AIM, MED_REC] call _fnc_adjust};
	case "B_G_Soldier_A_F":  {[AMM_AIM, AMM_REC] call _fnc_adjust};
	case "B_G_Soldier_M_F":  {[MRK_AIM, MRK_REC] call _fnc_adjust};
	case "B_G_Soldier_TL_F": {[TL_AIM, TL_REC] call _fnc_adjust};
};