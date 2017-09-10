class HQmenu
{
	idd=100;
	movingenable=false;

	class controls
	{
AS_DIALOG(4, "FIA HQ", A_CLOSE);

BTN_L(1,-1, "Grab 100 € from Pool", "Gain personal money and lose prestige", "call AS_fncUI_takeFIAmoney;");
BTN_L(2,-1, "Manage Garrisons", "Recruit/dismiss units to garrison locations", "closeDialog 0; call AS_fncUI_RecruitGarrisonMenu;");
BTN_L(3,-1, "Move HQ to another position", "You must empty your ammo box to a truck", "call AS_fncUI_HQmove");

BTN_R(1,-1, "Ingame Member's List", "", "if (isMultiplayer) then {nul = [] execVM ""OrgPlayers\membersList.sqf""} else {hint ""This function is MP only""};");
BTN_R(2,109, "Train FIA", "Increase HR capacity and FIA skill", "call AS_fncUI_trainFIA");
BTN_R(3,-1, "Rebuild Assets", "Rebuild a destroyed location (5.000 €)", "closeDialog 0; [] spawn AS_fncUI_rebuildAssets;");

BTN_M(4, -1, "Garage Access", "", "closeDialog 0; [false] spawn garage;");
	};
};
