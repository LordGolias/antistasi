private ["_unit","_muzzle","_enemy"];

_unit = _this select 0;
_ayudado = _this select 1;

private _returnMuzzle = {
	params ["_unit"];

	private _muzzles = [];
	private _magazines = magazines _unit;

	if ("SmokeShell" in _magazines) then {_muzzles pushBack "SmokeShellMuzzle"};
	if ("SmokeShellRed" in _magazines) then {_muzzles pushBack "SmokeShellRedMuzzle"};
	if ("SmokeShellGreen" in _magazines) then {_muzzles pushBack "SmokeShellGreenMuzzle"};
	if ("SmokeShellBlue" in _magazines) then {_muzzles pushBack "SmokeShellBlueMuzzle"};
	if ("SmokeShellYellow" in _magazines) then {_muzzles pushBack "SmokeShellYellowMuzzle"};
	if ("SmokeShellPurple" in _magazines) then {_muzzles pushBack "SmokeShellPurpleMuzzle"};
	if ("SmokeShellOrange" in _magazines) then {_muzzles pushBack "SmokeShellOrangeMuzzle"};
	if ("rhs_mag_rdg2_white" in _magazines) then {_muzzles pushBack "Rhs_Throw_Smoke"};

	private _muzzle = "";
	if (count _muzzles > 0) then {_muzzle = _muzzles call BIS_fnc_selectRandom};

	_muzzle
};

if (time < _unit getVariable ["smokeUsed",time - 1]) exitWith {};

if (vehicle _unit != _unit) exitWith {};

_unit setVariable ["smokeUsed",time + 60];

_muzzle = [_unit] call _returnMuzzle;
if (_muzzle !="") then
	{
	_enemy = _ayudado findNearestEnemy _unit;
	if (!isNull _enemy) then
		{
		if (([objNull, "VIEW"] checkVisibility [eyePos _ayudado, eyePos _enemy]) > 0) then
			{
			_unit stop true;
			_unit doWatch _enemy;
			_unit lookAt _enemy;
			_unit doTarget _enemy;
			if (_unit != _ayudado) then {sleep 5} else {sleep 1};
			_unit forceWeaponFire [_muzzle,_muzzle];
			_unit stop false;
			_unit doFollow (leader _unit);
			};
		};
	};
