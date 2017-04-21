// select a group from a collection of groups
fnc_pickGroup = {
	params ["_groupType", "_affiliation"];

	private _failureText = "";
	private _returnGroup = "";
	private _cfgPath = "";

	switch (_affiliation) do {
		case side_green: {
			_cfgPath = AAFConfigGroupInf;
		};
		case side_red: {
			_cfgPath = opCfgInf;
		};
		case side_blue: {
			_cfgPath = NATOConfigGroupInf;
		};
		default {
			_failureText = format ["incorrect affiliation. Group type: %1; affiliation: %2", _groupType, _affiliation];
		};
	};

	_fnc_pickGroupSingle = {
		params ["_input"];
		private _output = "";

		// array of units
		if (typeName _input == "ARRAY") then {
			_output = _input;
		}
		else {
			if (typeName _input == "STRING") then {
				// group name without config path
				if (isClass (_cfgPath >> _input)) then {
					_output = (_cfgPath >> _input);
				};
			}
			else {
				// group name with config paths
				if (isClass _input) then {
					_output = _input;
				};
			};
		};
		_output
	};

	if (typeName _groupType == "ARRAY") then {
		private _randomGroup = selectRandom _groupType;

		if (typeName _randomGroup == "STRING") then {
			// array of soldiers
			if !(isClass (_cfgPath >> _randomGroup)) then {
				_returnGroup = _groupType;
			}
			else {
				_returnGroup = [_randomGroup] call _fnc_pickGroupSingle;
			};
		}
		else {
			_returnGroup = [_randomGroup] call _fnc_pickGroupSingle;
		};
	}
	else {
		if (typeName _groupType == "STRING") then {
			// group name without config path
			if (isClass (_cfgPath >> _groupType)) then {
				_returnGroup = (_cfgPath >> _groupType);
			}
			else {
				_failureText = format ["incorrect group type. Group type: %1; affiliation: %2", _groupType, _affiliation];
			};
		}
		else {
			// group name with config path
			if (isClass _groupType) then {
				_returnGroup = _groupType;
			};
		};
	};
	if !(_failureText == "") exitWith {
		diag_log ("[AS] ERROR (fnc_pickGroup) " + _failureText);
	};
	_returnGroup
};

// give the commander the ability to move all statics
fnc_addMoveObjAction = {
	private _objs = [];
	{
    	if ((  str typeof _x find "Land_Camping_Light_F" > -1
    	    or str typeof _x find "Land_BagFence_Round_F" > -1
        	or str typeof _x find "CamoNet_BLUFOR_open_F" > -1))
		then {
        	_objs pushBack _x;
   		};
	} forEach nearestObjects [getPos fuego, [], 60];
	{
		removeAllActions _x;
		_x addAction [localize "STR_act_moveAsset", "moveObject.sqf","static",0,false,true,"","(_this == AS_commander)", 5];
	} forEach staticsToSave + _objs;
};

// (un-)lock a vehicle
fnc_lockVehicle = {
	params ["_veh", "_lock"];

	if (_lock) then {
		_veh lock 2;
	};
	if !(_lock) then {
		_veh lock 0;
	};
};

// short invulnerability + repair for spawned vehicle, to counteract imprecise spawn positions
fnc_protectVehicle = {
	params ["_vehicles"];

	{
		_x allowDamage false;
		_x setDamage 0;
	} forEach _vehicles;

	sleep 5;

	{
		_x allowDamage true;
	} forEach _vehicles;
};

fnc_updateProgressBar = {
	params [["_type", "Rank"], ["_parameters", [], []]];
	private ["_colour", "_PBar", "_p", "_varName", "_value"];

	_p = [];
	_varName = "";
	_PBar = "";

	_colour = "#1DA81D";
	_colourDef = "#C1C0BB";

	if (_type == "Rank") then {
		private ["_current", "_rankData", "_multiplier", "_needed", "_nextRank"];

		if (player getVariable ["rango","PRIVATE"] == "COLONEL") exitWith {player setVariable ["Rank_PBar", "COLONEL", true]};
		_current = player getVariable ["score",0];
		_rankData = [player] call numericRank;
		_multiplier = _rankData select 0;
		_needed = 50*_multiplier;
		_nextRank = _rankData select 2;

		_value = (_current / _needed) max 0;
		_p = [_colour, _colourDef, player getVariable ["rango","PRIVATE"], _nextRank, _type];
		_varName = "Rank_PBar";
	};

	if (count _parameters > 0) then {
		_p = _parameters select 0;
		_value = _parameters select 1;
		_varName = _parameters select 2;
	};

	call {
		if (_value > 0.80) exitWith {
			_PBar = format (["%5: %3 (<t color='%1'>>>>></t><t color='%2'></t>%4)"] + _p);
		};
		if (_value > 0.60) exitWith {
			_PBar = format (["%5: %3 (<t color='%1'>>>></t><t color='%2'>></t>%4)"] + _p);
		};
		if (_value > 0.40) exitWith {
			_PBar = format (["%5: %3 (<t color='%1'>>></t><t color='%2'>>></t>%4)"] + _p);
		};
		if (_value > 0.20) exitWith {
			_PBar = format (["%5: %3 (<t color='%1'>></t><t color='%2'>>>></t>%4)"] + _p);
		};
		if (_value <= 0.20) exitWith {
			_PBar = format (["%5: %3 (<t color='%2'>>>>></t>%4)"] + _p);
		};
	};

	if (_type == "Rank") exitWith {
		player setVariable [_varName, _PBar, true];
	};

	if (_type == "Army XP") exitWith {
		server setVariable [_varName, _PBar, true];
	};
};

fnc_resetSkills = {
	sleep 2;
	player setCustomAimCoef 1;
	player setUnitRecoilCoefficient 1;
};

fnc_loadTFARsettings = {
	params ["_unit"];
	private _settings = [];
	private _text = "";

	sleep 3;

	_settings = _unit getVariable ["AS_TFAR_Settings_SW", []];
	if (count _settings > 0) then {
		[((_unit call TFAR_fnc_radiosList) select 0), _settings] call TFAR_fnc_setSwSettings;
		_text = "TFAR SR Radio Settings Loaded";
	};

	_settings = _unit getVariable ["AS_TFAR_Settings_LR", []];
	if (count _settings > 0) then {
		if (count (_unit call TFAR_fnc_backpackLR) > 0) then {
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, _settings] call TFAR_fnc_setLrSettings;
			_text = format ["TFAR LR Radio Settings Loaded.\n%1", _text];
		};
	};

	hint _text;
};

fnc_saveTFARsettings = {
	params ["_unit"];
	private _settings = [];
	private _text = "";
	if (count (_unit call TFAR_fnc_radiosList) > 0) then {
		_settings = ((_unit call TFAR_fnc_radiosList) select 0) call TFAR_fnc_getSwSettings;
		_unit setVariable ["AS_TFAR_Settings_SW", _settings, true];
		_text = "TFAR SR Radio Settings Saved";
	};

	if (count (_unit call TFAR_fnc_backpackLR) > 0) then {
		_settings = (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings;
		_unit setVariable ["AS_TFAR_Settings_LR", _settings, true];
		_text = format ["TFAR LR Radio Settings Saved.\n%1", _text];
	};

	hint _text;
};

AS_fnc_callServerAndWait = {
	params ["_functionName", "_params"];
	AS_sharedvariable = nil;
	// ask the server to run a function and store the result in "AS_sharedvariable".
	[[_functionName, _params], {
		params ["_functionName", "_params"];
		AS_sharedvariable = _params call _functionName;
		publicVariable "AS_sharedvariable";
	}] remoteExec ["call", 2];
	waitUntil {!isNil "AS_savedGames"};  // wait for server to populate
	private _result = +AS_sharedvariable;
	AS_sharedvariable = nil;  // delete in the end
	_result
};
