

// the function that saves a property persistently.
AS_fnc_SaveStat = {
	_varName = _this select 0;
	_varValue = _this select 1;
	if (!isNil "_varValue") then {
		profileNameSpace setVariable [_varName + AS_profileID + AS_sessionID, _varValue];
	};
};

// the function that loads a property persistently.
AS_fnc_LoadStat = {
	_varName = _this select 0;
	profileNameSpace getVariable (_varName + AS_profileID + AS_sessionID)
};

// Variables that are persistent to `server`. They are saved and loaded accordingly.
// Add variables here that you want to save.
AS_serverVariables = [
	"prestigeNATO", "prestigeCSAT", "resourcesAAF", "resourcesFIA", "skillFIA", "hr",  // FIA attributes
	"enableFTold", "enableMemAcc"  // game options
];

// function that saves all AS_serverVariables. The two parameters overwrite the server variable value to save.
AS_fnc_saveServer = {
	params ["_varNames", "_varValues"];

	{
		_index = _varNames find _x;
		_varValue = server getVariable _x;
		if (_index != -1) then {
			_varValue = _varValues select _index;
		};
		[_x, _varValue] call AS_fnc_SaveStat;
	} forEach AS_serverVariables;

	call AS_fnc_saveCities;
};


// function that loads all AS_serverVariables.
AS_fnc_loadServer = {
	{
		server setVariable [_x, [_x] call AS_fnc_LoadStat, true];
	} forEach AS_serverVariables;

	call AS_fnc_loadCities;
	call AS_fnc_postLoadServer;
};

// set non-persistent variables that are functions of persistent variables.
AS_fnc_postLoadServer = {
	// increase cost of soldiers (what is this doing exactly??)
	_skillFIA = server getVariable "skillFIA";
	{
		_cost = server getVariable _x;
		for "_i" from 1 to _skillFIA do {
			_cost = round (_cost + (_cost * (_i/280)));
		};
		server setVariable [_x,_cost,true];
	} forEach soldadosFIA;
};

// function that persistently saves cities.
AS_fnc_saveCities = {
	{
		_data = server getVariable _x;
		["CITY" + _x, _data] call AS_fnc_SaveStat;
	} forEach ciudades;
};

AS_fnc_loadCities = {
	{
		server setVariable [_x, ["CITY" + _x] call AS_fnc_LoadStat];
	} forEach ciudades;
};


fn_SaveStat = AS_fnc_SaveStat;  // to be replaced in whole project.

fn_SaveProfile = {saveProfileNamespace};

// every city name is a variable of `server` and each contains an array with data. This maps names to its respective array index.
// the first two indexes are occupied (with city pop and city civ vehicles).
// Add other variables for more data.
AS_cityVars = ["population", "vehicles", "prestigeOPFOR", "prestigeBLUFOR"];

// given a city and an array of variable names, it returns a list of values refering to each var name.
AS_fnc_getCityAttrs = {
	private ["_values", "_data"];
	params ["_city", "_varNames"];
	
	_data = server getVariable _city;
	
	_values = [];
	{
		_index = AS_cityVars find _x;
		if (_index == -1) throw ("AS_fnc_getCityAttrs: property " + _x + " does not exist");
		_values pushBack (_data select _index);
	} forEach _varNames;
	_values
};

// given a city, an array of variables names and another of values, sets the variables respectively.
AS_fnc_setCityAttrs = {
	private ["_data"];
	params ["_city", "_varNames", "_varValues"];
	
	_data = server getVariable _city;
	
	for "_i" from 0 to (count _varNames - 1) do {
		_varName = _varNames select _x;
		_varValue = _varValues select _x;
		
		_index = AS_cityVars find _x;
		if (_index == -1) throw ("AS_fnc_setCityAttrs: property " + _varName + " does not exist");
		_data set [_index, _varValue];
	};
	server setVariable [_city, _data, true];
};

AS_fnc_initCity = {
	params ["_city", "_values"];
	if (count _values != count AS_cityVars) throw "AS_fnc_initCity: wrong initialisation.";
    server setVariable [_city,_values, true];
};

// loads global persistent variables.
fn_LoadStat = {
	_varName = _this select 0;
	_varValue = [_varName] call AS_fnc_LoadStat;
	if(isNil "_varValue") exitWith {};
	[_varName,_varValue] call fn_SetStat;
};

//===========================================================================
// Variables that require scripting after loaded. See fn_SetStat.
specialVarLoads =
["puestosFIA","minas","mineFieldMrk","estaticas","cuentaCA","antenas","posHQ","planesAAFcurrent","helisAAFcurrent","APCAAFcurrent","tanksAAFcurrent","armas","items","mochis","municion","fecha","skillAAF","garrison","tasks","gogglesPlayer","vestPlayer","outfit","hat","scorePlayer","rankPlayer","dinero","unlockedWeapons","unlockedItems","unlockedMagazines","unlockedBackpacks","destroyedBuildings","idleBases","campsFIA","campList","BE_data"];

// global variables that are set to be publicVariable on loading.
AS_publicVariables = [
	"cuentaCA", "miembros", "unlockedWeapons", "unlockedBackpacks", "unlockedItems", "unlockedMagazines",
	"planesAAFcurrent", "helisAAFcurrent", "APCAAFcurrent", "unlockedItems", "tanksAAFcurrent", "destroyedCities",
	"distanciaSPWN", "civPerc", "minimoFPS", "vehInGarage", "skillAAF", "staticsToSave"
];

//THIS FUNCTIONS HANDLES HOW STATS ARE LOADED
fn_SetStat = {
	_varName = _this select 0;
	_varValue = _this select 1;
	if(isNil '_varValue') exitWith {};

	if(_varName in specialVarLoads) then {
		call {
			if(_varName == 'cuentaCA') exitWith {
				if (_varValue < 2700) then {cuentaCA = 2700} else {cuentaCA = _varValue};
			};
			if(_varName == 'gogglesPlayer') exitWith {removeGoggles player; player addGoggles _varValue;};
			if(_varName == 'dinero') exitWith {player setVariable ["dinero",_varValue,true];};
			if(_varName == 'vestPlayer') exitWith {removeVest player; player addVest _varValue;};
			if(_varName == 'outfit') exitWith {removeUniform player; player forceAddUniform _varValue;};
			if(_varName == 'hat') exitWith {removeHeadGear player; player addHeadGear _varValue;};
			if(_varName == 'scorePlayer') exitWith {player setVariable ["score",_varValue,true];};
			if(_varName == 'rankPlayer') exitWith {player setRank _varValue; player setVariable ["rango",_varValue,true]; [player, _varValue] remoteExec ["ranksMP"];};

			if(_varName == 'BE_data') exitWith {[_varValue] call fnc_BE_load};
			if(_varName == 'unlockedWeapons') exitWith {
				unlockedWeapons = _varvalue;
				lockedWeapons = lockedWeapons - unlockedWeapons;
				// XLA fixed arsenal
				if (hayXLA) then {
					[caja,unlockedWeapons,true] call XLA_fnc_addVirtualWeaponCargo;
				} else {
					[caja,unlockedWeapons,true] call BIS_fnc_addVirtualWeaponCargo;
				};
			};
			if(_varName == 'unlockedBackpacks') exitWith {
				unlockedBackpacks = _varvalue;
				genBackpacks = genBackpacks - unlockedBackpacks;
				// XLA fixed arsenal
				if (hayXLA) then {
					[caja,unlockedBackpacks,true] call XLA_fnc_addVirtualBackpackCargo;
				} else {
					[caja,unlockedBackpacks,true] call BIS_fnc_addVirtualBackpackCargo;
				};
			};
			if(_varName == 'unlockedItems') exitWith {
				unlockedItems = _varValue;
				// XLA fixed arsenal
				if (hayXLA) then {
					[caja,unlockedItems,true] call XLA_fnc_addVirtualItemCargo;
				} else {
					[caja,unlockedItems,true] call BIS_fnc_addVirtualItemCargo;
				};
				{
				if (_x in unlockedItems) then {unlockedOptics pushBack _x};
				} forEach genOptics;
				publicVariable "unlockedOptics";
			};
			if(_varName == 'unlockedMagazines') exitWith {
				unlockedMagazines = _varValue;
				// XLA fixed arsenal
				if (hayXLA) then {
					[caja,unlockedMagazines,true] call XLA_fnc_addVirtualMagazineCargo;
				} else {
					[caja,unlockedMagazines,true] call BIS_fnc_addVirtualMagazineCargo;
				};
			};
			if(_varName == 'planesAAFcurrent') exitWith {
				planesAAFcurrent = _varValue;
				if (planesAAFcurrent < 0) then {planesAAFcurrent = 0};
				if ((planesAAFcurrent > 0) and (count planesAAF < 2)) then {planesAAF = planesAAF + planes; publicVariable "planesAAF"}
			};
			if(_varName == 'helisAAFcurrent') exitWith {
				helisAAFcurrent = _varValue;
				if (helisAAFcurrent < 0) then {helisAAFcurrent = 0};
				if (helisAAFcurrent > 0) then {
					planesAAF = planesAAF - heli_armed;
					planesAAF = planesAAF + heli_armed;
					publicVariable "planesAAF";
				};
			};
			if(_varName == 'APCAAFcurrent') exitWith {
				APCAAFcurrent = _varValue;
				if (APCAAFcurrent < 0) then {APCAAFcurrent = 0};
				if (APCAAFcurrent > 0) then {
					vehAAFAT = vehAAFAT -  vehAPC - vehIFV;
					vehAAFAT = vehAAFAT +  vehAPC + vehIFV;
					publicVariable "vehAAFAT";
				};
			};
			if(_varName == 'tanksAAFcurrent') exitWith {
				tanksAAFcurrent = _varValue;
				if (tanksAAFcurrent < 0) then {tanksAAFcurrent = 0};
				if (tanksAAFcurrent > 0) then {
					vehAAFAT = vehAAFAT - vehTank;
					vehAAFAT = vehAAFAT +  vehTank;
					publicVariable "vehAAFAT"
				};
			};
			if(_varName == 'fecha') exitWith {setDate _varValue; forceWeatherChange};
			if(_varName == 'destroyedBuildings') exitWith {
				for "_i" from 0 to (count _varValue) - 1 do {
					_posBuild = _varValue select _i;
					if (typeName _posBuild == "ARRAY") then {
						_buildings = [];
						_dist = 5;
						while {count _buildings == 0} do {
							_buildings = nearestObjects [_posBuild, listMilBld, _dist];
							_dist = _dist + 5;
						};
						if (count _buildings > 0) then {
							_milBuild = _buildings select 0;
							_milBuild setDamage 1;
						};
						destroyedBuildings = destroyedBuildings + [_posBuild];
					};
				};
			};
			if(_varName == 'skillAAF') exitWith {
				skillAAF = _varvalue;
				{
					_coste = server getVariable _x;
					for "_i" from 1 to skillAAF do {
						_coste = round (_coste + (_coste * (_i/280)));
					};
					server setVariable [_x,_coste,true];
				} forEach soldadosAAF;
			};
			if(_varName == 'minas') exitWith
				{
				for "_i" from 0 to (count _varvalue) - 1 do
					{
					_tipoMina = _varvalue select _i select 0;
					switch _tipoMina do
						{
						case "APERSMine_Range_Ammo": {_tipoMina = "APERSMine"};
						case "ATMine_Range_Ammo": {_tipoMina = "ATMine"};
						case "APERSBoundingMine_Range_Ammo": {_tipoMina = "APERSBoundingMine"};
						case "SLAMDirectionalMine_Wire_Ammo": {_tipoMina = "SLAMDirectionalMine"};
						case "APERSTripMine_Wire_Ammo": {_tipoMina = "APERSTripMine"};
						case "ClaymoreDirectionalMine_Remote_Ammo": {_tipoMina = "Claymore_F"};
						};
					_posMina = _varvalue select _i select 1;
					_mina = createMine [_tipoMina, _posMina, [], 0];
					_detectada = _varvalue select _i select 2;
					if (_detectada) then {side_blue revealMine _mina};
					if (count (_varvalue select _i) > 3) then//borrar esto en febrero
						{
						_dirMina = _varvalue select _i select 3;
						_mina setDir _dirMina;
						};
					};
				};
			if(_varName == 'garrison') exitWith
				{
				_marcadores = mrkFIA - puestosFIA - controles - ciudades;
				_garrison = _varvalue;
				for "_i" from 0 to (count _marcadores - 1) do
					{
					garrison setVariable [_marcadores select _i,_garrison select _i,true];
					};
				};
			if(_varName == 'puestosFIA') exitWith
				{
				{
				_mrk = createMarker [format ["FIApost%1", random 1000], _x];
				_mrk setMarkerShape "ICON";
				_mrk setMarkerType "loc_bunker";
				_mrk setMarkerColor "ColorYellow";
				if (isOnRoad _x) then {
					_mrk setMarkerText "FIA Roadblock";
					FIA_RB_list pushBackUnique _mrk;
					publicVariable "FIA_RB_list";
				} else {
					_mrk setMarkerText "FIA Watchpost";
					FIA_WP_list pushBackUnique _mrk;
					publicVariable "FIA_WP_list";
				};
				spawner setVariable [_mrk,false,true];
				puestosFIA pushBack _mrk;
				} forEach _varvalue;
				//mrkFIA = mrkFIA + puestosFIA;
				};
			if ((_varName == 'campList') || (_varName == 'campsFIA')) exitWith {
				if (_varName == 'campList') then {
					if (count _varvalue != 0) then {
						cList = true;

						{
							_mrk = createMarker [format ["FIACamp%1", random 1000], (_x select 0)];
							_mrk setMarkerShape "ICON";
							_mrk setMarkerType "loc_bunker";
							_mrk setMarkerColor "ColorOrange";
							_txt = _x select 1;
							_mrk setMarkerText _txt;
							usedCN pushBackUnique _txt;
							spawner setVariable [_mrk,false,true];
							campList pushBack [_mrk, _txt];
							campsFIA pushBack _mrk;
						} forEach _varvalue;
					};
				}
				else {
					if !(cList) then {
						{
							_mrk = createMarker [format ["FIACamp%1", random 1000], _x];
							_mrk setMarkerShape "ICON";
							_mrk setMarkerType "loc_bunker";
							_mrk setMarkerColor "ColorOrange";
							_nameOptions = campNames - usedCN;
							_txt = selectRandom _nameOptions;
							_mrk setMarkerText _txt;
							usedCN pushBack _txt;
							spawner setVariable [_mrk,false,true];
							campsFIA pushBack _mrk;
						} forEach _varvalue;
					};
				};
			};

			if(_varName == 'antenas') exitWith
				{
				antenasmuertas = _varvalue;
				for "_i" from 0 to (count _varvalue - 1) do
				    {
				    _posAnt = _varvalue select _i;
				    _mrk = [mrkAntenas, _posAnt] call BIS_fnc_nearestPosition;
				    _antena = [antenas,_mrk] call BIS_fnc_nearestPosition;
				    antenas = antenas - [_antena];
				    _antena removeAllEventHandlers "Killed";
				    sleep 1;
				    _antena setDamage 1;
				    deleteMarker _mrk;
				    };
				antenasmuertas = _varvalue;
				};
			if(_varName == 'armas') exitWith
				{
				clearWeaponCargoGlobal caja;
				{caja addWeaponCargoGlobal [_x,1]} forEach _varValue;
				};
			if(_varName == 'municion') exitWith
				{
				clearMagazineCargoGlobal caja;
				{caja addMagazineCargoGlobal [_x,1]} forEach _varValue;
				};
			if(_varName == 'items') exitWith
				{
				clearItemCargoGlobal caja;
				{caja addItemCargoGlobal [_x,1]} forEach _varValue;
				};
			if(_varName == 'mochis') exitWith
				{
				clearBackpackCargoGlobal caja;
				{caja addBackpackCargoGlobal [_x,1]} forEach _varValue;
				};
			if(_varname == 'idleBases') exitWith
				{
				{
				server setVariable [(_x select 0),(_x select 1),true];
				} forEach _varValue;
				};
			if(_varName == 'posHQ') exitWith
				{
				{if (getMarkerPos _x distance _varvalue < 1000) exitWith
					{
					mrkAAF = mrkAAF - [_x];
					mrkFIA = mrkFIA + [_x];
					};
				} forEach controles;
				"respawn_west" setMarkerPos _varValue;
				petros setPos _varvalue;
				[] spawn buildHQ;
				};
			if(_varname == 'estaticas') exitWith
				{
				for "_i" from 0 to (count _varvalue) - 1 do
					{
					_tipoVeh = _varvalue select _i select 0;
					_posVeh = _varvalue select _i select 1;
					_dirVeh = _varvalue select _i select 2;

					_veh = _tipoVeh createVehicle _posVeh;
					_veh setDir _dirVeh;
					if (_tipoVeh in (allStatMGs + allStatATs + allStatAAs + allStatMortars)) then {
						staticsToSave pushBack _veh;
					};
					[_veh] spawn VEHinit;
					};
				};
			if(_varname == 'tasks') exitWith
				{
				{
				if (_x == "AtaqueAAF") then
					{
					[] call ataqueAAF;
					}
				else
					{
					if (_x == "DEF_HQ") then
						{
						[] spawn ataqueHQ;
						}
					else
						{
						[_x,true] call missionRequest;
						};
					};
				} forEach _varvalue;
				};
		};
	}
	else
	{
		call compile format ["%1 = %2",_varName,_varValue];
	};
	
	if (_varName in AS_publicVariables) then {
		publicVariable _varName;
	};
};

//==================================================================================================================================================================================================
saveFuncsLoaded = true;