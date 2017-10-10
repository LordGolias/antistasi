class AS_saveMenu
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Save game", "closeDialog 0;");

LIST_L(0,1,0,4,"[] call AS_fnc_UI_saveMenu_select;");
BTN_L(5,-1,"Delete selected", "Delete the selected saved game", "[] spawn AS_fnc_UI_loadMenu_delete;");

WRITE(1,1,2,"");
BTN_R(2,-1,"Save game", "Save the game with the name given above (and to the clipboard in SP)", "[] spawn AS_fnc_UI_saveMenu_save;");
	};
};
