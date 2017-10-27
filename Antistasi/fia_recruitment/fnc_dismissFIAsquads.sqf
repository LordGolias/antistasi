private ["_groups","_hr","_resourcesFIA","_wp","_grupo","_veh","_salir"];

_groups = _this select 0;
_hr = 0;
_resourcesFIA = 0;
_salir = false;
{
if ((groupID _x == "MineF") or (groupID _x == "Watch") or (isPlayer(leader _x))) then {_salir = true};
} forEach _groups;

if (_salir) exitWith {hint "You cannot dismiss player led, Watchpost, Roadblocks or Minefield building squads"};

{
	if (leader _x call AS_fnc_getSide == "NATO") exitwith {_salir = true};
} forEach _groups;

if (_salir) exitWith {hint format ["You cannot dismiss %1 groups", (["NATO", "name"] call AS_fnc_getEntity)]};

_pos = getMarkerPos "FIA_HQ";

{
AS_commander sideChat format ["Petros, I'm sending %1 back to base", _x];
AS_commander hcRemoveGroup _x;
_wp = _x addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
sleep 3} forEach _groups;

sleep 100;

{
	_grupo = _x;
	_vs = [];
	{
		if (alive _x) then {
			_hr = _hr + 1;
			_resourcesFIA = _resourcesFIA + ((_x call AS_fnc_getFIAUnitType) call AS_fnc_getCost);
			if (!isNull (assignedVehicle _x)) then {
				_veh = assignedVehicle _x;
				if !((typeOf _veh) in _vs) then {
					_vs pushBack (typeOf _veh);
					if ((typeOf _veh) in (["FIA", "vehicles"] call AS_fnc_getEntity)) then {
						// Recover the full price of the vehicle
						_resourcesFIA = _resourcesFIA + ([typeOf _veh] call AS_fnc_getFIAvehiclePrice);
						if (count attachedObjects _veh > 0) then {
							_subVeh = (attachedObjects _veh) select 0;
							_resourcesFIA = _resourcesFIA + ([(typeOf _subVeh)] call AS_fnc_getFIAvehiclePrice);
							deleteVehicle _subVeh;
						};
						deleteVehicle _veh;
					};
				};
			};
		};
		deleteVehicle _x;
	} forEach units _grupo;
	deleteGroup _grupo;
	} forEach _groups;
[_hr,_resourcesFIA] remoteExec ["AS_fnc_changeFIAmoney",2];
