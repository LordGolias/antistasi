
private _fnc_allSoldiers = {
	params ["_soldiers", "_groups", "_groupsCfg"];
	private _result = +_soldiers;
	{
		private _group = _groupsCfg >> _x;
		for "_i" from 0 to count _group - 1 do {
			_unitConf = _group select _i;
			if (isClass _unitConf) then {
				_result pushBack (getText (_unitConf >> "vehicle"));
			};
		};
	} forEach _groups;
	_result arrayIntersect _result - [""]
};

private _fnc_allEquipment = {
	params ["_soldiers"];
	private _sideWeapons = [];
	private _sideMagazines = [];
	private _sideItems = [];
	private _sideBackbacks = [];

	{
		// _x is a soldier class
		private _weapons = getArray (configFile >> "CfgVehicles" >> _x >> "weapons");
		_sideMagazines = _sideMagazines + getArray (configFile >> "CfgVehicles" >> _x >> "magazines");
		_sideItems = _sideItems + getArray (configFile >> "CfgVehicles" >> _x >> "Items") + getArray (configFile >> "CfgVehicles" >> _x >> "linkedItems");
		private _bp = getText (configFile >> "CfgVehicles" >> _x >> "backpack");
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

	// populate AAF items with relevant meds.
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

	[_sideWeapons, _sideMagazines, _sideItems, _sideBackbacks]
};

//////////////////// AAF ////////////////////
AAFsoldiers = [
	(["AAF", "officers"] call AS_fnc_getEntity) +
	(["AAF", "snipers"] call AS_fnc_getEntity) +
	(["AAF", "ncos"] call AS_fnc_getEntity) +
	(["AAF", "specials"] call AS_fnc_getEntity) +
	(["AAF", "mgs"] call AS_fnc_getEntity) +
	(["AAF", "regulars"] call AS_fnc_getEntity) +
	(["AAF", "crews"] call AS_fnc_getEntity) +
	(["AAF", "pilots"] call AS_fnc_getEntity),
	(["AAF", "patrols"] call AS_fnc_getEntity) +
	(["AAF", "garrisons"] call AS_fnc_getEntity) +
	(["AAF", "teamsATAA"] call AS_fnc_getEntity) +
	(["AAF", "teams"] call AS_fnc_getEntity) +
	(["AAF", "teamsAT"] call AS_fnc_getEntity) +
	(["AAF", "teamsAA"] call AS_fnc_getEntity),
	(["AAF", "cfgGroups"] call AS_fnc_getEntity)
] call _fnc_allSoldiers;

private _result = [AAFsoldiers] call _fnc_allEquipment;
AAFWeapons = _result select 0;
AAFMagazines = _result select 1;
AAFItems = _result select 2;
AAFBackpacks = _result select 3;

// Assign other items
AAFVests = AAFItems arrayIntersect AS_allVests;
AAFHelmets = AAFItems arrayIntersect AS_allHelmets;

AAFThrowGrenades = AAFMagazines arrayIntersect AS_allThrowGrenades;
AAFMagazines = AAFMagazines - AAFThrowGrenades;

//////////////////// NATO ////////////////////

// List of all NATO soldiers
NATOsoldiers = [
	[bluPilot, bluCrew, bluGunner] + bluMRAPHMGgroup + bluMRAPgroup + bluAirCav,
	bluSquad + bluSquadWeapons + bluTeam + bluATTeam,
	NATOConfigGroupInf
] call _fnc_allSoldiers;

_result = [NATOsoldiers] call _fnc_allEquipment;
NATOWeapons = _result select 0;
NATOMagazines = _result select 1;
NATOItems = _result select 2;
NATOBackpacks = _result select 3;

NATOVests = NATOItems arrayIntersect AS_allVests;
NATOHelmets = NATOItems arrayIntersect AS_allHelmets;

NATOThrowGrenades = NATOMagazines arrayIntersect AS_allThrowGrenades;
NATOMagazines = NATOMagazines - NATOThrowGrenades;

//////////////////// CSAT ////////////////////

CSATsoldiers = [
	[opI_OFF,opI_PIL,opI_SL,opI_RFL1,opI_CREW],
	opGroup_SpecOps + opGroup_Squad + opGroup_Recon_Team,
	CSATConfigGroupInf
] call _fnc_allSoldiers;

// List of all CSAT equipment
_result = [CSATsoldiers] call _fnc_allEquipment;
CSATWeapons = _result select 0;
CSATMagazines = _result select 1;
CSATItems = _result select 2;
CSATBackpacks = _result select 3;

CSATVests = CSATItems arrayIntersect AS_allVests;
CSATHelmets = CSATItems arrayIntersect AS_allHelmets;

CSATThrowGrenades = CSATMagazines arrayIntersect AS_allThrowGrenades;
CSATMagazines = CSATMagazines - CSATThrowGrenades;
