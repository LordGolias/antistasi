class AS_SaveLoadMenu
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Save and load", "[] spawn AS_fncUI_closeSaveLoadMenu;");

LIST_L(0,1,0,4,"[] call AS_fncUI_selectSave;");
BTN_L(5,-1,"Delete selected", "Delete the selected saved game", "[] call AS_fncUI_deleteGame;");

WRITE(1,1,2,"");
BTN_R(2,-1,"Save game", "Save the game with the name given above (and to the clipboard)", "[] spawn AS_fncUI_saveGame;");
BTN_R(4,-1,"Load game", "Load the selected saved game", "[] call AS_fncUI_loadFromSavedGame;");
BTN_R(5,-1,"Load from clipboard", "Load a saved game from the clipboard (copy it from a file)", "[] call AS_fncUI_loadFromClipboard;");
	};
};
