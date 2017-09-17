class AS_manageGarrisons
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Manage garrison", "closeDialog 0; call AS_fnc_UI_manageHQ_menu");

LIST_L(0,1,1,4,"");

BTN_L(5,-1,"Recruit selected", "Recruit the unit selected above", "call AS_fnc_UI_manageGarrisons_recruit;");
BTN_R(1,2,"Select location", "Select the location", "[] spawn AS_fnc_UI_manageGarrisons_selectOnMap;");
LIST_L(1,2,3,3,"");
BTN_R(5,-1,"Dismiss selected", "Dismiss the unit selected above", "call AS_fnc_UI_manageGarrisons_dismiss;");
	};
};
