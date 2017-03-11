if (!isServer) exitWith {};

fnc_MAINT_main = {
	0 = [true] call fnc_MAINT_arsenal;
};

fnc_MAINT_arsenal = {
	params [["_clean", false]];
	private ["_weapons", "_magazines", "_items", "_backpacks", "_allMags", "_weapCargo", "_magCargo", "_itemCargo", "_bpCargo", "_z"];

	if (_clean) then {
		[[],[],[],[],[],[],[],[],[],[]] call {
			params ["_uW", "_uM", "_uI", "_uB", "_uO", "_uR", "_uWc", "_uMc", "_uIc", "_uBc"];

			if (count unlockedWeapons > 0) then {
				for "_i" from 0 to (count unlockedWeapons - 1) do {
					_z = unlockedWeapons select _i;
					if (_z in AS_allWeapons) then {
						_uW pushBackUnique _z;
					};
				};
				unlockedWeapons = _uW;
				publicVariable "unlockedWeapons";
			};
			if (count unlockedMagazines > 0) then {
				for "_i" from 0 to (count unlockedMagazines - 1) do {
					_z = unlockedMagazines select _i;
					if (_z in AS_allMagazines) then {
						_uM pushBackUnique _z;
					};
				};
				unlockedMagazines = _uM;
				publicVariable "unlockedMagazines";
			};
			if (count unlockedItems > 0) then {
				for "_i" from 0 to (count unlockedItems - 1) do {
					_uI pushBackUnique (unlockedItems select _i);
				};
				unlockedItems = _uI;
				unlockedItems pushBackUnique "Binocular";
				publicVariable "unlockedItems";
			};
			if (count unlockedBackpacks > 0) then {
				for "_i" from 0 to (count unlockedBackpacks - 1) do {
					_uB pushBackUnique (unlockedBackpacks select _i);
				};
				unlockedBackpacks = _uB;
				publicVariable "unlockedBackpacks";
			};
			if (count unlockedOptics > 0) then {
				for "_i" from 0 to (count unlockedOptics - 1) do {
					_uO pushBackUnique (unlockedOptics select _i);
				};
				unlockedOptics = _uO;
				publicVariable "unlockedOptics";
			};
			if (count unlockedRifles > 0) then {
				for "_i" from 0 to (count unlockedRifles - 1) do {
					_z = unlockedRifles select _i;
					if (_z in AS_allWeapons) then {
						_uR pushBackUnique _z;
					};
				};
				unlockedRifles = _uR;
				publicVariable "unlockedRifles";
			};

			[unlockedWeapons, true] spawn fnc_weaponsCheck;
		};
	};

	0 = [] call fnc_MAINT_arsInv;

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

	if !(_clean) then {[unlockedWeapons] spawn fnc_weaponsCheck};

	0 = [] call arsenalManage;

	[[petros,"hint","Arsenal synchronized"],"commsMP"] call BIS_fnc_MP;
	diag_log "Maintenance: Arsenal resynchronised";
};

fnc_MAINT_arsInv = {
	_weapCargo = weaponCargo caja;
	_magCargo = magazineCargo caja;
	_itemCargo = itemCargo caja;
	_bpCargo = backpackCargo caja;

	[[], [], [], []] params ["_uWc", "_uMc", "_uIc", "_uBc"];

	if (count _weapCargo > 0) then {
		for "_i" from 0 to (count _weapCargo - 1) do {
			_z = _weapCargo select _i;
			if (_z in AS_allWeapons) then {
				if !(_z in unlockedWeapons) then {_uWc pushBack _z};
			};
		};
		clearWeaponCargoGlobal caja;
		{caja addWeaponCargoGlobal [_x,1]} forEach _uWc;
	};

	if (count _magCargo > 0) then {
		for "_i" from 0 to (count _magCargo - 1) do {
			_z = _magCargo select _i;
			if (_z in AS_allMagazines) then {
				if !(_z in unlockedMagazines) then {_uMc pushBack _z};
			};
		};
		clearMagazineCargoGlobal caja;
		{caja addMagazineCargoGlobal [_x,1]} forEach _uMc;
	};

	if (count _itemCargo > 0) then {
		for "_i" from 0 to (count _itemCargo - 1) do {
			if !(_z in unlockedItems) then {_uIc pushBack (_itemCargo select _i)};
		};
		clearItemCargoGlobal caja;
		{caja addItemCargoGlobal [_x,1]} forEach _uIc;
	};

	if (count _bpCargo > 0) then {
		for "_i" from 0 to (count _bpCargo - 1) do {
			if !(_z in unlockedBackpacks) then {_uBc pushBack (_bpCargo select _i)};
		};
		clearBackpackCargoGlobal caja;
		{caja addBackpackCargoGlobal [_x,1]} forEach _uBc;
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