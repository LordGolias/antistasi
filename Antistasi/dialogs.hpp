#include "database\dialogs.hpp"
#include "dialogs\recruitUnit\dialogs.hpp"
#include "dialogs\recruitSquad\dialogs.hpp"
#include "dialogs\manageGarrisons\dialogs.hpp"
#include "dialogs\manageMissions\dialogs.hpp"
#include "dialogs\manageLocations\dialogs.hpp"
#include "dialogs\manageHQ\dialogs.hpp"
#include "dialogs\manageNATO\dialogs.hpp"
#include "dialogs\buyVehicle\dialogs.hpp"
#include "dialogs\newGame\dialogs.hpp"
#include "dialogs\startMenu\dialogs.hpp"

class build_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(3,"Building Options", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_M(1,-1,"Manage Locations", "", "closeDialog 0; [] spawn AS_fnc_UI_manageLocations_menu;");
BTN_M(2,-1,"Build Minefield", "", "closeDialog 0; createDialog ""AS_createMinefield"";");
BTN_M(3, -1, "HQ Fortifications", "", "closeDialog 0; nul= createDialog ""HQ_fort_dialog"";");
	};
};

class squad_manager
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"HC Squad Options", "closeDialog 0; createDialog ""radio_comm_commander"";");

BTN_L(1,-1, "Squad Add Vehicle", "", "closeDialog 0; [] spawn AS_fnc_addSquadVehicle;");
BTN_L(2,-1, "Squad Vehicle Stats", "Hints the status of the vehicle of the selected HC squad", "call AS_fnc_UI_squadVehicleStatus;");

BTN_R(1,-1, "Mount / Dismount", "Makes an HC squad board/dismount its vehicle", "call AS_fnc_UI_squadVehicleDismount");
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
AS_DIALOG(1,"Donate money", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1, "Donate 100 € to player in front of you", "", "true call AS_fnc_UI_donateMoney;");
BTN_R(1,-1, "Donate 100 € to FIA", "", "false call AS_fnc_UI_donateMoney;");

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

BTN_M(2, -1, "Unlock Vehicle", "", "closeDialog 0; if !(isMultiplayer) then {hint ""It's unlocked already.""} else {if (player != AS_commander) then {nul = [false] call AS_fnc_unlockVehicle} else {nul = [true] call AS_fnc_unlockVehicle};};");

	};
};

class garage_sell
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Sell or Garage Vehicle", "closeDialog 0; createDialog ""vehicle_manager"";");

BTN_L(1,-1, "Garage Vehicle", "", "closeDialog 0; if (player != AS_commander) then {nul = [false] call AS_fnc_putVehicleInGarage} else {if (isMultiplayer) then {createDialog ""garage_check""} else {nul = [true] call AS_fnc_putVehicleInGarage}};");
BTN_R(1,-1, "Sell Vehicle", "", "closeDialog 0; if (player == AS_commander) then {nul = [] call AS_fnc_sellVehicle} else {hint ""Only the Commander can sell vehicles""};");

	};
};
class garage_check
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Personal or FIA Garage?", "closeDialog 0; createDialog ""garage_sell"";");

BTN_L(1,-1, "Personal Garage", "", "closeDialog 0; nul = [false] call AS_fnc_putVehicleInGarage;");
BTN_R(1,-1, "FIA Garage", "", "closeDialog 0; nul = [true] call AS_fnc_putVehicleInGarage;");

	};
};
class carpet_bombing
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Carpet Bombing Strike","closeDialog 0; nul = createDialog ""NATO_Missions"";");

BTN_L(1,-1, "HE Bombs", "Cost: 10 points", "closeDialog 0; ""HE"" call AS_fnc_UI_natoAirstrike;");
BTN_R(1,-1, "Carpet Bombing", "Cost: 10 points", "closeDialog 0; ""CARPET"" call AS_fnc_UI_natoAirstrike;");

BTN_M(2, -1, "NAPALM Bomb", "Cost: 10 points", "closeDialog 0; ""NAPALM"" call AS_fnc_UI_natoAirstrike;");

	};
};

class AI_management
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"AI Management","closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_L(1,-1, "Control selected AI", "", "[] spawn AS_fnc_UI_controlUnit;");
BTN_R(1,-1, "Auto Rearm", "", "closeDialog 0; if (count groupselectedUnits player == 0) then {nul = (units group player) execVM ""AI\rearmCall.sqf""} else {nul = (groupselectedUnits player) execVM ""AI\rearmCall.sqf""};");
BTN_M(2,-1, "Dismiss Units/Squads", "Dismisses selected units or HC squads", "closeDialog 0; [] spawn AS_fnc_UI_dismissSelected;");

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

BTN_L(1,-1, "HE", "", "closeDialog 0; if (hayRHS) then {tipoMuni = ""RHS_mag_m1_he_12"";} else {tipoMuni = ""32Rnd_155mm_Mo_shells"";}");
BTN_R(1,-1, "Laser Guided", "", "closeDialog 0; tipoMuni = ""2Rnd_155mm_Mo_LG"";");

BTN_M(2, -1, "Smoke", "", "closeDialog 0; if (hayRHS) then {tipoMuni = ""rhs_mag_m60a2_smoke_4"";} else {tipoMuni = ""6Rnd_155mm_Mo_smoke"";}");

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

class AS_createMinefield
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(2,"Create minefield","closeDialog 0; createDialog ""build_menu"";");

BTN_L(1,-1, "AP Mines", "", "closeDialog 0; [apMine] spawn AS_fnc_deployFIAminefield");
BTN_R(1,-1, "AT Mines", "", "closeDialog 0; [atMine] spawn AS_fnc_deployFIAminefield");

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
	#define STR_COM_FIA "closeDialog 0; if (player == AS_commander) then {[""status""] remoteExec [""AS_fnc_showInGarageInfo"", 2]};"

	BTN_L(1,-1, "Current Restrictions", "Display current AXP restrictions", STR_COM_RES);
	BTN_R(1,-1, "Current Progress", "Display current AXP progress", STR_COM_PRO);

	BTN_M(2, -1, "FIA Status", "Display FIA details", STR_COM_FIA);
	};
};

class set_difficulty_menu // 390
{
	idd=-1;
	movingenable=false;

	class controls
	{
	AS_BOX(1);
	AS_FRAME(1, "Is the start too hard for you?");

	#define STR_BST_YES "closeDialog 0; [] remoteExec [""AS_fnc_setEasy"", 2];"
	#define STR_BST_NO "closeDialog 0;"

	BTN_L(1,-1, "YES", "FIA starts with some foreign weapons", STR_BST_YES);
	BTN_R(1,-1, "NO", "FIA starts only with basic gear", STR_BST_NO);
	};
};

class exp_menu // 430
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Buy Ordnance",A_CLOSE);

	#define STR_EXP_CH "if (player == AS_commander) then {[""explosives"", 800] remoteExec [""AS_fnc_buyGear"", 2];}"

	#define STR_EXP_WP "closeDialog 0; createDialog ""wpns"";"

	#define STR_EXP_MS "if (player == AS_commander) then {[""mines"", 300] remoteExec [""AS_fnc_buyGear"", 2];}"

	#define STR_EXP_AC "if (player == AS_commander) then {[""assessories"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"

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

    #define STR_EXP_ASS_S "if (player == AS_commander) then {[""ASRifles"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"
    #define STR_EXP_PIS_S "if (player == AS_commander) then {[""Pistols"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"
    #define STR_EXP_MGS_S "if (player == AS_commander) then {[""Machineguns"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"
    #define STR_EXP_SNP_S "if (player == AS_commander) then {[""Sniper Rifles"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"
    #define STR_EXP_LCH_S "if (player == AS_commander) then {[""Launchers"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"
    #define STR_EXP_GLA_S "if (player == AS_commander) then {[""GLaunchers"", 500] remoteExec [""AS_fnc_buyGear"", 2];}"

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

	#define STR_HQ_CMO "closeDialog 0; [""net""] remoteExec [""AS_fnc_HQaddObject"",2];"
	#define STR_HQ_LAN "closeDialog 0; [""lantern""] remoteExec [""AS_fnc_HQaddObject"",2];"
	#define STR_HQ_SND "closeDialog 0; [""sandbag""] remoteExec [""AS_fnc_HQaddObject"",2];"
	#define STR_HQ_PAD "closeDialog 0; [""pad"", position player] remoteExec [""AS_fnc_HQaddObject"",2];"
	#define STR_HQ_DEL "closeDialog 0; [""delete""] remoteExec [""AS_fnc_HQaddObject"",2];"

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
BTN_L(2,-1, "Load/Save", "", "closeDialog 0; [] call AS_database_fnc_UI_loadSaveMenu;");
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
AS_DIALOG(4,"Performance","closeDialog 0; createDialog ""game_options_commander"";");

#define _code "['spawnDistance', 100, 2500, 'Spawn distance set to %1 meters.'] call AS_fnc_UI_changePersistent;"
BTN_L(1,-1, "+100 Spawn Dist.", "The distance from places that triggers its spawn", _code);
#define _code "['spawnDistance', -100, 1000, 'Spawn distance set to %1 meters.'] call AS_fnc_UI_changePersistent;"
BTN_R(1,-1, "-100 Spawn Dist.", "The distance from places that triggers its spawn", _code);
#define _code "[""cleantime"", 60, nil, ""Cleanup time set to %1 minutes.""] call AS_fnc_UI_changePersistent;"
BTN_L(2,-1, "+1m cleanup time", "Minutes for dead bodies/vehicles to disappear.", _code);
#define _code "[""cleantime"", -60, 2*60, ""Cleanup time set to %1 minutes.""] call AS_fnc_UI_changePersistent;"
BTN_R(2,-1, "-1m cleanup time", "Minutes for dead bodies/vehicles to disappear.", _code);
#define _code "[""civPerc"", 0.01, 1, ""Civilian percentage set to %1 percent.""] call AS_fnc_UI_changePersistent;"
BTN_L(3,-1, "+1% Civ Spawn.", "The percentage of the population that appears in the city.", _code);
#define _code "[""civPerc"", -0.01, 0.01, ""Civilian percentage set to %1 percent.""] call AS_fnc_UI_changePersistent;"
BTN_R(3,-1, "-1% Civ Spawn.", "The percentage of the population that appears in the city.", _code);
BTN_M(4,-1, "Clean garbage", "Remove dead bodies and dropped items.", "[] remoteExec [""AS_fnc_cleanGarbage"", 2];");
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

BTN_L(1,-1, "Fast Travel", "", "closeDialog 0; [] spawn AS_fnc_fastTravel;");
BTN_L(2,-1, "Go undercover", "While undercover, the enemies won't attack you.", "closeDialog 0; [] spawn AS_fnc_activateUndercover;");
BTN_L(3,-1, "Vehicle Manager", "", "closeDialog 0; nul = createDialog ""vehicle_manager"";");
BTN_L(4,-1, "AI Management", "", "if (player == leader group player) then {closeDialog 0; nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};");

BTN_R(1,-1, "Foreign Support", "", "closeDialog 0; [] spawn AS_fnc_UI_manageNATO_menu;");
BTN_R(2,-1, "Recruit Squad", "", "closeDialog 0; [] spawn AS_fnc_UI_recruitSquad_menu;");
BTN_R(3,-1, "Building Options", "", "closeDialog 0; nul=CreateDialog ""build_menu"";");
BTN_R(4,-1, "Player and Money", "", "closeDialog 0; if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};");

BTN_M(5, -1, "Resign Commander", "", "closeDialog 0; call AS_fnc_UI_toggleElegibility;");

	};
};

class radio_comm_player
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(3,"Battle Options",A_CLOSE);

BTN_L(1,-1, "Fast Travel", "", "closeDialog 0; [] spawn AS_fnc_fastTravel;");
BTN_L(2,-1, "Go undercover", "While undercover, the enemies won't attack you.", "closeDialog 0; [] spawn AS_fnc_activateUndercover;");
BTN_L(3,-1, "Toggle your eligiblily for commanding", "", "closeDialog 0; call AS_fnc_UI_toggleElegibility;");

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

BTN_L(1,-1, "Yes", "", "closeDialog 0; [] remoteExec [""AS_fnc_HQdeploy"", 2]");
BTN_R(1,-1, "No", "", A_CLOSE);

	};
};

class maintenance_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Maintenance","closeDialog 0; createDialog ""game_options_commander"";");

	#define STR_MAINT_PET "[] remoteExec [""fnc_MAINT_resetPetros"", 2];"

	BTN_L(1,-1, "Reset HQ", "Resets all HQ items to near Petros.", "closeDialog 0; createDialog ""HQ_reset_menu"";");
	BTN_L(2,-1, "Cleanup arsenal", "Remove items that do not exist or are unlocked.", "[] remoteExec [""AS_fnc_refreshArsenal"", 2]");
	BTN_R(1,-1, "Reset Petros' position", "Move Petros next to the campfire at HQ.", "[] remoteExec [""AS_fnc_resetPetrosPosition"", 2]");
	BTN_R(2,-1, "Fix Y button", "Press in case the Y button stops working.", "closeDialog 0; [] execVM ""reinitY.sqf"";");
	};
};

class gameplay_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(2,"Gameplay options","closeDialog 0; createDialog ""game_options_commander"";");

    #define _code "[""minAISkill"", -0.1, 0, """"] call AS_fnc_UI_changePersistent;"
	BTN_L(1,-1, "-0.1 min AI skill", "Decreases lowest AI skill (default=0.6).", _code);
    #define _code "[""minAISkill"", 0.1, 1, """"] call AS_fnc_UI_changePersistent;"
	BTN_R(1,-1, "+0.1 min AI skill", "Increases lowest AI skill (default=0.6).", _code);

    #define _code "[""maxAISkill"", -0.1, 0, """"] call AS_fnc_UI_changePersistent;"
	BTN_L(2,-1, "-0.1 max AI skill", "Decreases highest skill AI (default=0.9)", _code);
    #define _code "[""maxAISkill"", 0.1, 1, """"] call AS_fnc_UI_changePersistent;"
	BTN_R(2,-1, "+0.1 max AI skill", "Increases highest skill AI (default=0.9)", _code);
	};
};


class tfar_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(1,"TFAR Menu",A_CLOSE);

	BTN_L(1,-1, "Save Radio Settings", "Save TFAR radio settings.", "closeDialog 0; [player] spawn AS_TFAR_fnc_saveSettings");

	BTN_R(1,-1, "Load Radio Settings", "Load previously saved TFAR radio settings.", "closeDialog 0; [player] spawn AS_TFAR_fnc_loadSettings");
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
