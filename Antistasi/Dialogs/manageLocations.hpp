class AS_ManageLocations
{
	idd=1602;
	movingenable=false;

	class controls
	{
AS_DIALOG(4,"Manage locations", "closeDialog 0;");

// build new
LIST_L(0,1,0,3,"");
BTN_L(4,-1,"Choose position",
	"Click to select the position to build the selected location",
	"'add' spawn AS_fncUI_manageLocationsMapSelection;");

// remove existing
BTN_R(1,-1,"Abandon","Select a location on the map to abandon","'abandon' spawn AS_fncUI_manageLocationsMapSelection;");
BTN_R(2,-1,"Rename camp","Select a camp on the map to rename","'rename' spawn AS_fncUI_manageLocationsMapSelection;");
	};
};

class AS_ManageLocations_rename
{
    idd = 1602;
	movingenable=false;

    class controls
    {
AS_DIALOG(1,"Rename camp", "closeDialog 0;");
WRITE(1,1,1,"camp name");
BTN_R(1,-1,"Save", "closeDialog 0;");
	};
};
