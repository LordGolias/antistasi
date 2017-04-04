if (player != player getVariable ["owner",player]) exitWith {hint "You cannot buy vehicles while you are controlling AI"};

_chequeo = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance player < 500) and (not(captive _x))) then {_chequeo = true};
} forEach allUnits;

if (_chequeo) exitWith {Hint "You cannot buy vehicles with enemies nearby"};

private ["_tipoVeh","_coste","_resourcesFIA","_marcador","_pos","_veh"];

_tipoVeh = _this select 0;
_milveh = vfs select [3,10];
_milstatics = vfs select [7,4];

_coste = [_tipoVeh] call vehiclePrice;

if (!isMultiPlayer) then {_resourcesFIA = AS_persistent getVariable "resourcesFIA"} else
	{
	if (player != AS_commander) then
		{
		_resourcesFIA = player getVariable "dinero";
		}
	else
		{
		if ((_tipoVeh in _milveh) or (_tipoVeh == civHeli)) then {_resourcesFIA = AS_persistent getVariable "resourcesFIA"} else {_resourcesFIA = player getVariable "dinero"};
		};
	};

if (_resourcesFIA < _coste) exitWith {hint format ["You do not have enough money for this vehicle: %1 € required",_coste]};
_pos = position player findEmptyPosition [10,50,_tipoVeh];
if (count _pos == 0) exitWith {hint "Not enough space to place this type of vehicle"};
_veh = _tipoVeh createVehicle _pos;
if (!isMultiplayer) then
	{
	[0,(-1* _coste)] spawn resourcesFIA;
	}
else
	{
	if (player != AS_commander) then
		{
		[-1* _coste] call resourcesPlayer;
		_veh setVariable ["duenyo",getPlayerUID player,true];
		}
	else
		{
		if ((_tipoVeh in _milveh) or (_tipoVeh == civHeli)) then
			{
			[0,(-1* _coste)] remoteExecCall ["resourcesFIA",2]
			}
		else
			{
			[-1* _coste] call resourcesPlayer;
			_veh setVariable ["duenyo",getPlayerUID player,true];
			};
		};
	};
[_veh] spawn VEHinit;
if (_tipoVeh in _milstatics) then {staticsToSave pushBackUnique _veh; publicVariable "staticsToSave"; _veh addAction [localize "STR_act_moveAsset", "moveObject.sqf","static",0,false,true,"","(_this == AS_commander)"];};
hint "Vehicle Purchased";
player reveal _veh;
petros directSay "SentGenBaseUnlockVehicle";