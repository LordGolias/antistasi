class AS_startMenu {
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Start Menu", "closeDialog 0;");

BTN_L(1,-1,"New game", "You will choose a side and an initial location", "closeDialog 0; [] spawn AS_fnc_UI_newGame_menu");
BTN_R(1,-1,"Load game", "You will choose a saved game to start from", "hint 'Not implemented yet'");
	};
};
