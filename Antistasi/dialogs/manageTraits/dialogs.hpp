class AS_manageTraits
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Add expertise", "closeDialog 0;");

LIST_L(0,1,0,4,"");
READ(1,1,1,4,"Trait description");

BTN_R(5,4,"Train yourself", "Add the selected trait to yourself", "[] call AS_fnc_UI_manageTraits_select;");
	};
};
