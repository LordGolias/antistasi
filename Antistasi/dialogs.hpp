#include "macros.hpp"
#include "statSave\dialogs.hpp"
#include "dialogs\recruitUnit.hpp"
#include "dialogs\recruitSquad.hpp"
#include "dialogs\recruitGarrison.hpp"
#include "dialogs\manageLocations.hpp"
#include "dialogs\manageMissions.hpp"
#include "dialogs\buyVehicle.hpp"
#include "dialogs\HQmenu.hpp"

class build_menu
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(3,"Building Options", "closeDialog 0; if (player == AS_commander) then {createDialog ""radio_comm_commander""} else {createDialog ""radio_comm_player""};");

BTN_M(1,-1,"Manage Locations", "", "closeDialog 0; [] spawn AS_fncUI_ManageLocationsMenu;");
BTN_M(2,-1,"Build Minefield", "", "closeDialog 0; createDialog ""AS_createMinefield"";");
BTN_M(3, -1, "HQ Fortifications", "", "closeDialog 0; nul= createDialog ""HQ_fort_dialog"";");
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

BTN_R(1,-1, "Donate 100 € to player in front of you", "", "true call AS_fncUI_donateMoney;");
BTN_R(2,-1, "Donate 100 € to FIA", "", "call AS_fncUI_donateMoney;");

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

BTN_L(1,-1, "Control selected AI", "", "[] spawn AS_fncUI_controlUnit;");
BTN_L(2,-1, "Auto Heal", "", "[] execVM ""AI\autoHealFnc.sqf""}");

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
	#define STR_COM_FIA "closeDialog 0; if (player == AS_commander) then {[""status""] remoteExecCall [""fnc_infoScreen"", 2]};"

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

	BTN_L(1,-1, "YES", "FIA starts with some NATO weapons", STR_BST_YES);
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

BTN_L(1,-1, "Fast Travel", "", "closeDialog 0; [] spawn AS_fnc_fastTravel;");
BTN_L(2,-1, "Disguise Yourself", "", "closeDialog 0; nul = [] spawn undercover");
BTN_L(3,-1, "Vehicle Manager", "", "closeDialog 0; nul = createDialog ""vehicle_manager"";");
BTN_L(4,-1, "AI Management", "", "if (player == leader group player) then {closeDialog 0; nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};");

BTN_R(1,-1, "NATO Options", "", "closeDialog 0; nul=CreateDialog ""NATO_Options"";");
BTN_R(2,-1, "Recruit Squad", "", "closeDialog 0; [] spawn AS_fncUI_RecruitSquadMenu;");
BTN_R(3,-1, "Building Options", "", "closeDialog 0; nul=CreateDialog ""build_menu"";");
BTN_R(4,-1, "Player and Money", "", "closeDialog 0; if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};");

BTN_M(5, -1, "Resign Commander", "", "closeDialog 0; call AS_fncUI_toggleElegibility;");

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
BTN_L(2,-1, "Disguise Yourself", "", "closeDialog 0; nul = [] spawn undercover");
BTN_L(3,-1, "Toggle your eligiblily for commanding", "", "closeDialog 0; call AS_fncUI_toggleElegibility;");

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
    AS_DIALOG(3,"Maintenance","closeDialog 0; createDialog ""game_options_commander"";");

	#define STR_MAINT_ARS "[] remoteExec [""fnc_MAINT_main"", 2];"
	#define STR_MAINT_PET "[] remoteExec [""fnc_MAINT_resetPetros"", 2];"
	#define STR_MAINT_MOV "[] remoteExec [""fnc_MAINT_moveStatic"", 2];"

	BTN_L(1,-1, "Reset HQ", "Resets all HQ items to near Petros.", "closeDialog 0; createDialog ""HQ_reset_menu"";");
	BTN_L(2,-1, "Cleanup arsenal", "Remove items that do not exist or are unlocked.", STR_MAINT_ARS);
	BTN_R(1,-1, "Reset Petros' position", "Move Petros next to the campfire at HQ.", STR_MAINT_PET);
	BTN_R(2,-1, "Move statics/HQ items", "Reset your ability to move statics and HQ assets.", STR_MAINT_MOV);
	BTN_M(3,-1, "Fix Y button", "Press in case the Y button stops working.", "closeDialog 0; [] execVM ""reinitY.sqf"";");
	};
};

class gameplay_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
    AS_DIALOG(3,"Gameplay options","closeDialog 0; createDialog ""game_options_commander"";");

    #define _code "[""minAISkill"", -0.1, 0, """"] call AS_UIfnc_change_var;"
	BTN_L(1,-1, "-0.1 min AI skill", "Decreases lowest AI skill (default=0.6).", _code);
    #define _code "[""minAISkill"", 0.1, 1, """"] call AS_UIfnc_change_var;"
	BTN_R(1,-1, "+0.1 min AI skill", "Increases lowest AI skill (default=0.6).", _code);

    #define _code "[""maxAISkill"", -0.1, 0, """"] call AS_UIfnc_change_var;"
	BTN_L(2,-1, "-0.1 max AI skill", "Decreases highest skill AI (default=0.9)", _code);
    #define _code "[""maxAISkill"", 0.1, 1, """"] call AS_UIfnc_change_var;"
	BTN_R(2,-1, "+0.1 max AI skill", "Increases highest skill AI (default=0.9)", _code);

    #define _code "if (server getVariable [""enableWpnProf"",false]) then {server setVariable [""enableWpnProf"",false,true]; [] remoteExec [""fnc_resetSkills"", [0,-2] select isDedicated,true]} else {server setVariable [""enableWpnProf"",true,true]}; hint format [""Current setting: %1"", [""off"", ""on""] select (server getVariable [""enableWpnProf"",false])];"
	BTN_M(3,-1, "Weapon Proficiencies", "Turn the extended weapon proficiencies system on/off (MP exclusive)", _code);
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
