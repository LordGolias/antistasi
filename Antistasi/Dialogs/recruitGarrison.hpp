class AS_RecruitGarrison
{
	idd=242;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Recruit garrison", "closeDialog 0; call AS_fncUI_openHQmenu");

LIST_L(0,1,1,4,"");

BTN_L(5,-1,"Recruit selected", "Recruit the unit selected above", "call AS_fncUI_recruitGarrison;");
BTN_R(1,2,"Select location", "Select the location", "spawn AS_fncUI_initMapSelection;");
LIST_L(1,2,3,3,"");
BTN_R(5,-1,"Dismiss selected", "Dismiss the unit selected above", "call AS_fncUI_dismissGarrison;");
	};
};
