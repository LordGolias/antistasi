class AS_newGameMenu {
	idd=1601;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Configure new game", "closeDialog 0;");

BTN_L(0,-1,"Play against NATO/USA", "", "[] call AS_fnc_UI_newGame_red;");
BTN_R(0,-1,"Play against CSAT/RUS", "", "[] call AS_fnc_UI_newGame_blue;");

// Guerilla
LIST_L(0,1,1,3,"[] call AS_fnc_UI_newGame_select;");

// Pro-guerrilla
LIST_L(1,1,2,3,"[] call AS_fnc_UI_newGame_select;");

// State
LIST_L(0,1,3,3,"[] call AS_fnc_UI_newGame_select;");

// Pro-state
LIST_L(1,1,4,3,"[] call AS_fnc_UI_newGame_select;");
	};

BTN_M(0,-1,"Start game", "", "[] spawn AS_fnc_UI_newGame_start;");
};
