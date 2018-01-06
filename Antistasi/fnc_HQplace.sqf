#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQplace.sqf");
params ["_position", "_isNewGame"];

"delete" call AS_fnc_HQaddObject;

["FIA_HQ", "position", _position] call AS_location_fnc_set;
call AS_fnc_initPetros;
call AS_fnc_HQdeploy;

if _isNewGame then {
	// move all players to the HQ.
	{_x call AS_fnc_initPlayerPosition} forEach (allPlayers - (entities "HeadlessClient_F"));
} else {
	if isMultiplayer then {
		{_x hideObjectGlobal false} forEach AS_permanent_HQplacements;
	} else {
		{_x hideObject false} forEach AS_permanent_HQplacements;
	};
};
