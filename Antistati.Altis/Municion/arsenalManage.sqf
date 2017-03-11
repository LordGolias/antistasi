if (!isServer) exitWith {};
private ["_armas","_armasTrad","_addedWeapons","_lockedWeapon","_armasFinal","_precio","_arma","_armaTrad","_priceAdd","_updated","_magazines","_addedMagazines","_magazine","_magazinesFinal","_items","_addedItems","_item","_cuenta","_itemsFinal","_mochis","_mochisTrad","_addedMochis","_lockedMochi","_mochisFinal","_mochi","_mochiTrad","_armasConCosa","_armaConCosa"];

_updated = "";

_armas = weaponCargo caja;
_mochis = backpackCargo caja;
_magazines = magazineCargo caja;
_items = itemCargo caja;

_addedMagazines = [];

{
_magazine = _x;
if (not(_magazine in unlockedMagazines)) then
	{
	if ({_x == _magazine} count _magazines >= ["magazines"] call fn_getUnlockRequirement) then
		{
		_addedMagazines pushBackUnique _magazine;
		unlockedMagazines pushBackUnique _magazine;
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgMagazines" >> _magazine >> "displayName")]
		};
	};
} forEach allMagazines;

//-BEGIN-// 1.5.5
// check primary magazines to account for unlock issues caused by Petros' death
_primeMags = [];
{
	_primeMags pushBackUnique (getArray (configFile / "CfgWeapons" / _x / "magazines") select 0);
} forEach unlockedWeapons;

{
	_magazine = _x;
	if !(_magazine in unlockedMagazines) then {
		if ({_x == _magazine} count _magazines >= ["magazines"] call fn_getUnlockRequirement) then {
			_addedMagazines pushBackUnique _magazine;
			unlockedMagazines pushBackUnique _magazine;
			_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgMagazines" >> _magazine >> "displayName")]
		};
	};
} forEach _primeMags;
//-END-//

_armasTrad = [];

{
_armaTrad = [_x] call BIS_fnc_baseWeapon;
_armasTrad pushBack _armaTrad;
} forEach _armas;

_addedWeapons = [];
{
_lockedWeapon = _x;

if ({_x == _lockedWeapon} count _armasTrad >= ["weapons"] call fn_getUnlockRequirement) then
	{
	_desbloquear = false;
	//_magazines = getArray (configFile / "CfgWeapons" / _x / "magazines");
	_magazine = (getArray (configFile / "CfgWeapons" / _x / "magazines") select 0);
	if !(isNil "_magazine") then {
		if (_magazine in unlockedMagazines) then {
			_desbloquear = true;
		}
		else {
			if ({_x == _magazine} count _magazines >= ["magazines"] call fn_getUnlockRequirement) then {
				_desbloquear = true;
				_addedMagazines pushBackUnique _magazine;
				unlockedMagazines pushBackUnique _magazine;
				_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgMagazines" >> _magazine >> "displayName")]
			};
		};
		if (_desbloquear) then {
			_addedWeapons pushBackUnique _lockedWeapon;
			unlockedWeapons pushBackUnique _lockedWeapon;
			_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgWeapons" >> _lockedWeapon >> "displayName")];
		};
	};
};
} forEach lockedWeapons;

if (!("Rangefinder" in unlockedWeapons) || !(indRF in unlockedWeapons)) then
	{
	if ({(_x == "Rangefinder") or (_x == indRF)} count weaponCargo caja >= ["weapons"] call fn_getUnlockRequirement) then
		{
		_addedWeapons pushBack "Rangefinder";
		unlockedWeapons pushBack "Rangefinder";
		_addedWeapons pushBack indRF;
		unlockedWeapons pushBack indRF;
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgWeapons" >> "Rangefinder" >> "displayName")];
		};
	};

if (count _addedMagazines > 0) then
	{
		if ((atMine in _addedMagazines) || (apMine in _addedMagazines)) then {
			if (hayBE) then {["unl_wpn"] remoteExec ["fnc_BE_XP", 2]};
		};
	// XLA fixed arsenal
	if (hayXLA) then {
		[caja,_addedMagazines,true,false] call XLA_fnc_addVirtualMagazineCargo;
	} else {
		[caja,_addedMagazines,true,false] call BIS_fnc_addVirtualMagazineCargo;
	};
	publicVariable "unlockedMagazines";
	};

_magazinesFinal = [];

for "_i" from 0 to (count _magazines) - 1 do
	{
	_magazine = _magazines select _i;
	if (not(_magazine in unlockedMagazines)) then
		{
		_magazinesFinal pushBack _magazine;
		};
	};

if (count _addedWeapons > 0) then
	{
	lockedWeapons = lockedWeapons - _addedWeapons;
	if (hayBE) then {["unl_wpn", count _addedWeapons] remoteExec ["fnc_BE_XP", 2]};
	// XLA fixed arsenal
	if (hayXLA) then {
		[caja,_addedWeapons,true,false] call XLA_fnc_addVirtualWeaponCargo;
	} else {
		[caja,_addedWeapons,true,false] call BIS_fnc_addVirtualWeaponCargo;
	};
	publicVariable "unlockedWeapons";
	[_addedWeapons] spawn fnc_weaponsCheck;
	};

_armasFinal = [];
_armasConCosa = weaponsItems caja;

for "_i" from 0 to (count _armas) - 1 do
	{
	_arma = _armas select _i;
	_armaTrad = _armasTrad select _i;
	if (not(_armaTrad in unlockedWeapons)) then
		{
		_armasFinal pushBack _arma;
		}
	else
		{
		if (_arma != _armaTrad) then
			{
			_armaConCosa = _armasConCosa select _i;
			if ((_armaConCosa select 0) == _arma) then
				{
				{
				if (typeName _x != typeName []) then {_items pushBack _x};
				} forEach (_armaConCosa - [_arma]);
				};
			};
		};
	};

_mochisTrad = [];

{
_mochiTrad = _x call BIS_fnc_basicBackpack;
_mochisTrad pushBack _mochiTrad;
} forEach _mochis;

_addedMochis = [];
{
_lockedMochi = _x;
if ({_x == _lockedMochi} count _mochisTrad >= ["backpacks"] call fn_getUnlockRequirement) then
	{
	_addedMochis pushBackUnique _lockedMochi;
	_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgVehicles" >> _lockedMochi >> "displayName")];
	};
} forEach genBackpacks;

if (count _addedMochis > 0) then
	{
	genBackpacks = genBackpacks - _addedMochis;//verificar si tiene que ser pública
	// XLA fixed arsenal
	if (hayXLA) then {
		[caja,_addedMochis,true,false] call XLA_fnc_addVirtualBackpackCargo;
	} else {
		[caja,_addedMochis,true,false] call BIS_fnc_addVirtualBackpackCargo;
	};
	unlockedBackpacks = unlockedBackpacks + _addedMochis;
	//unlockedMochis = unlockedMochis + _addedMochis;
	publicVariable "unlockedBackpacks";
	};

_mochisFinal = [];

for "_i" from 0 to (count _mochis) - 1 do
	{
	_mochi = _mochis select _i;
	_mochiTrad = _mochisTrad select _i;
	if (not(_mochiTrad in unlockedBackpacks)) then
		{
		_mochisFinal pushBack _mochi;
		};
	};


_addedItems = [];

{
_item = _x;
if (not(_item in unlockedItems)) then {
	_itemReq = ["items"] call fn_getUnlockRequirement;
	if !(_item in genItems) then {_itemReq = _itemReq + 10};
	if ((_item in genVests) || (_item in genOptics)) then {_itemReq = ["vests"] call fn_getUnlockRequirement};
	if ({_x == _item} count _items >= _itemReq) then {
		_addedItems pushBackUnique _item;
		unlockedItems pushBackUnique _item;
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgWeapons" >> _item >> "displayName")];
		if (_item in genOptics) then {unlockedOptics pushBackUnique _item; publicVariable "unlockedOptics"};
		if (_item in genVests) then {
			if (hayBE) then {["unl_wpn"] remoteExec ["fnc_BE_XP", 2]};
		};
	};
};
} forEach allItems + ["bipod_01_F_snd","bipod_01_F_blk","bipod_01_F_mtp","bipod_02_F_blk","bipod_02_F_tan","bipod_02_F_hex","bipod_03_F_blk","B_UavTerminal"] + bluItems - ["NVGoggles","Laserdesignator"];

if (!("NVGoggles" in unlockedItems) || !(indNVG in unlockedItems)) then
	{
	if ({(_x == "NVGoggles") or (_x == "NVGoggles_OPFOR") or (_x == "NVGoggles_INDEP") or (_x == indNVG)} count weaponCargo caja >= ["items"] call fn_getUnlockRequirement) then
		{
		_addedItems = _addedItems + ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];
		unlockedItems = unlockedItems + ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP",indNVG];
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgWeapons" >> "NVGoggles" >> "displayName")];
		if (hayBE) then {["unl_wpn"] remoteExec ["fnc_BE_XP", 2]};
		};
	};

if (not("Laserdesignator" in unlockedItems)) then
	{
	if ({(_x == "Laserdesignator") or (_x == "Laserdesignator_02") or (_x == "Laserdesignator_03")} count weaponCargo caja >= ["items"] call fn_getUnlockRequirement) then
		{
		_addedItems pushBack "Laserdesignator";
		unlockedItems pushBack "Laserdesignator";
		_updated = format ["%1%2<br/>",_updated,getText (configFile >> "CfgWeapons" >> "Laserdesignator" >> "displayName")];
		};
	};

if ((hayACE) && ("ItemGPS" in unlockedItems)) then {
	unlockedItems pushBackUnique "ACE_DAGR";
};

if (count _addedItems >0) then
	{
	// XLA fixed arsenal
	if (hayXLA) then {
		[caja,_addedItems,true,false] call XLA_fnc_addVirtualItemCargo;
	} else {
		[caja,_addedItems,true,false] call BIS_fnc_addVirtualItemCargo;
	};
	//unlockedItems = unlockedItems + _addedItems;
	publicVariable "unlockedItems";
	};

_itemsFinal = [];

for "_i" from 0 to (count _items) - 1 do
	{
	_item = _items select _i;
	if (not(_item in unlockedItems)) then
		{
		if ((_item == "NVGoggles_OPFOR") or (_item == "NVGoggles_INDEP")) then
			{
			if (not("NVGoggles" in unlockedItems)) then
				{
				_itemsFinal pushBack _item;
				};
			}
		else
			{
			if ((_item == "Laserdesignator_02") or (_item == "Laserdesignator_03")) then
				{
				if (not("Laserdesignator" in unlockedItems)) then
					{
					_itemsFinal pushBack _item;
					};
				}
			else
				{
				// experimental: if item not unlocked and not TFAR radio, add to ammo box
				if !(toLower _item find "tf_anprc152" >= 0) then {_itemsFinal pushBack _item};
				};
			};
		};
	};

//[0,_precio] remoteExec ["resourcesFIA",2];

if (count _armas != count _armasFinal) then
	{
	clearWeaponCargoGlobal caja;
	{caja addWeaponCargoGlobal [_x,1]} forEach _armasFinal;
	unlockedRifles = unlockedweapons -  hguns -  mlaunchers - rlaunchers - ["Binocular","Laserdesignator","Rangefinder"] - srifles - mguns; publicVariable "unlockedRifles";
	};
if (count _mochis != count _mochisFinal) then
	{
	clearBackpackCargoGlobal caja;
	{caja addBackpackCargoGlobal [_x,1]} forEach _mochisFinal;
	};
if (count _magazines != count _magazinesFinal) then
	{
	clearMagazineCargoGlobal caja;
	{caja addMagazineCargoGlobal [_x,1]} forEach _magazinesFinal;
	};
if (count _items != count _itemsFinal) then
	{
	clearItemCargoGlobal caja;
	{caja addItemCargoGlobal [_x,1]} forEach _itemsFinal;
	};

publicVariable "unlockedWeapons";
publicVariable "unlockedRifles";
publicVariable "unlockedItems";
publicVariable "unlockedOptics";
publicVariable "unlockedBackpacks";
publicVariable "unlockedMagazines";

_updated