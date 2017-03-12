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

		[unlockedWeapons, true] spawn fnc_weaponsCheck;
	}
	else {
		[unlockedWeapons] spawn fnc_weaponsCheck;
	};

	0 = [] call fnc_MAINT_refillArsenal;

	// XLA fixed arsenal
	if (hayXLA) then {
		_weapons = caja call XLA_fnc_getVirtualWeaponCargo;
		_magazines = caja call XLA_fnc_getVirtualMagazineCargo;
		_items = caja call XLA_fnc_getVirtualItemCargo;
		_backpacks = caja call XLA_fnc_getVirtualBackpackCargo;

		[caja,_weapons,true] call XLA_fnc_removeVirtualWeaponCargo;
		[caja,_magazines,true] call XLA_fnc_removeVirtualMagazineCargo;
		[caja,_items,true] call XLA_fnc_removeVirtualItemCargo;
		[caja,_backpacks,true] call XLA_fnc_removeVirtualBackpackCargo;

		[caja,unlockedWeapons,true,false] call XLA_fnc_addVirtualWeaponCargo;
		[caja,unlockedMagazines,true,false] call XLA_fnc_addVirtualMagazineCargo;
		[caja,unlockedItems,true,false] call XLA_fnc_addVirtualItemCargo;
		[caja,unlockedBackpacks,true,false] call XLA_fnc_addVirtualBackpackCargo;
	} else {
		_weapons = caja call BIS_fnc_getVirtualWeaponCargo;
		_magazines = caja call BIS_fnc_getVirtualMagazineCargo;
		_items = caja call BIS_fnc_getVirtualItemCargo;
		_backpacks = caja call BIS_fnc_getVirtualBackpackCargo;

		[caja,_weapons,true] call BIS_fnc_removeVirtualWeaponCargo;
		[caja,_magazines,true] call BIS_fnc_removeVirtualMagazineCargo;
		[caja,_items,true] call BIS_fnc_removeVirtualItemCargo;
		[caja,_backpacks,true] call BIS_fnc_removeVirtualBackpackCargo;

		[caja,unlockedWeapons,true,false] call BIS_fnc_addVirtualWeaponCargo;
		[caja,unlockedMagazines,true,false] call BIS_fnc_addVirtualMagazineCargo;
		[caja,unlockedItems,true,false] call BIS_fnc_addVirtualItemCargo;
		[caja,unlockedBackpacks,true,false] call BIS_fnc_addVirtualBackpackCargo;
	};

	0 = [] call arsenalManage;

	[[petros,"hint","Arsenal synchronized"],"commsMP"] call BIS_fnc_MP;
	diag_log "Maintenance: Arsenal resynchronised";
};

fnc_MAINT_refillArsenal = {

	_cargo = getWeaponCargo caja;
	clearWeaponCargoGlobal caja;
	for "_i" from 0 to (count (_cargo select 0) - 1) do {
		_name = (_cargo select 0) select _i;
		_amount = (_cargo select 1) select _i;
		if (_name in AS_allWeapons and !(_name in unlockedWeapons)) then {
			caja addWeaponCargoGlobal [_name,_amount];
		};
	};

	_cargo = getMagazineCargo caja;
	clearMagazineCargoGlobal caja;
	for "_i" from 0 to (count (_cargo select 0) - 1) do {
		_name = (_cargo select 0) select _i;
		_amount = (_cargo select 1) select _i;
		if (_name in AS_allMagazines and !(_name in unlockedMagazines)) then {
			caja addMagazineCargoGlobal [_name,_amount];
		};
	};

	_cargo = getItemCargo caja;
	clearItemCargoGlobal caja;
	for "_i" from 0 to (count (_cargo select 0) - 1) do {
		_name = (_cargo select 0) select _i;
		_amount = (_cargo select 1) select _i;
		if (!(_name in unlockedItems)) then {
			caja addItemCargoGlobal [_name,_amount];
		};
	};

	_cargo = getBackpackCargo caja;
	clearBackpackCargoGlobal caja;
	for "_i" from 0 to (count (_cargo select 0) - 1) do {
		_name = (_cargo select 0) select _i;
		_amount = (_cargo select 1) select _i;
		if (!(_name in unlockedBackpacks)) then {
			caja addBackpackCargoGlobal [_name,_amount];
		};
	};
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