private ["_veh"];

_veh = _this select 0;
_tipo = "SmokeShellPurple";

if !(alive _veh) exitWith {};

if (side _veh == side_blue) then {
	_tipo = "SmokeShellBlue";
};

if (_veh isKindOf "Air") then
	{
	private ["_pos","_humo"];
	for "_i" from 0 to 8 do
		{
		_pos = position _veh getPos [10,_i*40];
		_humo = _tipo createVehicle [_pos select 0, _pos select 1,getPos _veh select 2];
		};
	}
else
	{
	_veh fire "SmokeLauncher";
	};