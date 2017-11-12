class AS_ManageMissions
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(8,"Manage missions", "closeDialog 0;");

LIST_L(0,1,0,7,"call AS_fnc_UI_manageMissions_updatePanel;");
READ(1,1,1,7, "Mission information");

BTN_R(8,-1,"Start selected", "", "call AS_fnc_UI_manageMissions_activate;");
	};
};
