private ["_unit","_grupos","_oldUnit","_oldProviders","_HQ","_providerModule","_used"];
_unit = _this select 0;
_grupos = hcAllGroups AS_commander;
_oldUnit = AS_commander;

if (!isNil "_grupos") then {
  {
  	_oldUnit hcRemoveGroup _x;
  } forEach _grupos;
};

_oldUnit synchronizeObjectsRemove [HC_comandante];
//apoyo synchronizeObjectsRemove [_oldUnit];
HC_comandante synchronizeObjectsRemove [_oldUnit];
AS_commander = _unit;
publicVariable "AS_commander";
[group _unit, _unit] remoteExec ["selectLeader",_unit];
AS_commander synchronizeObjectsAdd [HC_comandante];
HC_comandante synchronizeObjectsAdd [AS_commander];
//apoyo synchronizeObjectsAdd [AS_commander];
if (!isNil "_grupos") then {
  	{_unit hcSetGroup [_x]} forEach _grupos;
}
else {
	{
		if (_x getVariable ["isHCgroup",false]) then {
			_unit hcSetGroup [_x];
		};
	} forEach allGroups;
};

if (isNull _oldUnit) then {
	[_oldUnit,[group _oldUnit]] remoteExec ["hcSetGroup",_oldUnit];
};