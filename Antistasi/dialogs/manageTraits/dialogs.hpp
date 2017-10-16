class AS_manageTraits
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Add expertise", "closeDialog 0;");

READ(0,1,-1,1,"Possible expertises");
LIST_L(0,2,0,3,"[0] spawn AS_fnc_UI_manageTraits_select;");
READ(1,1,-1,1,"Your expertises");
LIST_L(1,2,10,3,"[10] spawn AS_fnc_UI_manageTraits_select;");
READ(0,5,1,1,"Trait description");

BTN_R(5,4,"Train yourself", "Add the selected trait to yourself", "[] spawn AS_fnc_UI_manageTraits_train;");
	};
};
