class AS_startMenu {
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(1,"Start Menu", "hint 'You cannot close this dialog. Press escape twice to open Arma game menu;'");

BTN_L(1,-1,"New game", "You will choose a faction and an initial location", "closeDialog 0; [] spawn AS_fnc_UI_newGame_menu");
BTN_R(1,-1,"Load game", "You will choose a saved game to start from", "closeDialog 0; [] spawn AS_fnc_UI_loadMenu_menu;");
	};
};
