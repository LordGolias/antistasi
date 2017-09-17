#include "../macros.hpp"
AS_SERVER_ONLY("AS_fnc_setCommander");

params ["_unit"];

private _hcGroups = hcAllGroups AS_commander;
private _oldUnit = AS_commander;

if (!isNil "_hcGroups") then {
    {
        _oldUnit hcRemoveGroup _x;
    } forEach _hcGroups;
};

_oldUnit synchronizeObjectsRemove [HC_comandante];
HC_comandante synchronizeObjectsRemove [_oldUnit];

AS_commander = _unit;
publicVariable "AS_commander";
[group _unit, _unit] remoteExec ["selectLeader", _unit];

AS_commander synchronizeObjectsAdd [HC_comandante];
HC_comandante synchronizeObjectsAdd [AS_commander];
if (!isNil "_hcGroups") then {
    {
        _unit hcSetGroup [_x];
    } forEach _hcGroups;
} else {
    {
		if (_x getVariable ["isHCgroup", false]) then {
			_unit hcSetGroup [_x];
		};
	} forEach allGroups;
};

if (isNull _oldUnit) then {
	[_oldUnit,[group _oldUnit]] remoteExec ["hcSetGroup",_oldUnit];
};
