/*
 * Retrieves save data from the database
 *
 * Arguments:
 * 0: Save name <STRING>
 *
 * Return Value:
 * Save data <STRING> if present, nil otherwise
 *
 * Example:
 * ["mySave"] call AS_database_fnc_getData;
 *
 */
#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_getData");
params ["_name"];

// Get save data from profileNamespace
private _saves = profileNamespace getVariable ["AS_v2_SAVES", []];
private _data = nil;
{
    _x params ["_saveName", "_saveData"];
    if (_saveName == _name) then {
        _data = _saveData;
    };
} forEach _saves;

_data;
