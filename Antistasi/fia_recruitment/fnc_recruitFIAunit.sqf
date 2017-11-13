#include "../macros.hpp"
AS_SERVER_ONLY("fnc_recruitFIAunit");
params ["_player", "_type"];

if (AS_P("hr") < 1) exitWith {
    [_player, "hint", "You do not have enough HR for this request"] remoteExec ["AS_fnc_localCommunication", _player];
};

private _cost = AS_data_allCosts getVariable _type;
private _moneyAvailable = AS_P("resourcesFIA");
if isMultiPlayer then {
    _moneyAvailable = _player getVariable "money";
};

if (_cost > _moneyAvailable) exitWith {
    [_player, "hint", "You do not have enough money for this kind of unit"] remoteExec ["AS_fnc_localCommunication", _player];
};

private _equipment = [_type] call AS_fnc_getBestEquipment;

_equipment params ["_vest", "_helmet", "_googles", "_backpack", "_primaryWeapon", "_primaryMags", "_secondaryWeapon", "_secondaryMags", "_scope", "_uniformItems", "_backpackItems", "_primaryWeaponItems"];

if (_type == "Sniper" and (_primaryWeapon == "" or ([_primaryMags] call AS_fnc_getTotalCargo) < 6 or _scope == "")) exitWith {
    [_player, "hint", "No snipers, ammo or scopes to equip a sniper."] remoteExec ["AS_fnc_localCommunication", _player];
};
if (_type == "Grenadier" and _primaryWeapon == "") exitWith {
    // todo: check existence of enough grenades.
    [_player, "hint", "No grenade launchers or ammo to equip a grenadier."] remoteExec ["AS_fnc_localCommunication", _player];
};
if (_type in ["AA Specialist", "AT Specialist"] and _secondaryWeapon == "") exitWith {
    // todo: check existence of enough rockets
    // todo: check existence of AA/AT launchers
    [_player, "hint", "No launchers."] remoteExec ["AS_fnc_localCommunication", _player];
};

if not isMultiPlayer then {
    [-1, -_cost] call AS_fnc_changeFIAmoney;
} else {
    [-1, 0] call AS_fnc_changeFIAmoney;
    [_player, -_cost] call AS_fnc_changePlayerMoney;
    [_player, "hint", "Soldier Recruited.\n\nRemember: if you use the group menu to switch groups you will lose control of your recruited AI"] remoteExec ["AS_fnc_localCommunication", _player];
};
[petros, "directSay", "SentGenReinforcementsArrived"] remoteExec ["AS_fnc_localCommunication", _player];

// the unit becomes owned by the client because the group is owned by the client
private _unit = group _player createUnit [[_type] call AS_fnc_getFIAUnitClass, position _player, [], 0, "NONE"];

// we want all unit logic (e.g. medical) to be run by the client, not the server.
[_unit, true, nil, _equipment] remoteExec ["AS_fnc_initUnitFIA", _player];
[_unit, "AUTOCOMBAT"] remoteExec ["disableAI", _player];
