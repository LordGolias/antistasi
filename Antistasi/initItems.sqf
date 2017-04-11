/*
    Script that initializes global variables related with items:

    AS_allItems
    AS_allNVGs
    AS_allBinoculars
    AS_allOptics, AS_allOpticsAttrs
    AS_allUAVs
    AS_allMounts
    AS_allBipods
    AS_allMuzzles
    AS_allVests, AS_allVestsAttrs
    AS_allHelmets, AS_allHelmetsAttrs
    AS_allBackpacks, AS_allBackpacksAttrs
    AS_allAssessories
    AS_allOtherAssessories
    AS_allThrowGrenades
    AS_allMagazines
    AS_allWeapons, AS_allWeaponsAttrs
*/
_allPrimaryWeapons = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 1 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allHandGuns = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 2 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allLaunchers = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 4 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allAccessories = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 131072 } } )
" configClasses ( configFile >> "cfgWeapons" );

_allBackpacks = "(
getNumber ( _x >> ""scope"" ) == 2
&& {
getNumber ( _x >> ""isbackpack"" ) isEqualTo 1
&& {
getNumber ( _x >> ""maximumLoad"" ) != 0
}})" configClasses ( configFile >> "cfgVehicles");

_itemFilter = "
    ( getNumber ( _x >> ""scope"" ) isEqualTo 2
    &&
    { getText ( _x >> ""simulation"" ) isEqualTo ""Weapon""
    &&
    { getNumber ( _x >> ""type"" ) isEqualTo 131072
    &&
    { getNumber ( _x >> ""ItemInfo"" >> ""type"" ) isEqualTo %1
    } } })
";

_allItems = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096
})" configClasses ( configFile >> "cfgWeapons" );

_allNVG = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""NVGoggles""
}})" configClasses ( configFile >> "cfgWeapons" );

_allBinoculars = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""Binocular""
}})" configClasses ( configFile >> "cfgWeapons" );

_allLDesignators = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getNumber ( _x >> ""type"" ) isEqualTo 4096 && {
getText ( _x >> ""simulation"" ) isEqualTo ""weapon""
}})" configClasses ( configFile >> "cfgWeapons" );

_allMagazines = "(
getNumber ( _x >> ""scope"" ) isEqualTo 2 && {
getText ( _x >> ""simulation"" ) isEqualTo ""ProxyMagazines""
})" configClasses ( configFile >> "CfgMagazines" );


AS_allItems = [];
{
	AS_allItems pushBack (configName _x);
} forEach _allItems;

AS_allNVGs = [];
{
	AS_allNVGs pushBack (configName _x);
} forEach _allNVG;

AS_allBinoculars = [];
{
	AS_allBinoculars pushBack (configName _x);
} forEach _allBinoculars + _allLDesignators;

AS_allOptics = [];
AS_allOpticsAttrs = [];
_allOptics = (format [_itemFilter, 201]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allOptics pushBack _name;
    _zoomMin = 10000;
    _zoomMax = 0;
    {
        _o_zoomMin = getNumber (_x >> "opticsZoomMin");
        _o_zoomMax = getNumber (_x >> "opticsZoomMax");
        if (_zoomMin > _o_zoomMin) then {_zoomMin = _o_zoomMin;};
        if (_zoomMax < _o_zoomMax) then {_zoomMax = _o_zoomMax;};
    } forEach ("true" configClasses (_x >> "ItemInfo" >> "OpticsModes"));

	AS_allOpticsAttrs pushBack [_zoomMin, _zoomMax];
} forEach _allOptics;

AS_allUAVs = [];
{
	AS_allUAVs pushBack (configName _x);
} forEach ((format [_itemFilter, 621]) configClasses ( configFile >> "cfgWeapons" ));

AS_allMounts = [];
{
	AS_allMounts pushBack (configName _x);
} forEach ((format [_itemFilter, 301]) configClasses ( configFile >> "cfgWeapons" ));

AS_allBipods = [];
_allBipods = (format [_itemFilter, 302]) configClasses ( configFile >> "cfgWeapons" );
{
	AS_allBipods pushBack (configName _x);
} forEach _allBipods;

AS_allMuzzles = [];
_allMuzles = (format [_itemFilter, 101]) configClasses ( configFile >> "cfgWeapons" );
{
	AS_allMuzzles pushBack (configName _x);
} forEach _allMuzles;

// all vests. Used to identify vests that can be used by FIA soldiers.
AS_allVests = [];
AS_allVestsAttrs = [];
_allVests = (format [_itemFilter, 701]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allVests pushBack _name;
	_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "mass"));
	_armor = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor"));
	AS_allVestsAttrs pushBack [_weight, _armor];
} forEach _allVests;

// all helmets. Used to compute the best helmet to be used by FIA soldiers.
AS_allHelmets = [];
AS_allHelmetsAttrs = [];
_allHelmets = (format [_itemFilter, 605]) configClasses ( configFile >> "cfgWeapons" );
{
	_name = configName _x;
	AS_allHelmets pushBack _name;
	_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "mass"));
	_armor = (getNumber (configFile >> "CfgWeapons" >> _name >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor"));
	AS_allHelmetsAttrs pushBack [_weight, _armor];
} forEach _allHelmets;

// all backpacks. Used to compute the best backpack to be used by FIA soldiers.
AS_allBackpacks = [];
AS_allBackpacksAttrs = [];
{
	_name = configName _x;
	AS_allBackpacks pushBack _name;
	_weight = (getNumber (configFile >> "CfgVehicles" >> _name >> "mass"));
	_load = (getNumber (configFile >> "CfgVehicles" >> _name >> "maximumLoad"));
	AS_allBackpacksAttrs pushBack [_weight, _load];
} forEach _allBackpacks;

// All relevant assessories
AS_allAssessories = AS_allBipods + AS_allOptics + AS_allMuzzles + AS_allMounts + AS_allUAVs + AS_allNVGs + AS_allBinoculars + (AS_allItems - AS_allNVGs - AS_allBinoculars);

private _allUniforms = [];
{
	_allUniforms pushBack (configName _x);
} forEach ((format [_itemFilter, 801]) configClasses ( configFile >> "cfgWeapons" ));

// Assessories that are not reachable in the game.
AS_allOtherAssessories = [];
{
    AS_allOtherAssessories pushBack (configName _x);
} forEach _allAccessories;
AS_allOtherAssessories = AS_allOtherAssessories - (AS_allAssessories + _allUniforms + AS_allVests + AS_allHelmets + AS_allBackpacks);

AS_allThrowGrenades = [];
{
    AS_allThrowGrenades append getArray(configFile >> "CfgWeapons" >> "Throw" >> _x >> "magazines");
} forEach getArray(configFile >> "CfgWeapons" >> "Throw" >> "muzzles");

AS_allMagazines = [];
{
	AS_allMagazines pushBackUnique configName _x;
} forEach _allMagazines;


/*
AssaultRifle
BombLauncher
Cannon
GrenadeLauncher
Handgun
Launcher
MachineGun
Magazine
MissileLauncher
Mortar
RocketLauncher
Shotgun
Throw
Rifle
SubmachineGun
SniperRifle
*/
AS_weapons = [
	[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]
];

AS_allWeapons = [];
AS_allWeaponsAttrs = [];
{
	_name = configName _x;
	_name = [_name] call BIS_fnc_baseWeapon;
	if (not(_name in AS_allWeapons)) then {
		AS_allWeapons pushBack _name;
		_weight = (getNumber (configFile >> "CfgWeapons" >> _name >> "WeaponSlotsInfo" >> "mass"));
		_magazines = (getArray (configFile >> "CfgWeapons" >> _name >> "magazines"));
		_bull_weight = (getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "mass"));
		_bull_speed = (getNumber (configFile >> "CfgMagazines" >> (_magazines select 0) >> "initSpeed"));

		if (isNil "_bull_weight") then {
			_bull_weight = 0;
		};
		if (isNil "_bull_speed") then {
			_bull_speed = 0;
		};

		AS_allWeaponsAttrs pushBack [_weight, _bull_weight*_bull_speed/100*_bull_speed/100, _magazines];

		_weaponType = ([_name] call BIS_fnc_itemType) select 1;

		switch (_weaponType) do {
            case "AssaultRifle": {

                call {
                    // a sub-optimal fix to not put snipers in this bucket.
                    if (_name find "srifle" != -1) exitWith {
                        (AS_weapons select 15) pushBack _name;
                    };
                    private _is_GL = false;
                    {
                        private _class = (configFile >> "CfgWeapons" >> _name >> _x);
                        if (!isNull _class and "GrenadeLauncher" in ([_class,true] call BIS_fnc_returnParents)) exitWith {
                            _is_GL = true;
                        };
                    } forEach getArray (configFile >> "CfgWeapons" >> _name >> "muzzles");
                    if (_is_GL) exitWith {
                        (AS_weapons select 3) pushBack _name;
                    };
                    (AS_weapons select 0) pushBack _name;
                };
            };
			case "BombLauncher": {(AS_weapons select 1) pushBack _name};
			case "Cannon": {(AS_weapons select 2) pushBack _name};
			case "GrenadeLauncher": {(AS_weapons select 3) pushBack _name};
			case "Handgun": {(AS_weapons select 4) pushBack _name};
			case "Launcher": {(AS_weapons select 5) pushBack _name};
			case "MachineGun": {(AS_weapons select 6) pushBack _name};
			case "Magazine": {(AS_weapons select 7) pushBack _name};
			case "MissileLauncher": {(AS_weapons select 8) pushBack _name};
			case "Mortar": {(AS_weapons select 9) pushBack _name};
			case "RocketLauncher": {(AS_weapons select 10) pushBack _name};
			case "Shotgun": {(AS_weapons select 11) pushBack _name};
			case "Throw": {(AS_weapons select 12) pushBack _name};
			case "Rifle": {(AS_weapons select 13) pushBack _name};
			case "SubmachineGun": {(AS_weapons select 14) pushBack _name};
			case "SniperRifle": {(AS_weapons select 15) pushBack _name};
		};
	};
} forEach _allPrimaryWeapons + _allHandGuns + _allLaunchers;
