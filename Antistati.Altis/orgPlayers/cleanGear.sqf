private ["_items","_gps"];

_gps = false;
_radio = false;

removeAllWeapons player;

_items = assignedItems player;
if (isNil "_items") exitWith {};
if ("ItemGPS" in _items) then {_gps = true};
if ("ItemRadio" in _items) then {_radio = true};
removeAllAssignedItems player;
removeAllItems player;
removeVest player;
removeBackpack player;

player addBackpack "B_TacticalPack_blk";
if (_gps) then {player addItemToBackpack "ItemGPS"; player assignItem "ItemGPS";};
if (_radio) then {player addItemToBackpack "ItemRadio"; player assignItem "ItemRadio";};

player addItemToBackpack "ItemMap";
player assignItem "ItemMap";
player addItemToBackpack "ItemCompass";
player assignItem "ItemCompass";
player addItemToBackpack "ItemWatch";
player assignItem "ItemWatch";