disableSerialization;
params ["_side"];
private _other_side = ["west", "east"] select (_side == "west");

private _control_ids = [0, 1, 2, 3];
private _roles = ["anti_state", "pro_anti_state", "state", "pro_state"];

{
    private _control_list = (findDisplay 1601) displayCtrl _x;
    lbCLear _control_list;

    private _role = _roles select _forEachIndex;
    private _valid_side = [_other_side, _side] select (_x in [0, 1]);
    {
        private _faction_side = AS_entities getVariable _x getVariable "side";
        private _faction_roles = AS_entities getVariable _x getVariable "roles";
        if (_role in _faction_roles and _faction_side == _valid_side) then {
            _control_list lbAdd (AS_entities getVariable _x getVariable "name");
            _control_list lbSetData [lbSize _control_list - 1, _side + _x];
        };
    } forEach allVariables AS_entities;

    _control_list lbSetCurSel 0;
} forEach _control_ids;
