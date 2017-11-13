params ["_mission", "_status", ["_description", ""], ["_position", []]];
private _params = [_mission, "task"] call AS_spawn_fnc_get;

private _settings = _params select 1;
if (_description != "") then {
    _settings set [1, _description];
};
if (count _position == 0) then {
    _position = _params select 2;
};

[_params select 0,[side_blue,civilian],
 _settings,
 _position,
 _status, 5,true,true,
 _params select 3]
