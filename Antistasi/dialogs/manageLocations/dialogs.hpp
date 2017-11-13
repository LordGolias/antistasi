class AS_manageLocations
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(4,"Manage locations", "closeDialog 0;");

// build new
LIST_L(0,1,0,3,"");
BTN_L(4,-1,"Choose position",
	"Select the position to build the selected location",
	"'add' spawn AS_fnc_UI_manageLocations_selectOnMap;");

// remove existing
BTN_R(1,-1,"Abandon","Select a location on the map to abandon","'abandon' spawn AS_fnc_UI_manageLocations_selectOnMap;");
BTN_R(2,-1,"Rename camp","Select a camp on the map to rename","'rename' spawn AS_fnc_UI_manageLocations_selectOnMap;");
	};
};

class AS_manageLocations_rename
{
    idd=1602;
	movingenable=false;

    class controls
    {
AS_DIALOG(1,"Rename camp", "closeDialog 0;");
WRITE(1,1,1,"camp name");
BTN_R(1,-1,"Save", "closeDialog 0;");
	};
};
