_perro = _this select 0;
_grupo = group _perro;

_spotted = objNull;

_perro setVariable ["BIS_fnc_animalBehaviour_disable", true];
_perro disableAI "FSM";
_perro setBehaviour "CARELESS";
_perro setRank "PRIVATE";

while {alive _perro} do
	{
	if ((_perro == leader _grupo) and (!captive _perro)) then {_perro setCaptive true};
	if (isNull _spotted) then
		{
		sleep 10;
		_perro moveTo getPosATL leader _grupo;
		{
		_spotted = _x;
		if (captive _spotted) then
			{
			[_spotted,false] remoteExec ["setCaptive",_spotted];
			};
		} forEach ([50, position _perro, "BLUFORSpawn"] call AS_fnc_unitsAtDistance);

		if ((random 10 < 1) and (isNull _spotted)) then
			{
			playSound3D [missionPath + (ladridos call BIS_fnc_selectRandom),_perro, false, getPosASL _perro, 1, 1, 100];
			};
		if (_perro distance (leader _grupo) > 50) then {_perro setPos position (leader _grupo)};
		}
	else
		{
		_perro doWatch _spotted;
		(leader _grupo) reveal [_spotted,4];
		playSound3D [missionPath + (ladridos select (floor random 5)),_perro, false, getPosASL _perro, 1, 1, 100];
		_perro moveTo getPosATL _spotted;
		if (_spotted distance _perro > 100) then {_spotted = objNull};
		sleep 3;
		};
	};
