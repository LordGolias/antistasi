#include "../macros.hpp"
_veh = _this select 0;

_inside = _veh getVariable "inDespawner";
if (!isNil "_inside") exitWith {};

_veh setVariable ["inDespawner",true,true];

if ((typeOf _veh in arrayCivVeh) and ({_x getVariable ["BLUFORSpawn",false]} count crew _veh > 0) and (_veh distance getMarkerPos "respawn_west" > 50)) then
	{
	_pos = position _veh;
	[0,-1,_pos] remoteExec ["citySupportChange",2];
	_ciudad = [ciudades, _pos] call BIS_fnc_nearestPosition;
	
	_data = [_ciudad, ["prestigeOPFOR"]] call AS_fnc_getCityAttrs;
	_prestigeOPFOR = _data select 0;
	sleep 5;
	if (random 100 < _prestigeOPFOR) then
		{
		{_amigo = _x;
		if ((captive _amigo) and (isPlayer _amigo)) then
			{
			[_amigo,false] remoteExec ["setCaptive",_amigo];
			};
		{
		if ((side _x == side_green) and (_x distance _pos < AS_P("spawnDistance"))) then {_x reveal [_amigo,4]};
		} forEach allUnits;
		} forEach crew _veh;
		};
	};
while {alive _veh} do
	{
	if ((not([AS_P("spawnDistance"),1,_veh,"BLUFORSpawn"] call distanceUnits)) and (not([AS_P("spawnDistance"),1,_veh,"OPFORSpawn"] call distanceUnits)) and (not(_veh in staticsToSave)) and (_veh distance getMarkerPos "respawn_west" > 100)) then
		{
		//hint format ["%1 se lo ha cargado el despawner",_veh];
		if (_veh in reportedVehs) then {reportedVehs = reportedVehs - [_veh]; publicVariable "reportedVehs"};
		deleteVehicle _veh
		};
	sleep 60;
	};