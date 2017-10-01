// converts the outcome values into a formatted description
params [["_commander_score", 0],
        ["_players_score", 0],
        ["_prestige", [0, 0]],
        ["_resourcesFIA", [0, 0]],
        ["_citySupport", [0, 0, []]],
        ["_changeAAFattack", 0],
        ["_custom", []],
        ["_increaseBusy", ["", 0]]
];
private _description = [];

if not (_commander_score == 0) then {
    _description pushBack (format ["Commander's score: %1", _commander_score]);
};
if not (_players_score IsEqualTo 0) then {
    _description pushBack (format ["Players's score: %1", _players_score select 2]);
};
if not (_prestige IsEqualTo [0, 0]) then {
    if (_prestige select 0 != 0) then {
        _description pushBack (format ["%1 support: %2", AS_NATOname, _prestige select 0]);
    };
    if (_prestige select 1 != 0) then {
        _description pushBack (format ["%1 support: %2", AS_CSATname, _prestige select 1]);
    };
};
if not (_resourcesFIA IsEqualTo [0, 0]) then {
    if (_resourcesFIA select 0 != 0) then {
        _description pushBack (format ["Human resources: %1", _resourcesFIA select 0]);
    };
    if (_resourcesFIA select 1 != 0) then {
        _description pushBack (format ["Money: %1", _resourcesFIA select 1]);
    };
};
if not (_citySupport IsEqualTo [0, 0, []]) then {
    if (_resourcesFIA select 0 != 0) then {
        _description pushBack (format ["AAF city support: %1", _citySupport select 0]);
    };
    if (_resourcesFIA select 1 != 0) then {
        _description pushBack (format ["FIA city support: %1", _citySupport select 1]);
    };
};
if not (_changeAAFattack == 0) then {
    _description pushBack (format ["Disruption in AAF organization: %1", _changeAAFattack/60]);
};
if not (_increaseBusy IsEqualTo ["", 0]) then {
    _description pushBack (format ["Disruption in AAF base: %1", _increaseBusy select 1]);
};
if not (_custom IsEqualTo []) then {
    {_description pushBack (_x select 0)} forEach _custom;
};
if (_description isEqualTo []) exitWith {
    _description pushBack "No relevant information about mission outcome";
};
_description
