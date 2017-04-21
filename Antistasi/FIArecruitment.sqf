// The data used here is published by the server in "initFIA.sqf"

// unit class -> unit type
AS_fnc_getFIAUnitNameType = {
    params ["_name"];

    private _index = AS_FIAsoldiersMapping find _name;
    private _class = "Rifleman";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: unit class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
    } else {
        _class = AS_FIAsoldiersMapping select (_index + 1);
    };
    _class
};

// unit -> unit type
AS_fnc_getFIAUnitType = {
    params ["_unit"];
    [typeOf _unit] call AS_fnc_getFIAUnitNameType
};

// unit type -> unit class
AS_fnc_getFIAUnitClass = {
    params ["_type"];
    private _index = AS_FIAsoldiersMapping find _type;
    private _class = "B_G_Soldier_F";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: unit type '%1' is not in the templates/FIA.sqf. Using unit class '%2'.",_type,_class];
    } else {
        _class = AS_FIAsoldiersMapping select (_index - 1);
    };
    _class
};

// squad class -> squad type
AS_fnc_getFIASquadNameType = {
    params ["_name"];

    private _index = AS_FIAsquadsMapping find _name;
    private _class = "Infantry Squad";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: squad class '%1' is not in the templates/FIA.sqf. Using type '%2'.",_name,_class];
    } else {
        _class = AS_FIAsquadsMapping select (_index + 1);
    };
    _class
};

// squad type -> squad class
AS_fnc_getFIASquadClass = {
    params ["_type"];
    private _index = AS_FIAsquadsMapping find _type;
    private _class = "IRG_InfSquad";
    if (_index == -1) then {
        diag_log format ["[AS] ERROR: squad type '%1' is not in the templates/FIA.sqf. Using class '%2'.",_type,_class];
    } else {
        _class = AS_FIAsquadsMapping select (_index - 1);
    };
    _class
};

// squad type -> squad config (needed for BIS_Fnc_spawnGroup)
AS_fnc_getFIASquadConfig = {
    params ["_type"];
    configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> ([_type] call AS_fnc_getFIASquadClass)
};

// Returns [cost,HR] of the squad type.
AS_fnc_getFIASquadCost = {
    params ["_type"];
    private _config = [_type] call AS_fnc_getFIASquadConfig;

    private _cost = 0;
    private _hr = 0;
    for "_i" from 0 to (count _config) - 1 do {
    	_item = _config select _i;
    	if (isClass _item) then {
            private _unitName = [getText(_item >> "vehicle")] call AS_fnc_getFIAUnitNameType;
            _coste = _coste + (AS_data_allCosts getVariable _unitName);
            _hr = _hr + 1;
    	};
    };
    [_cost, _hr]
};
