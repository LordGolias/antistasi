#include "macros.hpp"
#include "statSave\dialogs.hpp"
#include "dialogs\recruitUnit.hpp"
#include "dialogs\recruitSquad.hpp"
#include "dialogs\recruitGarrison.hpp"
#include "dialogs\HQmenu.hpp"

class buy_vehicle
{
	idd=100;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,  "Purchase Military Vehicle", "closeDialog 0; nul = createDialog ""vehicle_option"";");
BTN_L(1,104, "Buy Quadbike", "", "closedialog 0; nul = [vfs select 3] call buyFIAveh");
BTN_L(2,105, "Buy Offroad/UAZ", "", "closedialog 0; nul = [vfs select 4] call buyFIAveh");
BTN_L(3,106, "Buy Truck", "", "closedialog 0; nul = [vfs select 5] call buyFIAveh");
BTN_L(4,110, "Buy Static AT", "", "closedialog 0; nul = [vfs select 9] call buyFIAveh");

BTN_R(1,107, "Buy Armed Offroad", "", "closedialog 0; nul = [vfs select 6] call buyFIAveh");
BTN_R(2,109, "Buy Mortar", "", "closedialog 0; nul = [vfs select 8] call buyFIAveh");
BTN_R(3,108, "Buy MG", "", "closedialog 0; nul = [vfs select 7] call buyFIAveh");
BTN_R(4,111, "Buy Static AA", "", "closedialog 0; nul = [vfs select 10] call buyFIAveh");

BTN_M(5, 112, "Buy APC", "", "if (hayRHS) then {if (player == AS_commander) then {closeDialog 0; nul = [vfs select 11] call buyFIAveh;} else {hint ""Only Player Commander has access to this function""};}else {hint ""RHS exclusive for now""};");

	};
};

class build_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(3,"Building Options", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1,"O.Post - Roadblock", "", "closeDialog 0; [""create""] spawn puestoDialog");
BTN_L(2,-1,"Build Minefield", "", "closeDialog 0; createDialog ""minebuild_menu"";");

BTN_R(1,-1,"O.Post-Roadblock Delete", "", "closeDialog 0; [""delete""] spawn puestoDialog");
BTN_R(2,-1,"Manage Camps", "Establish/Abandon Camps", "closeDialog 0; nul= createDialog ""camp_dialog"";");

BTN_M(3, -1, "HQ Fortifications", "", "closeDialog 0; nul= createDialog ""HQ_fort_dialog"";");
	};
};

class mission_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(4,"Available Missions",A_CLOSE);

#define STR_MIS_MIL "closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""FND_M""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_CIV "closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""FND_C""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_EXP "closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""FND_E""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_LOG	"closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""LOG""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_DES	"closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""DES""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_RES "closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""RES""],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"
#define STR_MIS_PRO "closeDialog 0; if ((player == AS_commander) or (not(isPlayer AS_commander))) then {[[""PR"",false,true],""missionrequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"

BTN_L(1,-1,"Military Contact", "", STR_MIS_MIL);
BTN_L(2,-1,"Civilian Contact", "", STR_MIS_CIV);
BTN_L(3,-1,"Sketchy Irishman", "", STR_MIS_EXP);

BTN_R(1,-1,"Logistics Mission", "", STR_MIS_LOG);
BTN_R(2,-1,"Destroy Mission", "", STR_MIS_DES);
BTN_R(3,-1,"Rescue Mission", "", STR_MIS_RES);

BTN_M(4, -1, "Propaganda", "", STR_MIS_PRO);
	};
};

class NATO_Options
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"NATO support", "closeDialog 0; createDialog ""radio_comm_commander"";");

BTN_L(1,-1,"Attack Mission", "Cost: 20 points", "closeDialog 0; [""NATOCA""] execVM ""NatoDialog.sqf"";");
BTN_L(2,-1,"Armored Column", "Cost: 20 points", "closeDialog 0; [""NATOArmor""] execVM ""NatoDialog.sqf"";");
BTN_L(3,-1,"Artillery", "Cost: 10 points", "closeDialog 0; [""NATOArty""] execVM ""NatoDialog.sqf"";");
BTN_L(4,-1,"Roadblock", "Cost: 10 points", "closeDialog 0; [""NATORoadblock""] execVM ""NatoDialog.sqf"";");

BTN_R(1,-1,"NATO UAV", "Cost: 10 points", "closeDialog 0; [""NATOUAV""] execVM ""NatoDialog.sqf"";");
BTN_R(2,-1,"Ammodrop", "Cost: 5 points", "closeDialog 0; [""NATOAmmo""] execVM ""NatoDialog.sqf"";");
BTN_R(3,-1,"CAS Support", "Cost: 10 points", "closeDialog 0; [""NATOCAS""] execVM ""NatoDialog.sqf"";");
BTN_R(4,-1,"Bomb Run", "Cost: 10 points", "closeDialog 0; createDialog ""carpet_bombing"";");

BTN_M(5, -1, "NATO QRF", "Cost: 10 points", "closeDialog 0; [""NATOQRF""] execVM ""NatoDialog.sqf"";");
	};
};

class squad_manager
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"HC Squad Options", "closeDialog 0; createDialog ""radio_comm_commander"";");

BTN_L(1,-1, "Squad Add Vehicle", "", "closeDialog 0; [] execVM ""REINF\addSquadVeh.sqf"";");
BTN_L(2,-1, "Squad Vehicle Stats", "", "[""stats""] execVM ""REINF\vehStats.sqf"";");

BTN_R(1,-1, "Mount / Dismount", "", "[""mount""] execVM ""REINF\vehStats.sqf""");
BTN_R(2,-1, "Static Autotarget", "", "closeDialog 0; [] execVM ""AI\staticAutoT.sqf"";");

	};
};

class veh_query
{
	idd=100;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Add Vehicle to Squad?", "closeDialog 0; vehQuery = nil; nul= [] execVM ""Dialogs\squad_recruit.sqf"";");

BTN_L(1,104, "YES", "", "closeDialog 0; vehQuery = true");
BTN_R(1,105, "NO", "", "closeDialog 0; vehQuery = nil");

	};
};
class player_money
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Player and Money Interaction", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1, "Add Server Member", "", "if (isMultiplayer) then {closeDialog 0; nul = [""add""] call memberAdd;} else {hint ""This function is MP only""};");
BTN_L(2,-1, "Remove Server Member", "", "if (isMultiplayer) then {closeDialog 0; nul = [""remove""] call memberAdd;} else {hint ""This function is MP only""};");

BTN_R(1,-1, "Donate 100 € to player", "", "[true] call donateMoney;");
BTN_R(2,-1, "Donate 100 € to FIA", "", "[] call donateMoney;");

	};
};

class vehicle_manager
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Vehicle Manager", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1, "Garage\Sell Vehicle", "", "closeDialog 0; nul = createDialog ""garage_sell"";");
BTN_R(1,-1, "Vehicles and Squads", "", "closeDialog 0; if (player == AS_commander) then {nul = createDialog ""squad_manager""} else {hint ""Only Player Commander has access to this function""};");

BTN_M(2, -1, "Unlock Vehicle", "", "closeDialog 0; if !(isMultiplayer) then {hint ""It's unlocked already.""} else {if (player != AS_commander) then {nul = [false] call unlockVehicle} else {nul = [true] call unlockVehicle};};");

	};
};

class garage_sell
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Sell or Garage Vehicle", "closeDialog 0; createDialog ""vehicle_manager"";");

BTN_L(1,-1, "Garage Vehicle", "", "closeDialog 0; if (player != AS_commander) then {nul = [false] call garageVehicle} else {if (isMultiplayer) then {createDialog ""garage_check""} else {nul = [true] call garageVehicle}};");
BTN_R(1,-1, "Sell Vehicle", "", "closeDialog 0; if (player == AS_commander) then {nul = [] call sellVehicle} else {hint ""Only the Commander can sell vehicles""};");

	};
};
class garage_check
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Personal or FIA Garage?", "closeDialog 0; createDialog ""garage_sell"";");

BTN_L(1,-1, "Personal Garage", "", "closeDialog 0; nul = [false] call garageVehicle;");
BTN_R(1,-1, "FIA Garage", "", "closeDialog 0; nul = [true] call garageVehicle;");

	};
};
class vehicle_option
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Buy Vehicle",A_CLOSE);

BTN_L(1,-1, "Civilian Vehicle", "", "closeDialog 0; nul=[] execVM ""Dialogs\buy_vehicle_civ.sqf"";");
BTN_R(1,-1, "Military Vehicle", "", "closeDialog 0; nul=[] execVM ""Dialogs\buy_vehicle.sqf"";");

	};
};
class civ_vehicle
{
	idd=100;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Buy Civilian Vehicle","closeDialog 0; nul = createDialog ""vehicle_option"";");

BTN_L(1,104, "Offroad", "", "closeDialog 0; nul = [vfs select 0] call buyFIAveh;");
BTN_R(1,105, "Truck", "", "closeDialog 0; nul = [vfs select 1] call buyFIAveh;");

BTN_M(2, 106, "Helicopter", "", "closeDialog 0; nul = [vfs select 2] call buyFIAveh;");

	};
};
class carpet_bombing
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Carpet Bombing Strike","closeDialog 0; nul = createDialog ""NATO_Options"";");

BTN_L(1,-1, "HE Bombs", "Cost: 10 points", "closeDialog 0; [""HE""] execVM ""REINF\NATObomb.sqf"";");
BTN_R(1,-1, "Carpet Bombing", "Cost: 10 points", "closeDialog 0; [""CARPET""] execVM ""REINF\NATObomb.sqf"";");

BTN_M(2, -1, "NAPALM Bomb", "Cost: 10 points", "closeDialog 0; [""NAPALM""] execVM ""REINF\NATObomb.sqf"";");

	};
};

class AI_management
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"AI Management","closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1, "Temp. AI Control", "", "closeDialog 0; if ((count groupselectedUnits player > 0) and (count hcSelected player > 0)) exitWith {hint ""You must select from HC or Squad Bars, not both""}; if (count groupselectedUnits player == 1) then {nul = [groupselectedUnits player] execVM ""REINF\controlunit.sqf""}; if (count hcSelected player == 1) then {nul = [hcSelected player] execVM ""REINF\controlHCsquad.sqf"";};");
BTN_L(2,-1, "Auto Heal", "", "if (autoHeal) then {autoHeal = false; hint ""Auto Healing disabled"";} else {autoHeal = true; hint ""Auto Heal enabled""; nul = [] execVM ""AI\autoHealFnc.sqf""}");

BTN_R(1,-1, "Auto Rearm", "", "closeDialog 0; if (count groupselectedUnits player == 0) then {nul = (units group player) execVM ""AI\rearmCall.sqf""} else {nul = (groupselectedUnits player) execVM ""AI\rearmCall.sqf""};");
BTN_R(2,-1, "Dismiss Units/Squads", "", "closeDialog 0; if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\dismissFIAinfantry.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\dismissFIAsquad.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}");

	};
};

class rounds_number
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(4,"Select No. Rounds to be fired",A_CLOSE);

BTN_L(1,-1, "1", "", "closeDialog 0; rondas = 1;");
BTN_L(2,-1, "2", "", "closeDialog 0; rondas = 2;");
BTN_L(3,-1, "3", "", "closeDialog 0; rondas = 3;");
BTN_L(4,-1, "4", "", "closeDialog 0; rondas = 4;");

BTN_R(1,-1, "5", "", "closeDialog 0; rondas = 5;");
BTN_R(2,-1, "6", "", "closeDialog 0; rondas = 6;");
BTN_R(3,-1, "7", "", "closeDialog 0; rondas = 7;");
BTN_R(4,-1, "8", "", "closeDialog 0; rondas = 8;");

	};
};

class strike_type
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Select type of strike",A_CLOSE);

BTN_L(1,-1, "Single Point Strike", "", "closeDialog 0; tipoArty = ""NORMAL"";");
BTN_R(1,-1, "Barrage Strike", "", "closeDialog 0; tipoArty = ""BARRAGE"";");

	};
};

class mbt_type
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Select type ammo for the strike",A_CLOSE);

BTN_L(1,-1, "HE", "", "closeDialog 0; if (hayUSAF) then {tipoMuni = ""RHS_mag_m1_he_12"";} else {tipoMuni = ""32Rnd_155mm_Mo_shells"";}");
BTN_R(1,-1, "Laser Guided", "", "closeDialog 0; tipoMuni = ""2Rnd_155mm_Mo_LG"";");

BTN_M(2, -1, "Smoke", "", "closeDialog 0; if (hayUSAF) then {tipoMuni = ""rhs_mag_m60a2_smoke_4"";} else {tipoMuni = ""6Rnd_155mm_Mo_smoke"";}");

	};
};
class mortar_type
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Select Mortar Ammo",A_CLOSE);

BTN_L(1,-1, "HE", "", "closeDialog 0; tipoMuni = ""8Rnd_82mm_Mo_shells"";");
BTN_R(1,-1, "Smoke", "", "closeDialog 0; tipoMuni = ""8Rnd_82mm_Mo_Smoke_white"";");

	};
};

class minebuild_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Build Minefield","closeDialog 0; createDialog ""build_menu"";");

BTN_L(1,-1, "APERS Mines", "", "closeDialog 0; [""APERSMine""] spawn mineDialog");
BTN_R(1,-1, "AT Mines", "", "closeDialog 0; [""ATMine""] spawn mineDialog");

	};
};

class fasttravel_dialog // 340
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(1,"Fast Travel","closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

	BTN_L(1,-1, "Fast Travel (old)", "Targets: all FIA-controlled zones", "closeDialog 0; nul = [] execVM ""fastTravelRadio.sqf"";");
	BTN_R(1,-1, "Fast Travel (new)", "Only FIA camps and HQ", "closeDialog 0; nul = [] execVM ""altFastTravel.sqf"";");

	};
};

class camp_dialog // 350
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Camp Management","closeDialog 0; createDialog ""build_menu"";");

	BTN_L(1,-1, "Establish Camp", "Price: 800 Euros", "closeDialog 0; [""create""] spawn ftravelDialog");
	BTN_R(1,-1, "Delete Camp", "", "closeDialog 0; [""delete""] spawn ftravelDialog");

	BTN_M(2, -1, "Rename Camp", "", "closeDialog 0; [""rename""] spawn ftravelDialog");

	};
};

class commander_menu // 360
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Commander Menu",A_CLOSE);

	#define STR_COM_RES "closeDialog 0; [""restrictions""] remoteExecCall [""fnc_BE_broadcast"", 2];"
	#define STR_COM_PRO "closeDialog 0; [""progress""] remoteExecCall [""fnc_BE_broadcast"", 2];"
	#define STR_COM_FIA "closeDialog 0; if (player == AS_commander) then {[""status""] remoteExecCall [""fnc_infoScreen"", 2]};"

	BTN_L(1,-1, "Current Restrictions", "Display current AXP restrictions", STR_COM_RES);
	BTN_R(1,-1, "Current Progress", "Display current AXP progress", STR_COM_PRO);

	BTN_M(2, -1, "FIA Status", "Display FIA details", STR_COM_FIA);
	};
};

class boost_menu // 390
{
	idd=-1;
	movingenable=false;

	class controls
	{
	AS_BOX(1);
	AS_FRAME(1, "Is the start too hard for you?");

	#define STR_BST_YES "closeDialog 0; if (player == AS_commander) then {[[], ""boost.sqf""] remoteExec [""execVM"", 2];};if ((player == AS_commander) and (isNil ""placementDone"")) then {[] spawn placementselection};"
	#define STR_BST_NO "closeDialog 0; [false] remoteExec [""fnc_MAINT_arsenal"", 2]; if (hayBE) then {[] call fnc_BE_refresh}; if ((player == AS_commander) and (isNil ""placementDone"")) then {[] spawn placementselection};"

	BTN_L(1,-1, "YES", "You'll get some resources, and basic gear will be unlocked", STR_BST_YES);
	BTN_R(1,-1, "NO", "Pea shooters, iron sights and plain clothes it is", STR_BST_NO);
	};
};

class misCiv_menu // 400
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Available Missions",A_CLOSE);

	#define STR_CIV_ASS "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""ASS""],""misReqCiv""] call BIS_fnc_MP} else {hint ""Stranger does not trust you.""};"
	#define STR_CIV_CVY "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""CONVOY""],""misReqCiv""] call BIS_fnc_MP} else {hint ""Stranger does not trust you.""};"
	#define STR_CIV_CON "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""CON""],""misReqCiv""] call BIS_fnc_MP} else {hint ""Stranger does not trust you.""};"

	BTN_L(1,-1, "Assassination Mission", "", STR_CIV_ASS);
	BTN_R(1,-1, "Convoy Ambush", "", STR_CIV_CVY);

	BTN_M(2, -1, "Conquest Missions", "", STR_CIV_CON);

	};
};

class misMil_menu // 410
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Available Missions",A_CLOSE);

	#define STR_MIL_ASS "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""AS""],""misReqMil""] call BIS_fnc_MP} else {hint ""Nomad does not trust you.""};"
	#define STR_MIL_CVY "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""CONVOY""],""misReqMil""] call BIS_fnc_MP} else {hint ""Nomad does not trust you.""};"
	#define STR_MIL_CON "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""CON""],""misReqMil""] call BIS_fnc_MP} else {hint ""Nomad does not trust you.""};"
	#define STR_MIL_DES "closeDialog 0; if (((getPlayerUID player) in miembros) || (player == AS_commander)) then {[[""DES""],""misReqMil""] call BIS_fnc_MP} else {hint ""Nomad does not trust you.""};"

	BTN_L(1,-1, "Assassination Mission", "", STR_MIL_ASS);
	BTN_L(2,-1, "Convoy Ambush", "", STR_MIL_CVY);

	BTN_R(1,-1, "Conquest Missions", "", STR_MIL_CON);
	BTN_R(2,-1, "Destroy Missions", "", STR_MIL_DES);

	};
};

class rCamp_Dialog // 420
{
    idd = 1;
    movingEnable = 1;
    enableSimulation = 1;
    enableDisplay = 1;
    onLoad = "uiNamespace setVariable ['rCamp', _this select 0];";
    duration = 25;
    fadein = 0;
    fadeout = 0;

    class controlsBackground {
        class RscPicture_1200: RscPicture
        {
            idc = 1200;
            text = "";
            x = 0.425 * safezoneW + safezoneX;
            y = 0.46 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.08 * safezoneH;
        };
    };

    class controls
    {
        class RscEdit_1400: RscEdit
        {
            idc = 1400;
            x = 0.435 * safezoneW + safezoneX;
            y = 0.47 * safezoneH + safezoneY;
            w = 0.13 * safezoneW;
            h = 0.03 * safezoneH;
            text = "";
            colorText[] =   {0,0,0,1};
            sizeEx = 0.05;
        };
        class SaveButton: RscButton
        {
            idc = 1600;
            text = "Save";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.51 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.02 * safezoneH;
            action = "closeDialog 0; cName = ctrlText ((uiNamespace getVariable ""rCamp"") displayCtrl 1400);";
        };
    };
};

class exp_menu // 430
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Buy Ordnance",A_CLOSE);

	#define STR_EXP_CH "if (player == AS_commander) then {[""explosives"", 800] remoteExec [""buyGear"", 2];}"

	#define STR_EXP_WP "closeDialog 0; createDialog ""wpns"";"

	#define STR_EXP_MS "if (player == AS_commander) then {[""mines"", 300] remoteExec [""buyGear"", 2];}"

	#define STR_EXP_AC "if (player == AS_commander) then {[""assessories"", 500] remoteExec [""buyGear"", 2];}"

	BTN_L(1,-1, "Charges", "Spend 800 Euros on explosives.", STR_EXP_CH);
	BTN_L(2,-1, "Weapons", "Spend 500 Euros on weapons and ammo.", STR_EXP_WP);

	BTN_R(1,-1, "Mines", "Spend 300 Euros on mines.", STR_EXP_MS);
	BTN_R(2,-1, "Accessories", "Spend 500 Euros on 4 weapon accessories.", STR_EXP_AC);
	};
};

class wpns
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(3,"Buy weapons","closeDialog 0; createDialog ""exp_menu"";");

    #define STR_EXP_ASS_S "if (player == AS_commander) then {[""ASRifles"", 500] remoteExec [""buyGear"", 2];}"
    #define STR_EXP_PIS_S "if (player == AS_commander) then {[""Pistols"", 500] remoteExec [""buyGear"", 2];}"
    #define STR_EXP_MGS_S "if (player == AS_commander) then {[""Machineguns"", 500] remoteExec [""buyGear"", 2];}"
    #define STR_EXP_SNP_S "if (player == AS_commander) then {[""Sniper Rifles"", 500] remoteExec [""buyGear"", 2];}"
    #define STR_EXP_LCH_S "if (player == AS_commander) then {[""Launchers"", 500] remoteExec [""buyGear"", 2];}"
    #define STR_EXP_GLA_S "if (player == AS_commander) then {[""GLaunchers"", 500] remoteExec [""buyGear"", 2];}"

    // these amounts are in buyGear.sqf
    BTN_L(1,-1, "10 Rifles", "", STR_EXP_ASS_S);
    BTN_L(2,-1, "5 G. Launchers", "", STR_EXP_GLA_S);
    BTN_L(3,-1, "5 Machineguns", "", STR_EXP_MGS_S);

    BTN_R(1,-1, "2 Launchers", "", STR_EXP_LCH_S);
    BTN_R(2,-1, "2 Snipers", "", STR_EXP_SNP_S);
    BTN_R(3,-1, "20 Pistols", "", STR_EXP_PIS_S);

	};
};


class HQ_fort_dialog // 440
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(3,"HQ Fortifications","closeDialog 0; createDialog ""radio_comm_commander"";");

	#define STR_HQ_CMO "closeDialog 0; [""net""] remoteExec [""HQ_adds"",2];"
	#define STR_HQ_LAN "closeDialog 0; [""lantern""] remoteExec [""HQ_adds"",2];"
	#define STR_HQ_SND "closeDialog 0; [""sandbag""] remoteExec [""HQ_adds"",2];"
	#define STR_HQ_PAD "closeDialog 0; [""pad"", position player] remoteExec [""HQ_adds"",2];"
	#define STR_HQ_DEL "closeDialog 0; [""delete""] remoteExec [""HQ_adds"",2];"

	BTN_L(1,-1, "Camo Net", "", STR_HQ_CMO);
	BTN_L(2,-1, "Lantern", "", STR_HQ_LAN);

	BTN_R(1,-1, "Sandbag", "", STR_HQ_SND);
	BTN_R(2,-1, "Vehicle Spawn Pad", "Create/Delete the vehicle spawn pad. Deploy at intended position.", STR_HQ_PAD);

	BTN_M(3, -1, "Delete All", "", STR_HQ_DEL);
	};
};

class game_options_commander
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Game Options",A_CLOSE);

BTN_L(1,-1, "Commander Menu", "Summary of your current situation", "closeDialog 0; nul = createDialog ""commander_menu"";");
BTN_L(2,-1, "Load/Save", "", "closeDialog 0; [] call AS_fncUI_LoadSaveMenu;");
BTN_L(3,-1, "Music ON/OFF", "", "closedialog 0; if (musicON) then {musicON = false; hint ""Music turned OFF"";} else {musicON = true; nul = execVM ""musica.sqf""; hint ""Music turned ON""};");

BTN_R(1,-1, "Performance Options", "Options to improve performance in case of low FPS.", "closeDialog 0; createDialog ""performance_menu"";");
BTN_R(2,-1, "Maintenance Options", "When something is broken, sometimes you can fix it here.", "closeDialog 0; nul = createDialog ""maintenance_menu"";");
BTN_R(3,-1, "Gameplay Options", "Options that affect gameplay.", "closeDialog 0; nul = createDialog ""gameplay_options"";");
	};
};

class performance_menu {
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Performance","closeDialog 0; createDialog ""game_options_commander"";");

#define _code "['spawnDistance', 100, 2500, 'Spawn distance set to %1 meters.'] call AS_UIfnc_change_var;"
BTN_L(1,-1, "+100 Spawn Dist.", "The distance from places that triggers its spawn", _code);
#define _code "['spawnDistance', -100, 1000, 'Spawn distance set to %1 meters.'] call AS_UIfnc_change_var;"
BTN_R(1,-1, "-100 Spawn Dist.", "The distance from places that triggers its spawn", _code);
#define _code "[""cleantime"", 60, nil, ""Cleanup time set to %1 minutes.""] call AS_UIfnc_change_var;"
BTN_L(2,-1, "+1m cleanup time", "Minutes for dead bodies/vehicles to disappear.", _code);
#define _code "[""cleantime"", -60, 2*60, ""Cleanup time set to %1 minutes.""] call AS_UIfnc_change_var;"
BTN_R(2,-1, "-1m cleanup time", "Minutes for dead bodies/vehicles to disappear.", _code);
#define _code "[""civPerc"", 0.01, 1, ""Civilian percentage set to %1 percent.""] call AS_UIfnc_change_var;"
BTN_L(3,-1, "+1% Civ Spawn.", "The percentage of the population that appears in the city.", _code);
#define _code "[""civPerc"", -0.01, 0.01, ""Civilian percentage set to %1 percent.""] call AS_UIfnc_change_var;"
BTN_R(3,-1, "-1% Civ Spawn.", "The percentage of the population that appears in the city.", _code);
#define _code "[[1],""fpsChange""] call BIS_fnc_MP;"
BTN_L(4,-1, "+1 FPS limit", "The limit on which the game does a dramatic reduction of stuff", _code);
#define _code "[[-1],""fpsChange""] call BIS_fnc_MP;"
BTN_R(4,-1, "-1 FPS limit", "The limit on which the game does a dramatic reduction of stuff", _code);
#define _code "[[], ""garbageCleaner.sqf""] remoteExec [""execVM"", 2];"
BTN_M(5,-1, "Clean garbage", "Remove dead bodies and others.", _code);
#undef _code
	};
};

class game_options_player
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Game Options",A_CLOSE);

BTN_L(1,-1, "Music ON/OFF", "", "closedialog 0; if (musicON) then {musicON = false; hint ""Music turned OFF"";} else {musicON = true; nul = execVM ""musica.sqf""; hint ""Music turned ON""};");

BTN_R(1,-1, "Reinit UI \ Radio", "", "closeDialog 0; [] execVM ""reinitY.sqf"";");
	};
};

class radio_comm_commander
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Battle Options",A_CLOSE);

BTN_L(1,-1, "Fast Travel", "", "[] call AS_UIfnc_fastTravel");
BTN_L(2,-1, "Disguise Yourself", "", "closeDialog 0; nul = [] spawn undercover");
BTN_L(3,-1, "Vehicle Manager", "", "closeDialog 0; nul = createDialog ""vehicle_manager"";");
BTN_L(4,-1, "AI Management", "", "if (player == leader group player) then {closeDialog 0; nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};");

BTN_R(1,-1, "NATO Options", "", "closeDialog 0; nul=CreateDialog ""NATO_Options"";");
BTN_R(2,-1, "Recruit Squad", "", "closeDialog 0; call AS_fncUI_RecruitSquadMenu;");
BTN_R(3,-1, "Building Options", "", "closeDialog 0; nul=CreateDialog ""build_menu"";");
BTN_R(4,-1, "Player and Money", "", "closeDialog 0; if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};");

BTN_M(5, -1, "Resign Commander", "", "closedialog 0; if (isMultiplayer) then {execVM ""orgPlayers\commResign.sqf""} else {hint ""This feature is MP Only""};");

	};
};

class radio_comm_player
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(3,"Battle Options",A_CLOSE);

BTN_L(1,-1, "Fast Travel", "", "call AS_UIfnc_fastTravel;");
BTN_L(2,-1, "Disguise Yourself", "", "closeDialog 0; nul = [] spawn undercover");
BTN_L(3,-1, "Resign Commander", "", "closedialog 0; if (isMultiplayer) then {execVM ""orgPlayers\commResign.sqf""} else {hint ""This feature is MP Only""};");

BTN_R(1,-1, "AI Management", "", "if (player == leader group player) then {closeDialog 0; nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};");
BTN_R(2,-1, "Player and Money", "", "closeDialog 0; if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};");
BTN_R(3,-1, "Vehicle Manager", "", "closeDialog 0; nul = createDialog ""vehicle_manager"";");

	};
};

class HQ_reset_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Do you want to reset HQ?",A_CLOSE);

BTN_L(1,-1, "Yes", "", "closeDialog 0; [] spawn buildHQ");
BTN_R(1,-1, "No", "", A_CLOSE);

	};
};

class maintenance_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(3,"Maintenance","closeDialog 0; createDialog ""game_options_commander"";");

	#define STR_MAINT_ARS "[] remoteExec [""fnc_MAINT_main"", 2];"
	#define STR_MAINT_PAN "[] remoteExec [""fnc_togglePetrosAnim"", 2];"
	#define STR_MAINT_PET "[true] remoteExec [""fnc_togglePetrosAnim"", 2]; [] remoteExec [""fnc_MAINT_resetPetros"", 2];"
	#define STR_MAINT_MOV "[] remoteExec [""fnc_MAINT_moveStatic"", 2];"

	BTN_L(1,-1, "Reset HQ", "Resets all HQ items to near Petros.", "closeDialog 0; createDialog ""HQ_reset_menu"";");
	BTN_L(2,-1, "Cleanup arsenal", "Remove items that do not exist or are unlocked.", STR_MAINT_ARS);
	BTN_L(3,-1, "Toggle Petros' animations", "Turn the idle animation of Petros on/off.", STR_MAINT_PAN);

	BTN_R(1,-1, "Reset Petros' position", "Terminate Petros' animation, move him next to the campfire at HQ.", STR_MAINT_PET);
	BTN_R(2,-1, "Move statics/HQ items", "Reset your ability to move statics and HQ assets.", STR_MAINT_MOV);
	BTN_R(3,-1, "Fix Y button", "Press in case the Y button stops working.", "closeDialog 0; [] execVM ""reinitY.sqf"";");
	};
};

class gameplay_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(4,"Gameplay options","closeDialog 0; createDialog ""game_options_commander"";");

    #define _code "[""minAISkill"", -0.1, 0, """"] call AS_UIfnc_change_var;"
	BTN_L(1,-1, "-0.1 min AI skill", "Decreases lowest AI skill (default=0.6).", _code);
    #define _code "[""minAISkill"", 0.1, 1, """"] call AS_UIfnc_change_var;"
	BTN_R(1,-1, "+0.1 min AI skill", "Increases lowest AI skill (default=0.6).", _code);

    #define _code "[""maxAISkill"", -0.1, 0, """"] call AS_UIfnc_change_var;"
	BTN_L(2,-1, "-0.1 max AI skill", "Decreases highest skill AI (default=0.9)", _code);
    #define _code "[""maxAISkill"", 0.1, 1, """"] call AS_UIfnc_change_var;"
	BTN_R(2,-1, "+0.1 max AI skill", "Increases highest skill AI (default=0.9)", _code);

    #define _code  "[""enableFTold"",""Extended Fast Travel system enabled"",""Fast Travel limited to camps and HQ""] call AS_UIfnc_toggle_bool;"
	BTN_L(3,-1, "Fast travel On/Off", "Toggle the old Fast Travel system on/off", _code);
    #define _code "if (server getVariable [""enableWpnProf"",false]) then {server setVariable [""enableWpnProf"",false,true]; [] remoteExec [""fnc_resetSkills"", [0,-2] select isDedicated,true]} else {server setVariable [""enableWpnProf"",true,true]}; hint format [""Current setting: %1"", [""off"", ""on""] select (server getVariable [""enableWpnProf"",false])];"
	BTN_R(3,-1, "Weapon Proficiencies", "Turn the extended weapon proficiencies system on/off (MP exclusive)", _code);
    #undef _code
	};
};


class tfar_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(1,"TFAR Menu",A_CLOSE);

	BTN_L(1,-1, "Save Radio Settings", "Save TFAR radio settings.", "closeDialog 0; [player] spawn fnc_saveTFARsettings");

	BTN_R(1,-1, "Load Radio Settings", "Load previously saved TFAR radio settings.", "closeDialog 0; [player] spawn fnc_loadTFARsettings");
	};
};

class RscTitles {

    class Default {
        idd = -1;
        fadein = 0;
        fadeout = 0;
        duration = 0;
    };
    class H8erHUD {
        idd = 745;
        movingEnable =  0;
        enableSimulation = 1;
        enableDisplay = 1;
        duration     =  10e10;
        fadein       =  0;
        fadeout      =  0;
        name = "H8erHUD";
        onLoad = "with uiNameSpace do { H8erHUD = _this select 0 }";
        class controls {
            class structuredText {
                access = 0;
                type = 13;
                idc = 1001;
                style = 0x00;
                lineSpacing = 1;
                x = 0.103165 * safezoneW + safezoneX;
                y = 0.007996 * safezoneH + safezoneY;//0.757996
                w = 0.778208 * safezoneW;
                h = 0.0660106 * safezoneH;
                size = 0.055;//0.020
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.34,0.33,0.33,0};//{1,1,1,1}
                text = "";
                font = "PuristaSemiBold";
                class Attributes {
                    font = "PuristaSemiBold";
                    color = "#C1C0BB";//"#FFFFFF";
                    align = "CENTER";
                    valign = "top";
                    shadow = true;
                    shadowColor = "#000000";
                    underline = false;
                    size = "4";//4
                };
            };
        };
    };
};
