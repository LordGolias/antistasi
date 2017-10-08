params ["_soldiers"];
private _sideWeapons = [];
private _sideMagazines = [];
private _sideItems = [];
private _sideBackbacks = [];
private _sideUniforms = [];

{
    // _x is a soldier class
    private _weapons = getArray (configFile >> "CfgVehicles" >> _x >> "weapons");
    _sideMagazines = _sideMagazines + getArray (configFile >> "CfgVehicles" >> _x >> "magazines");
    _sideItems = _sideItems + getArray (configFile >> "CfgVehicles" >> _x >> "Items") + getArray (configFile >> "CfgVehicles" >> _x >> "linkedItems");
    private _bp = getText (configFile >> "CfgVehicles" >> _x >> "backpack");
    private _uniform = getText (configFile >> "CfgVehicles" >> _x >> "uniformClass");

    _sideUniforms pushBack _uniform;

    if (_bp != "") then {
        _sideBackbacks pushBack (_bp call BIS_fnc_basicBackpack);
    };

    {
        // _x is now a weapon class
        _sideWeapons pushBack ([_x] call BIS_fnc_baseWeapon);
        private _linkedItems = configFile >> "CfgWeapons" >> _x >> "LinkedItems";
        {
            // _x is now a LinkedItem class
            _sideItems pushBack ( getText (_linkedItems >> _x >> "item"));
        } forEach ["LinkedItemsAcc", "LinkedItemsOptic", "LinkedItemsUnder", "LinkedItemsMuzzle"];
    } forEach _weapons;
} forEach _soldiers;

// add all magazines that fit the weapons.
{
    private _index = AS_allWeapons find _x;
    if (_index != -1) then {
        _sideMagazines append ((AS_allWeaponsAttrs select _index) select 2);

        // add grenades
        private _weapon = [_x] call BIS_fnc_baseWeapon;
        {
            private _class = (configFile >> "CfgWeapons" >> _weapon >> _x);
            if (!isNull _class and "GrenadeLauncher" in ([_class,true] call BIS_fnc_returnParents)) exitWith {
                _sideMagazines append (getArray (_class >> "magazines"));
            };
        } forEach getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");
    };
} forEach _sideWeapons;

// populate items with relevant meds.
if (hayACE) then {
    if (ace_medical_level == 0) then {
        _sideItems append ["FirstAidKit","Medikit"];
    } else {
        _sideItems = _sideItems - ["FirstAidKit","Medikit"];
    };
    if (ace_medical_level >= 1) then {
        _sideItems append AS_aceBasicMedical;
    };
    if (ace_medical_level == 2) then {
        _sideItems append AS_aceAdvMedical;
    };
} else {
    _sideItems append ["FirstAidKit","Medikit"];
};

// clean duplicates and non-interesting equipment
_sideWeapons = (_sideWeapons arrayIntersect _sideWeapons)  - ["", "Throw", "Put"] - AS_allBinoculars;
_sideWeapons = _sideWeapons arrayIntersect AS_allWeapons;
_sideMagazines = (_sideMagazines arrayIntersect _sideMagazines) - [""];
_sideMagazines = _sideMagazines arrayIntersect AS_allMagazines;
_sideItems = (_sideItems arrayIntersect _sideItems) - [""];
_sideItems = _sideItems arrayIntersect AS_allItems;
_sideBackbacks = (_sideBackbacks arrayIntersect _sideBackbacks) - [""];
_sideBackbacks = _sideBackbacks arrayIntersect AS_allBackpacks;
_sideUniforms = (_sideUniforms arrayIntersect _sideUniforms) - [""];

[_sideWeapons, _sideMagazines, _sideItems, _sideBackbacks, _sideUniforms]
