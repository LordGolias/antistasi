class AS_buyVehicle {
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"Buy vehicles", "closeDialog 0;");

LIST_L(0,1,0,4,"call AS_fnc_UI_buyVehicle_updateVehicleData;");
READ(1,1,1,4,"Vehicle information");

BTN_R(5,-1,"Buy selected", "", "[] call AS_fnc_UI_buyVehicle_buy;");
	};
};
