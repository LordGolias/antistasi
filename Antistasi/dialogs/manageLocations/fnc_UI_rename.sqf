private _position = _this;
private _location = _position call AS_location_nearest;
private _type = _location call AS_location_fnc_type;

if (_position distance (_location call AS_location_fnc_position) > 100 or
    _location call AS_location_fnc_side != "FIA") exitWith {
    hint "No FIA camp selected";
};
if !(_type != "camp") exitWith {
    hint "Only camps can be renamed";
};

private _oldName = [_location,"name"] call AS_location_fnc_get;
((findDisplay 1602) displayCtrl 1) ctrlSetText _oldName;

createDialog "AS_manageLocations_rename";
waitUntil {dialog};
waitUntil {!dialog};

private _newName = ctrlText ((findDisplay 1602) displayCtrl 1);

if (_newName != _oldName) then {
    [_location, _newName] remoteExec ["AS_fnc_renameFIAcamp", 2];
    hint format ["Camp renamed to '%1'", _newName];
};
