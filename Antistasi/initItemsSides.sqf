//////////////////// AAF ////////////////////
private _AAFsoldiers = (["AAF", "cfgGroups"] call AS_fnc_getEntity) call AS_fnc_getAllUnits;

// List of all AAF equipment
private _result = [_AAFsoldiers] call AS_fnc_listUniqueEquipment;
AAFWeapons = _result select 0;
AAFMagazines = _result select 1;
AAFItems = _result select 2;
AAFBackpacks = _result select 3;

AAFLaunchers = AAFWeapons arrayIntersect (AS_weapons select 8);

// Assign other items
AAFVests = AAFItems arrayIntersect AS_allVests;
AAFHelmets = AAFItems arrayIntersect AS_allHelmets;

AAFThrowGrenades = AAFMagazines arrayIntersect AS_allThrowGrenades;
AAFMagazines = AAFMagazines - AAFThrowGrenades;

//////////////////// NATO ////////////////////
private _NATOsoldiers = (["NATO", "cfgGroups"] call AS_fnc_getEntity) call AS_fnc_getAllUnits;

// List of all NATO equipment
_result = [_NATOsoldiers] call AS_fnc_listUniqueEquipment;
NATOWeapons = _result select 0;
NATOMagazines = _result select 1;
NATOItems = _result select 2;
NATOBackpacks = _result select 3;

NATOLaunchers = NATOWeapons arrayIntersect (AS_weapons select 8);

NATOVests = NATOItems arrayIntersect AS_allVests;
NATOHelmets = NATOItems arrayIntersect AS_allHelmets;

NATOThrowGrenades = NATOMagazines arrayIntersect AS_allThrowGrenades;
NATOMagazines = NATOMagazines - NATOThrowGrenades;

//////////////////// CSAT ////////////////////
private _CSATsoldiers = (["CSAT", "cfgGroups"] call AS_fnc_getEntity) call AS_fnc_getAllUnits;

// List of all CSAT equipment
_result = [_CSATsoldiers] call AS_fnc_listUniqueEquipment;
CSATWeapons = _result select 0;
CSATMagazines = _result select 1;
CSATItems = _result select 2;
CSATBackpacks = _result select 3;

CSATLaunchers = CSATWeapons arrayIntersect (AS_weapons select 8);

CSATVests = CSATItems arrayIntersect AS_allVests;
CSATHelmets = CSATItems arrayIntersect AS_allHelmets;

CSATThrowGrenades = CSATMagazines arrayIntersect AS_allThrowGrenades;
CSATMagazines = CSATMagazines - CSATThrowGrenades;

//////////////////// CIV ////////////////////////

private _CIVunits = ["CIV", "units"] call AS_fnc_getEntity;
_result = [_CIVunits] call AS_fnc_listUniqueEquipment;
CIVUniforms = _result select 4;

unlockedWeapons = ["FIA", "unlockedWeapons"] call AS_fnc_getEntity;
unlockedMagazines = ["FIA", "unlockedMagazines"] call AS_fnc_getEntity;
unlockedBackpacks = ["FIA", "unlockedBackpacks"] call AS_fnc_getEntity;

if hasTFAR then {
    unlockedItems = unlockedItems - ["ItemRadio"];
    unlockedItems pushBack ([(["AAF", "tfar_radio"] call AS_fnc_getEntity)]);
    if not hasRHS then {
		unlockedItems pushBack "tf_microdagr";
    };
};

//////////////////// FIA ////////////////////////
unlockedItems = unlockedItems +
	CIVUniforms +
	(["FIA", "uniforms"] call AS_fnc_getEntity) +
	(["FIA", "helmets"] call AS_fnc_getEntity) +
	(["FIA", "vests"] call AS_fnc_getEntity) +
	(["FIA", "googles"] call AS_fnc_getEntity);
