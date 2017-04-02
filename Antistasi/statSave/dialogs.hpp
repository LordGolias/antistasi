class AS_SaveLoadMenu
{
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Save and load", "[] spawn AS_fncUI_closeSaveLoadMenu;");

LIST_L(0,1,0,4,"[] call AS_fncUI_selectSave;");

WRITE(1,1,2,"");
// save below is spawned because saving a game is an async operation.
BTN_R(2,3,"Save game", "Save the game with the name given above", "[] spawn AS_fncUI_saveGame;");
BTN_R(4,5,"Load game", "Load the selected game", "[] call AS_fncUI_loadGame;");
BTN_R(5,4,"Delete selected", "Delete the selected save on the left", "[] call AS_fncUI_deleteGame;");
	};
};
