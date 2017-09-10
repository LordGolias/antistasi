#include "../macros.hpp"

AS_fncUI_openHQmenu = {
	disableSerialization;
	private ["_display","_childControl","_texto"];
	createDialog "HQmenu";

	_display = findDisplay 100;

	if (str (_display) != "no display") then {
		_childControl = _display displayCtrl 109;
		if (BE_currentStage == 3) then {
			_texto = "No further training available.";
		} else {
			_texto = format ["Training Cost: %1 €", call fnc_BE_calcPrice];
		};
		_childControl  ctrlSetTooltip _texto;
	};
};

AS_fncUI_HQmove = {
	if (player != AS_commander) exitWith {
		hint "Only the commander can do this";
	};

	if ((count weaponCargo caja > 0) or
	    (count magazineCargo caja > 0) or
		(count itemCargo caja > 0) or
		(count backpackCargo caja > 0)) exitWith {
			hint "The Ammobox must be empty to move the HQ";
	};

	[] remoteExec ["AS_fnc_HQmove", 2];
	closeDialog 0;
};

AS_fncUI_takeFIAmoney = {
	if (player != AS_commander) exitWith {
		hint "Only the commander can do this";
	};
	if not isMultiplayer exitWith {
		hint "In single player your money is FIA money";
	};
	if (AS_P("resourcesFIA") < 100) exitWith {
		hint "FIA does not have money"
	};

	[100] call resourcesPlayer;
	[0,-100] remoteExec ["resourcesFIA", 2];
	[-2, AS_commander] remoteExec ["AS_fnc_changePlayerScore", 2];

	hint "You grabbed 100 € from the FIA Money Pool.\n\nThis will affect your status among FIA forces";
	closeDialog 0;
};

AS_fncUI_rebuildAssets = {
	if (AS_P("resourcesFIA") < 5000) exitWith {
	    hint "You do not have enough money to rebuild any Asset. You need 5.000 €"
	};

	// todo: add help helper markers
	openMap true;
	posicionTel = [];
	hint "Select the location you want to rebuild.";

	onMapSingleClick "posicionTel = _pos;";

	waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
	onMapSingleClick "";
	private _posicionTel = +posicionTel;
	posicionTel = nil;

	if (count _posicionTel == 0) exitWith {hint "Canceled."};

	private _location = _posicionTel call AS_fnc_location_nearest;
	private _position = _location call AS_fnc_location_position;
	private _type = _location call AS_fnc_location_position;
	private _side = _location call AS_fnc_location_side;

	if (_position distance _posicionTel > 50) exitWith {hint "You must click near a map marker"};
	if not (_type in ["powerplant","factory","resource"]) exitWith {hint "You can only rebuild power plants, factories and resource locations."};
	if not (_side == "FIA") exitWith {hint "You can only rebuild locations you control"};
	if not (_location in AS_P("destroyedLocations")) exitWith {hint "Chosen location is not destroyed"};

	[_location] remoteExec ["AS_fnc_rebuildLocation", 2];
	hint format ["%1 rebuilt", [_location] call localizar];
};

AS_fncUI_trainFIA = {
	if (BE_currentStage == 3) exitWith {
		hint "No further training available.";
	};
	private _price = call fnc_BE_calcPrice;
	if (AS_P("resourcesFIA") > _price) then {
		[] remoteExec ["fnc_BE_upgrade", 2];
		hint "FIA upgraded";
	} else {
		hint "Not enough money.";
	};
};
