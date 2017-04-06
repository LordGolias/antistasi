class AS_RecruitSquad
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Recruit squads", "closeDialog 0;");

LIST_L(0,1,0,4,"");

BTN_R(5,4,"Recruit selected", "Recruit the squad", "[] call AS_fncUI_recruitSquad;");
	};
};
