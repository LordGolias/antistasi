/*
_neverUsed = ["ACE_Banana", "ACE_SpraypaintBlack", "ACE_SpraypaintRed", "ACE_SpraypaintGreen", "ACE_SpraypaintBlue",
              "ACE_CableTie", "ACE_key_lockpick", "ACE_key_master", "ACE_key_west", "ACE_key_east", "ACE_key_civ", "ACE_key_indp"];
*/

unlockedItems = unlockedItems + [
    "ACE_wirecutter", "ACE_Sandbag_empty",
    "ACE_MapTools", "ACE_EntrenchingTool", "ACE_Tripod",
    "ACE_SpottingScope", "ACE_Cellphone", "ACE_RangeCard", "ACE_RangeTable_82mm"
];

if (ace_medical_level >= 1) then {
    unlockedItems = unlockedItems + AS_aceBasicMedical;
    unlockedItems = unlockedItems - ["FirstAidKit","Medikit"];
};

if (ace_medical_level == 2) then {
    unlockedItems = unlockedItems + AS_aceAdvMedical;
};

if (hasACEhearing) then {
    unlockedItems = unlockedItems + ["ACE_EarPlugs"];
};

_mapIllu = ["ACE_Flashlight_MX991", "ACE_Flashlight_KSF1",
    "ACE_Flashlight_XL50", "ACE_Chemlight_Shield"];
if (ace_map_mapIllumination) then {
    unlockedItems = unlockedItems + _mapIllu;
};
