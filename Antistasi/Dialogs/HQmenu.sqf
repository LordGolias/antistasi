#include "../macros.hpp"

AS_fncUI_openHQmenu = {
	disableSerialization;
	private ["_display","_childControl","_texto"];
	createDialog "HQmenu";

	_display = findDisplay 100;

	[] remoteExec ["fnc_BE_calcPrice", 2];

	if (str (_display) != "no display") then
	{
		_childControl = _display displayCtrl 109;
		_texto = format ["Current Stage: %2 \nNext Stage Training Cost: %1 €", BE_currentPrice, BE_currentStage];
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
