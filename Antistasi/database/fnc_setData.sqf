/*
 * Writes save data to the database.
 *
 * Arguments:
 * 0: Save name <STRING>
 * 1: Save data <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["mySave", call AS_database_fnc_serialize] call AS_database_fnc_setData;
 *
 */
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_setData");
params ["_name", "_data"];

// Write save data to the database
private _saves = profileNamespace getVariable ["AS_v2_SAVES", []];
_saves pushBackUnique [_name, _data];
profileNamespace setVariable ["AS_v2_SAVES", _saves];
saveProfileNamespace;

// Update list of available saves
private _availableSaves = AS_S("availableSaves");
_availableSaves pushBackUnique _name;
AS_Sset("availableSaves", _availableSaves);
