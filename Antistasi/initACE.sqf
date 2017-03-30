_neverUsed = ["ACE_Banana", "ACE_SpraypaintBlack", "ACE_SpraypaintRed", "ACE_SpraypaintGreen", "ACE_SpraypaintBlue", 
              "ACE_CableTie", "ACE_key_lockpick", "ACE_key_master", "ACE_key_west", "ACE_key_east", "ACE_key_civ", "ACE_key_indp"];

AS_allItems = AS_allItems - _neverUsed;
AS_allAssessories = AS_allAssessories - _neverUsed;

unlockedItems = unlockedItems + [
    "ACE_wirecutter", "ACE_Sandbag_empty", 
    "ACE_MapTools", "ACE_EntrenchingTool", "ACE_Tripod", 
    "ACE_SpottingScope", "ACE_Cellphone", "ACE_RangeCard", "ACE_RangeTable_82mm"
];

AS_aceBasicMedical = [
    "ACE_fieldDressing",
    "ACE_bloodIV_250",
    "ACE_bloodIV_500",
    "ACE_bloodIV",
    "ACE_epinephrine",
    "ACE_morphine",
    "ACE_bodyBag"
];

AS_aceAdvMedical = [
    "ACE_salineIV_250",
    "ACE_salineIV_500",
    "ACE_salineIV",
    "ACE_plasmaIV_250",
    "ACE_plasmaIV_500",
    "ACE_plasmaIV",
    "ACE_packingBandage",
    "ACE_elasticBandage",
    "ACE_quikclot",
    "ACE_tourniquet",
    "ACE_atropine","ACE_adenosine",
    "ACE_personalAidKit",
    "ACE_surgicalKit"
];

if (ace_medical_level >= 1) then {
    unlockedItems = unlockedItems + AS_aceBasicMedical;
    unlockedItems = unlockedItems - ["FirstAidKit","Medikit"];
    AS_allItems = AS_allItems - ["FirstAidKit","Medikit"];
    AS_allAssessories = AS_allAssessories - ["FirstAidKit","Medikit"];
} else {
    AS_allItems = AS_allItems - AS_aceBasicMedical;
    AS_allAssessories = AS_allAssessories - AS_aceBasicMedical;
};

if (ace_medical_level == 2) then {
    unlockedItems = unlockedItems + AS_aceAdvMedical;
} else {
    AS_allItems = AS_allItems - AS_aceAdvMedical;
    AS_allAssessories = AS_allAssessories - AS_aceAdvMedical;
};

if (hayACEhearing) then {
    unlockedItems = unlockedItems + ["ACE_EarPlugs"];
} else {
    AS_allItems = AS_allItems - ["ACE_EarPlugs"];
    AS_allAssessories = AS_allAssessories - ["ACE_EarPlugs"];
};

_mapIllu = ["ACE_Flashlight_MX991", "ACE_Flashlight_KSF1", "ACE_Flashlight_XL50", "ACE_Chemlight_Shield"];
if (ace_map_mapIllumination) then {
    unlockedItems = unlockedItems + _mapIllu;
} else {
    AS_allItems = AS_allItems - _mapIllu;
    AS_allAssessories = AS_allAssessories - _mapIllu;
};
