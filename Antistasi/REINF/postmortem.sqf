#include "../macros.hpp"
private ["_killed", "_group"];
_killed = _this select 0;

[_killed] call AS_DEBUG_initDead;

sleep AS_P("cleantime");
_group = group _killed;
deleteVehicle _killed;

if (!isNull _group) then {
	if ({alive _x} count units _group == 0) then {
		_group remoteExec ["deleteGroup", groupOwner _group];
	};
}
else {
	if (_killed in staticsToSave) then {staticsToSave = staticsToSave - [_killed]; publicVariable "staticsToSave";};
};
