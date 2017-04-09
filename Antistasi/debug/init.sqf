if (!isServer) exitWith {};
AS_DEBUG_markers = false;

AS_DEBUG_init = {
    params [["_on", false]];

    // turn debug on
    if (!AS_DEBUG_markers and _on) then {
        AS_DEBUG_markers = _on;
        diag_log "[AS] Server: debug mode enabled.";
        hint "AS debug mode enabled.";
        AS_DEBUG_markers_all = [];

        {
            [_x] call AS_DEBUG_initVehicle;
        } forEach vehicles;

        {
            if (side _x in [side_green,side_red,side_blue,civilian]) then {
                [_x] call AS_DEBUG_initUnit;
            };
        } forEach allUnits;

        {
            [_x] call AS_DEBUG_initDead;
        } forEach allDead;
    };

    // turn debug off
    if (AS_DEBUG_markers and !_on) then {
        AS_DEBUG_markers = _on;  // this kills all markers
        AS_DEBUG_markers_all = nil;
        diag_log "[AS] Server: debug mode disabled.";
        hint "AS debug mode disabled.";
    };
};


AS_DEBUG_initUnit = {
    params ["_unit"];
    if (isNil "AS_DEBUG_markers_all") exitWith {};

    private _mrk = createMarker [format ["AS_DEBUG_markers_%1", count AS_DEBUG_markers_all], position _unit];
    AS_DEBUG_markers_all pushBack _mrk;

    private _color = "ColorUNKNOWN";
    private _type = "c_unknown";
    switch (side _unit) do {
		case side_green: {
			_color = "ColorGUER";
            _type = "n_inf";
		};
		case side_red: {
			_color = "ColorOPFOR";
            _type = "o_inf";
		};
		case side_blue: {
			_color = "ColorWEST";
            _type = "b_inf";
        };
        case civilian: {
            _color = "ColorCIV";
            _type = "c_unknown";
        }
	};
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType _type;
    _mrk setMarkerColor _color;
    _mrk setMarkerText (typeOf _unit);

    [_unit, _mrk] spawn {
        params ["_unit", "_mrk"];
        private _sleep = 2 + 2*(random 100)/100; // so it is not called at the same time to a whole group
        while {AS_DEBUG_markers and alive _unit} do {
            _mrk setMarkerPos position _unit;
            sleep _sleep;
        };
        deleteMarker _mrk;
    };
};

AS_DEBUG_initVehicle = {
    params ["_veh"];
    if (isNil "AS_DEBUG_markers_all") exitWith {};

    private _mrk = createMarker [format ["AS_DEBUG_markers_%1", count AS_DEBUG_markers_all], position _veh];
    AS_DEBUG_markers_all pushBack _mrk;

    private _color = "ColorUNKNOWN";
    private _type = "c_unknown";
    switch (side _veh) do {
		case side_green: {
			_color = "ColorGUER";
            _type = "n_unknown";
		};
		case side_red: {
			_color = "ColorOPFOR";
            _type = "o_unknown";
		};
		case side_blue: {
			_color = "ColorWEST";
            _type = "b_unknown";
        };
        case civilian: {
            _color = "ColorCIV";
            _type = "c_unknown";
        }
	};
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType _type;
    _mrk setMarkerColor _color;
    _mrk setMarkerText (typeOf _veh);

    [_veh, _mrk] spawn {
        params ["_veh", "_mrk"];
        private _sleep = 2 + 2*(random 100)/100; // so it is not called at the same time to a whole group
        while {AS_DEBUG_markers and alive _veh} do {
            _mrk setMarkerPos position _veh;
            sleep _sleep;
        };
        deleteMarker _mrk;
    };
};


AS_DEBUG_initDead = {
    params ["_thing"];
    if (isNil "AS_DEBUG_markers_all") exitWith {};

    private _mrk = createMarker [format ["AS_DEBUG_markers_%1", count AS_DEBUG_markers_all], position _thing];
    AS_DEBUG_markers_all pushBack _mrk;
    _mrk setMarkerShape "ICON";
    _mrk setMarkerType "KIA";
    _mrk setMarkerColor "ColorRed";

    [_thing, _mrk] spawn {
        params ["_thing", "_mrk"];
        private _sleep = 2 + 2*(random 100)/100;
        while {AS_DEBUG_markers and _thing != objNull} do {
            sleep _sleep;
        };
        deleteMarker _mrk;
    };
};
