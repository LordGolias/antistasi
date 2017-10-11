#include "../macros.hpp"
AS_SERVER_ONLY("AS_fnc_setCommander");

params ["_newCommander"];

private _hadCommander = not isNull AS_commander;
private _hcGroups = allGroups select {_x getVariable ["isHCgroup", false]};
if _hadCommander then {
    {
        AS_commander hcRemoveGroup _x;
    } forEach _hcGroups;

    AS_commander synchronizeObjectsRemove [HC_comandante];
    HC_comandante synchronizeObjectsRemove [AS_commander];
};

AS_commander = _newCommander;
publicVariable "AS_commander";
[group AS_commander, AS_commander] remoteExec ["selectLeader", AS_commander];

AS_commander synchronizeObjectsAdd [HC_comandante];
HC_comandante synchronizeObjectsAdd [AS_commander];

{
    AS_commander hcSetGroup [_x];
} forEach _hcGroups;
