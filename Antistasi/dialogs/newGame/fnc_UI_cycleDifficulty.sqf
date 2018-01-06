disableSerialization;

private _control = (findDisplay 1601) displayCtrl 4;

private _bla = ctrlText _control;

private _valid_difficulties = ["normal", "easy"];

private _index = _valid_difficulties find _bla;
// if not found, index == -1, which fine

if (_index == count _valid_difficulties - 1) then {
    _index = -1;
};
_index = _index + 1;

_control ctrlSetText (_valid_difficulties select _index);
