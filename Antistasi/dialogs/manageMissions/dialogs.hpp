class AS_ManageMissions
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Manage missions", "closeDialog 0;");

LIST_L(0,1,0,4,"call AS_fnc_UI_manageMissions_updatePanel;");
READ(1,1,1,4, "Mission information");

BTN_R(5,-1,"Start selected", "", "call AS_fnc_UI_manageMissions_activate;");
	};
};
