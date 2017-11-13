params ["_unit"];

// see http://stackoverflow.com/a/43189968/7808917
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addweapon "ItemMap";
_unit addweapon "ItemCompass";
_unit addweapon "ItemRadio";
_unit addweapon "ItemGPS";
_unit addweapon "ItemWatch";
