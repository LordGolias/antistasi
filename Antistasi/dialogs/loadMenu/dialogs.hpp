class AS_loadMenu
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Load game", "[] spawn AS_fnc_UI_loadMenu_close;");

LIST_L(0,1,0,4,"");
BTN_L(5,-1,"Delete selected", "Delete the selected saved game", "[] spawn AS_fnc_UI_loadMenu_delete;");

BTN_R(5,-1,"Load game", "Load the selected saved game", "[] spawn AS_fnc_UI_loadMenu_load;");
BTN_R(1,-1,"Load from clipboard", "Load a saved game from the clipboard (copy it from a file)", "[] spawn AS_fnc_UI_loadMenu_loadClipboard;");
	};
};
