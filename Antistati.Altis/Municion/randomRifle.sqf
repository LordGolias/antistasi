private ["_unit","_compatibles","_posibles","_rifle","_helmet","_uniform","_vest"];

_unit = _this select 0;

_rifle = _this select 1;
_helmet = _this select 2;
_uniform = _this select 3;
_vest = _this select 4;
_rifleFinal = "";

_skillFIA = server getVariable "skillFIA";

if (_vest) then
	{
	if (random 25 < _skillFIA) then
		{
		removeVest _unit;
		if (hayRHS) then {
			_unit addVest "rhs_6b23_6sh116_flora";
			_unit addItemToVest "FirstAidKit";
			}
		else {
			_unit addVest "V_PlateCarrierIAGL_oli";
			};
		};
	};
if (_rifle) then
	{
	_mag = currentMagazine _unit;
	_unit removeMagazines _mag;
	_unit removeWeaponGlobal (primaryWeapon _unit);
	_rifleFinal = unlockedRifles call BIS_fnc_selectRandom;
	if (_rifleFinal in genGL) then {
		if !(hayRHS) then {_unit addMagazine ["1Rnd_HE_Grenade_shell", 4];}
		else {_unit addMagazine ["rhs_VOG25", 4];};
	};
	[_unit, _rifleFinal, 5, 0] call BIS_fnc_addWeapon;
	if (count unlockedOptics > 0) then
			{
			_compatibles = [primaryWeapon _unit] call BIS_fnc_compatibleItems;
			_posibles = [];
			{
			if (_x in _compatibles) then {_posibles pushBack _x};
			} forEach unlockedOptics;
			_unit addPrimaryWeaponItem (_posibles call BIS_fnc_selectRandom);
			};
	};
if (_helmet) then
	{
	if (random 20 < _skillFIA) then
		{
		_unit addHeadgear (genHelmets call BIS_fnc_selectRandom)
		}
	else
		{
		if (_uniform) then {
			// BE module
			if (hayBE) then {
				_result = ["outfit"] call fnc_BE_getCurrentValue;
				if (random 100 > _result) then {
					_unit forceAddUniform (civUniforms call BIS_fnc_selectRandom);
					_unit addItemToUniform "FirstAidKit";
					if !(hayRHS) then {
						_unit addMagazine ["HandGrenade", 1];
						_unit addMagazine ["SmokeShell", 1];
					} else {
						_unit addMagazine "rhs_mag_rdg2_white";
						_unit addMagazine "rhs_mag_rgd5";
					};
				};
			}
			// BE module
			else {
				if (random 10 > _skillFIA) then {
					_unit forceAddUniform (civUniforms call BIS_fnc_selectRandom);
					_unit addItemToUniform "FirstAidKit";
					if !(hayRHS) then {
						_unit addMagazine ["HandGrenade", 1];
						_unit addMagazine ["SmokeShell", 1];
					} else {
						_unit addMagazine "rhs_mag_rdg2_white";
						_unit addMagazine "rhs_mag_rgd5";
					};
				};
			};
		};
	};
};

if (hayTFAR) then {
	_unit addItem "tf_anprc152";
	_unit assignItem "tf_anprc152";
};