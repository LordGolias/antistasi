class HQmenu
{
	idd=100;
	movingenable=false;

	class controls
	{
AS_DIALOG(4, "FIA HQ", A_CLOSE);

BTN_L(1,-1, "Grab 100 € from Pool", "", "call AS_fncUI_takeFIAmoney;");
BTN_L(2,-1, "Manage Garrisons", "", "closeDialog 0; call AS_fncUI_RecruitGarrisonMenu;");
BTN_L(3,-1, "Move HQ to another position", "", "call AS_fncUI_HQmove");

BTN_R(1,-1, "Ingame Member's List", "", "if (isMultiplayer) then {nul = [] execVM ""OrgPlayers\membersList.sqf""} else {hint ""This function is MP only""};");
BTN_R(2,109, "Train FIA", "", "[] remoteExec [""fnc_BE_buyUpgrade"", 2]");
BTN_R(3,-1, "Rebuild Assets", "Cost: 5.000 €", "closeDialog 0; nul = [] execVM ""rebuildAssets.sqf"";");

BTN_M(4, -1, "Garage Access", "", "closeDialog 0; nul = [false] spawn garage;");
	};
};
