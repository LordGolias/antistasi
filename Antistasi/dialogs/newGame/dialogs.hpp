class AS_newGameMenu {
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(8,"Configure new game", "[] spawn AS_fnc_UI_newGame_close;");

BTN_L(1,-1,"Rebel against the West", "", "[""east""] call AS_fnc_UI_newGame_update;");
BTN_R(1,-1,"Rebel against the East", "", "[""west""] call AS_fnc_UI_newGame_update;");

// Guerilla
READ(0,2,-1,1,"Your faction");
LIST_L(0,3,0,2,"");

// Pro-guerrilla
READ(1,2,-1,1,"Your supporter");
LIST_L(1,3,1,2,"");

// State
READ(0,5,-1,1,"The state");
LIST_L(0,6,2,2,"");

// Pro-state
READ(1,5,-1,1,"The state's supporter");
LIST_L(1,6,3,2,"");

BTN_M(8,-1,"Start game", "", "[] spawn AS_fnc_UI_newGame_start;");
	};
};
