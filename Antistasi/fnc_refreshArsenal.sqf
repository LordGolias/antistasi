#include "macros.hpp"
AS_SERVER_ONLY("fnc_refreshArsenal.sqf");
// _clean: whether to clean unavailable mod-weapons from `unlocked*`.
params [["_clean", false]];

if _clean then {
    unlockedWeapons = unlockedWeapons arrayIntersect unlockedWeapons;
    unlockedWeapons = unlockedWeapons arrayIntersect AS_allWeapons;
    publicVariable "unlockedWeapons";

    unlockedMagazines = unlockedMagazines arrayIntersect unlockedMagazines;
    unlockedMagazines = unlockedMagazines arrayIntersect AS_allMagazines;
    publicVariable "unlockedMagazines";

    unlockedItems = unlockedItems arrayIntersect unlockedItems;
    unlockedItems pushBackUnique "Binocular";
    publicVariable "unlockedItems";

    unlockedBackpacks = unlockedBackpacks arrayIntersect unlockedBackpacks;
    publicVariable "unlockedBackpacks";
};

[caja, getWeaponCargo caja, getMagazineCargo caja, getItemCargo caja, getBackpackCargo caja, true, true] call AS_fnc_populateBox;

diag_log "[AS] Server: Arsenal resynchronised";
