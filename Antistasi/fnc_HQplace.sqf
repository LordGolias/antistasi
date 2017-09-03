#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQplace.sqf");
params ["_position"];

"delete" call AS_fnc_HQaddObject;

["FIA_HQ", "position", _position] call AS_fnc_location_set;
call AS_fnc_initPetros;
call AS_fnc_HQdeploy;

if isNil "placementDone" then {
	// move all players to the HQ.
	if isMultiplayer then {
		{_x setPos getPos petros} forEach playableUnits;
	} else {
		AS_commander setPos (getPos petros);
	};

    placementDone = true;
	publicVariable "placementDone";
} else {
	AS_commander allowDamage true;
	if isMultiplayer then {
		{_x hideObjectGlobal false} forEach AS_permanent_HQplacements;
	} else {
		{_x hideObject false} forEach AS_permanent_HQplacements;
	};
};
