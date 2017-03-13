if (!isServer) exitWith {};

fnc_MAINT_main = {
	0 = [true] call fnc_MAINT_arsenal;
};

fnc_MAINT_arsenal = {
	// _clean: whether to clean unavailable mod-weapons from `unlocked*`.
	params [["_clean", false]];
	private ["_weapons", "_magazines", "_items", "_backpacks", "_allMags", "_weapCargo", "_magCargo", "_itemCargo", "_bpCargo", "_z"];

	if (_clean) then {
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

		unlockedOptics = unlockedOptics arrayIntersect unlockedOptics;
		publicVariable "unlockedOptics";

		unlockedRifles = unlockedRifles arrayIntersect unlockedRifles;
		unlockedRifles = unlockedRifles arrayIntersect unlockedWeapons;
		publicVariable "unlockedRifles";

		[true] call fnc_weaponsCheck;
	}
	else {
		[] call fnc_weaponsCheck;
	};

	0 = [] call fnc_MAINT_refillArsenal;

	[[petros,"hint","Arsenal synchronized"],"commsMP"] call BIS_fnc_MP;
	diag_log "Maintenance: Arsenal resynchronised";
};

fnc_MAINT_refillArsenal = {
	[caja, getWeaponCargo caja, getMagazineCargo caja, getItemCargo caja, getBackpackCargo caja, true, true] call AS_fnc_populateBox;
};

fnc_MAINT_BE = {
	[] call fnc_BE_refresh;
};

fnc_MAINT_moveStatic = {
	[] remoteExec ["fnc_addMoveObjAction",stavros];
	diag_log "Maintenance: statics moveable";
};

fnc_MAINT_resetPetros = {
	params [["_defPos", "none"]];
	private ["_dir"];

	if !(typeName "_defPos" == "ARRAY") then {
		_dir = fuego getdir cajaVeh;
		_defPos = [getPos fuego, 3, _dir + 45] call BIS_Fnc_relPos;
	};

	petros setPos _defPos;
	petros setDir (petros getDir fuego);

	diag_log "Maintenance: Petros repositioned";
};