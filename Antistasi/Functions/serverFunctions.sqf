#include "../macros.hpp"

AS_fnc_rebuildLocation = {
	params ["_location"];
	private _type = _location call AS_fnc_location_position;
	[0,10,_location call AS_fnc_location_position] call citySupportChange;
	[5,0] call AS_fnc_changeForeignSupport;
	AS_Pset("destroyedLocations", AS_P("destroyedLocations") - [_location]);
	if (_type == "powerplant") then {[_location] call powerReorg};
	[0,-5000] call resourcesFIA;
};
