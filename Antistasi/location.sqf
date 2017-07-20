// Returns all properties of a given type.
AS_fnc_location_properties = {
    // one parameter, the location type
    private _properties = ["type", "position", "size", "side", "garrison",
                           "spawned", "forced_spawned"];
    switch (_this) do {
		case "city": {
			_properties append ["population","FIAsupport","AAFsupport","roads"];
            _properties = _properties - ["side"];
		};
        case "base": {
			_properties append ["busy"];
		};
        case "airfield": {
			_properties append ["busy"];
		};
        case "camp": {  // the camp has a name
			_properties append ["name"];
		};
        case "minefield": {
			_properties append ["mines", "found"];  // [type, pos, dir]
            _properties = _properties - ["garrison"];
		};
        default {
            []
        };
    };
    _properties
};

// Returns all properties of a given type that are saved.
AS_fnc_location_saved_properties = {
    private _properties = _this call AS_fnc_location_properties;
    _properties - ["spawned", "forced_spawned"]
};

// Whether the location exists or not. Used in conjunction with *_add and *_remove
AS_fnc_location_exists = {
    _this in (AS_location getVariable "all")
};

////////////////////////////////// Getters //////////////////////////////////
// I.e. to get properties of locations

AS_fnc_location_get = {
    params ["_location", "_property"];
    if !(_location in (AS_location getVariable "all")) exitWith {
        diag_log format ["[AS] Error: location_set wrong location '%1'", _location];
    };
    // We use `AS_location getVariable` because `AS_fnc_location_type` uses
    // this function and using it here would cause an infinite loop.
    if !(_property in ((AS_location getVariable (_location + "_type")) call AS_fnc_location_properties)) exitWith {
        diag_log format ["[AS] Error: location_set wrong property '%1' for location '%2'", _property, _location];
    };

    AS_location getVariable (_location + "_" + _property)
};

AS_fnc_location_type = {
    [_this,"type"] call AS_fnc_location_get
};

AS_fnc_location_size = {
    [_this,"size"] call AS_fnc_location_get
};

AS_fnc_location_garrison = {
    [_this,"garrison"] call AS_fnc_location_get
};

AS_fnc_location_position = {
    [_this,"position"] call AS_fnc_location_get
};

AS_fnc_location_busy = {
    (dateToNumber date) < ([_this,"busy"] call AS_fnc_location_get)
};

AS_fnc_location_spawned = {
    if !(_this call AS_fnc_location_exists) exitWith {false};
    [_this,"spawned"] call AS_fnc_location_get
};

AS_fnc_location_forced_spawned = {
    if !(_this call AS_fnc_location_exists) exitWith {false};
    [_this,"forced_spawned"] call AS_fnc_location_get
};

AS_fnc_location_side = {
    params ["_location"];
    private _type = _location call AS_fnc_location_type;
    if (_type != "city") exitWith {
        [_location, "side"] call AS_fnc_location_get
    };
    private _FIAsupport = [_this,"FIAsupport"] call AS_fnc_location_get;
    private _AAFsupport = [_this,"AAFsupport"] call AS_fnc_location_get;
    if (_AAFsupport >= _FIAsupport) then {
        "AAF"
    } else {
        "FIA"
    };
};

////////////////////////////////// Iterators ////////////////////////////////
// I.e. return list of locations that match certain criteria

// All locations
AS_fnc_location_all = {AS_location getVariable "all"};

AS_fnc_location_nearest = {
    [AS_location getVariable "all", _this] call BIS_Fnc_nearestPosition
};

// returns all locations of a given side
AS_fnc_location_S = {
    if (_this isEqualType []) exitWith {
        (AS_location getVariable "all") select {(_x call AS_fnc_location_side) in _this}
    };
    (AS_location getVariable "all") select {_x call AS_fnc_location_side == _this}
};

// returns all locations of a given type
AS_fnc_location_T = {
    if (_this isEqualType []) exitWith {
        (AS_location getVariable "all") select {(_x call AS_fnc_location_type) in _this}
    };
    (AS_location getVariable "all") select {_x call AS_fnc_location_type == _this}
};

// returns all locations of a given type and side
AS_fnc_location_TS = {
    params ["_type", "_side"];

    if (_type isEqualType []) exitWith {
        (AS_location getVariable "all") select {
            _x call AS_fnc_location_side == _side and
            (_x call AS_fnc_location_type) in _type}
    };

    (AS_location getVariable "all") select {
        _x call AS_fnc_location_side == _side and
        _x call AS_fnc_location_type == _type}
};

// All cities
AS_fnc_location_cities = {
    (AS_location getVariable "all") select {_x call AS_fnc_location_type == "city"}
};

/////////////////////////////////////////////////////////////////////////
///////// BELOW THIS POINT ARE FUNCTIONS THAT CHANGE THE STATE //////////
/////////////////////////////////////////////////////////////////////////

// adds a location. The first argument must be a marker. The location
// taks ownership of it. Every location requires a different marker.
AS_fnc_location_add = {
    params ["_marker", "_type"];
    private _locations = call AS_fnc_location_all;

    if (_marker in _locations) exitWith {
        diag_log format ["[AS] Error: location '%1' added but already exists. Called with type '%2'", _marker, _type];
    };

    AS_location setVariable [_marker + "_position", getMarkerPos _marker, true];
    AS_location setVariable [_marker + "_size", ((getMarkerSize _marker) select 0) max
                                                ((getMarkerSize _marker) select 1), true];
    AS_location setVariable [_marker + "_type", _type, true];
    _marker setMarkerAlpha 0;

    _locations pushBack _marker;
    AS_location setVariable ["all", _locations, true];
    _marker call AS_fnc_location_init;
};

// initializes the location's required properties.
AS_fnc_location_init = {

    switch (_this call AS_fnc_location_type) do {
        case "city": {
            [_this,"AAFsupport",50] call AS_fnc_location_set;
            [_this,"FIAsupport",0] call AS_fnc_location_set;
        };
        case "fia_hq": {
            [_this,"side","FIA"] call AS_fnc_location_set;
        };
        case "base": {
            [_this,"side","AAF"] call AS_fnc_location_set;
            [_this,"busy",dateToNumber date] call AS_fnc_location_set;
        };
        case "airfield": {
            [_this,"side","AAF"] call AS_fnc_location_set;
            [_this,"busy",dateToNumber date] call AS_fnc_location_set;
        };
        case "minefield": {
            [_this, "mines", []] call AS_fnc_location_set;  // [type, pos, dir]
            [_this, "found", false] call AS_fnc_location_set;
        };
        default {
            [_this,"side","AAF"] call AS_fnc_location_set;
        };
    };
    if ("garrison" in ((_this call AS_fnc_location_type) call AS_fnc_location_properties)) then {
        [_this,"garrison",[]] call AS_fnc_location_set;
    };
    [_this,"spawned",false] call AS_fnc_location_set;
    [_this,"forced_spawned",false] call AS_fnc_location_set;
};

// This obliterates everything related with that location including the markers
AS_fnc_location_delete = {
    private _location = _this;
    private _all = AS_location getVariable "all";
    if !(_location in _all) exitWith {
        diag_log format ["[AS] Error: location '%1' called for removal but it does not exist.", _location];
    };

    // its properties
    {
        AS_location setVariable [_location + "_" + _x, nil, true];
    } forEach (call AS_fnc_location_properties);

    // from the list
    AS_location setVariable ["all", _all - [_location], true];

    // the hidden marker
    deleteMarker _location;

    // the shown marker
    deleteMarker (format ["Dum%1", _location]);
};

// Sets a property
AS_fnc_location_set = {
    params ["_location", "_property", "_value"];
    if !(_location in (AS_location getVariable "all")) exitWith {
        diag_log format ["[AS] Error: location_set with wrong location '%1' for property '%2'", _location, _property];
    };
    if !(_property in ((_location call AS_fnc_location_type) call AS_fnc_location_properties)) exitWith {
        diag_log format ["[AS] Error: location_set with wrong property '%1' for location '%2'", _property, _location];
    };

    AS_location setVariable [_location + "_" + _property, _value, true];
    if (_property == "position") then {
        _location setMarkerPos _value;
    };
};

// Increases the time the location is busy.
// Location needs to be a base or airport
AS_fnc_location_increaseBusy = {
    params ["_location", "_minutes"];
    private _busy = [_location,"busy"] call AS_fnc_location_get;
    if (_busy < dateToNumber date) then {_busy = dateToNumber date};

    private _busy = numberToDate [2035,_busy];
    _busy set [4, (_busy select 4) + _minutes];

    [_location,"busy",dateToNumber _busy] call AS_fnc_location_set;
};

// Spawns a location
// use `_location` to normal spawn,
// use `[_location, true]` to forced spawn
AS_fnc_location_spawn = {
    private _location = _this;
    private _forced = false;
    if (_this isEqualType []) then {
        _location = _this select 0;
        _forced = _this select 1;
    };
    if (_forced) then {
        [_location,"forced_spawned",true] call AS_fnc_location_set;
    } else {
        [_location,"spawned",true] call AS_fnc_location_set;
    };
};

// despawns a location
// use `_location` to normal despawn,
// use `[_location, true]` to forced despawn
AS_fnc_location_despawn = {
    private _location = _this;
    private _forced = false;
    if (_this isEqualType []) then {
        _location = _this select 0;
        _forced = _this select 1;
    };

    if !(_location in (AS_location getVariable "all")) exitWith {
        diag_log format ["[AS] Error: location '%1' called for spawn but it does not exist.", _location];
    };
    if (_forced) then {
        [_location,"forced_spawned",false] call AS_fnc_location_set;
    } else {
        [_location,"spawned",false] call AS_fnc_location_set;
    };
};

/////////// Three functions below are currently not used, but will be ///////////

// Creates roadblocks for AAF.
AS_fnc_location_createRoadblocks = {
    {
        _x call AS_fnc_location_addRoadblocks;
    } forEach ([["powerplant", "base", "airfield", "resource", "factory",
                 "seaport", "outpost"], "AAF"] call AS_fnc_location_TS);
};

// called during initialization
AS_fnc_location_addRoadblocks = {
    private _position = _this call AS_fnc_location_position;
    private _count = 0;
    {
    	private _otherPosition = _x call AS_fnc_location_position;
    	if (_otherPosition distance _position < 1000) then {
    		_count = _count + 1;
    	};
    } forEach ((AS_location getVariable "all") select {_x call AS_fnc_location_type == "roadblock"});

    if (_count > 3) exitWith {};

    // iterates randomly through all roads within 500m to add roadblocks
    // adds a roadblock to a road when it:
    // 	- is between [400,500] meters
    // 	- has no roadblocks within 1000 meters
    // 	- has two connected roads
    // it stops when there are 3 roadblocks
    private _roads = _position nearRoads 500;
    while {count _roads > 0} do {
    	private _road = selectRandom _roads;
    	_roads = _roads - [_road];

    	private _posroad = getPos _road;
    	if (_count == 3) exitWith {};

    	if (_posroad distance _position > 400) then {
            private _roadsCon = roadsConnectedto _road;
            if (count _roadsCon > 1) then {
            	private _otherLocation = [control_points, _posroad] call BIS_fnc_nearestPosition;
                private _otherPosition = _otherLocation call AS_fnc_location_position;
            	if (_otherPosition distance _posroad > 1000) then {

    				_posroad call AS_fnc_location_createRoadblock;
                    _count = _count + 1;
    			};
    		};
    	};
    } forEach _roads;
};

AS_fnc_location_createRoadblock = {
    // _this is a position with 3 coordinates. We use x and y to get a unique name.
    private _name = format ["roadblock_%1_%2", round (_this select 0), round (_this select 1)];
    private _marker = createMarker [_name, _this];
    [_marker, "roadblock1"] call AS_fnc_location_add;
    [_marker,"side","AAF"] call AS_fnc_location_set;
};


// Add cities from CfgWorld. Paramaters:
// - _excludeBelow: meters below which the city is ignored
// - _minSize: every city has at least this size by expanding it.
// - _excluded: list of city names to exclude
AS_fnc_location_addCities = {
    params ["_excludeBelow", "_minSize", ["_excluded", []]];
    {
        private _city = text _x;
        private _position = getPos _x;
        private _size = [_city, _minSize] call AS_fnc_location_getNameSize;
        if (_city != "" and !(_city in _excluded) and _size >= _excludeBelow) then {
            // get all roads
            private _roads = [];
            {
                private _roadcon = roadsConnectedto _x;
                if (count _roadcon == 2) then {
                    _roads pushBack _x;
                };
            } forEach (_position nearRoads _size);

            // get population
            private _population = (count (nearestObjects [_position, ["house"], _size]));

            // adjust position to be in a road
            private _sortedRoads = [_roads, [], {_position distance _x}, "ASCEND"] call BIS_fnc_sortBy;
            _position = getPos (_sortedRoads select 0);

            // creates hidden marker
            private _mrk = createmarker [_city, _position];
            _mrk setMarkerSize [_size, _size];
            _mrk setMarkerShape "ELLIPSE";
            _mrk setMarkerBrush "SOLID";
            _mrk setMarkerColor "ColorGUER";
            [_mrk, "city"] call AS_fnc_location_add;

            // stores everything
            AS_location setVariable [_city + "_population", _population, true];
            AS_location setVariable [_city + "_roads", _roads, true];
        };
    } forEach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"),
        ["NameCityCapital","NameCity","NameVillage","CityCenter"], 25000]);
};

// Initializes hills from CfgWorlds.
AS_fnc_location_addHills = {
    params ["_minSize", ["_excluded", []], ["_hills", []]];
    {
        private _hill = text _x;
        private _position = getPos _x;
        private _size = [_hill, _minSize] call AS_fnc_location_getNameSize;
        if !(_hill == "" or (_hill in _excluded)) then {
            // creates hidden marker
            private _mrk = createmarker [_hill, _position];
            _mrk setMarkerSize [_size, _size];
            _mrk setMarkerShape "ELLIPSE";
            _mrk setMarkerBrush "SOLID";
            _mrk setMarkerColor "ColorRed";
            if (_hill in _hills) then {
                [_mrk, "hill"] call AS_fnc_location_add;
            } else {
                [_mrk, "hillAA"] call AS_fnc_location_add;
            };
        };
    } foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"),
        ["Hill"], 25000]);
};

// Creates all shown markers in the map.
AS_fnc_location_updateMarkers = {
    {
        _x call AS_fnc_location_updateMarker;
    } forEach (AS_location getVariable "all");
};

// Updates all public markers, creating new ones if needed.
AS_fnc_location_updateMarker = {
    private _location = _this;
    private _type = (_location call AS_fnc_location_type);
    private _position = (_location call AS_fnc_location_position);
    private _side = (_location call AS_fnc_location_side);

    private _mrkName = format ["Dum%1", _location];
    private _markerType = "";
    private _locationName = "";
    switch (_type) do {
        case "fia_hq": {_markerType = "hd_flag"; _locationName = "FIA HQ"};
        case "city": {_markerType = "loc_cross"; _locationName = ""};
        case "powerplant": {_markerType = "loc_power"; _locationName = "Power Plant"};
        case "airfield": {
            _locationName = "Airfield";
            if (_side == "FIA") then {
                _markerType = "flag_NATO";
            } else {
                _markerType = "flag_AAF";
            };
        };
        case "base": {
            _locationName = "Military Base";
            if (_side == "FIA") then {
                _markerType = "flag_NATO";
            } else {
                _markerType = "flag_AAF";
            };
        };
        case "powerplant": {_markerType = "loc_power"; _locationName = "Base"};
        case "resource": {_markerType = "loc_rock"; _locationName = "Resource"};
        case "factory": {_markerType = "u_installation"; _locationName = "Factory"};
        case "outpost": {_markerType = "loc_bunker"; _locationName = "Outpost"};
        case "outpostAA": {_markerType = "loc_bunker"; _locationName = "Outpost AA"};
        case "roadblock": {_markerType = "loc_bunker"; _locationName = "Roadblock"};
        case "watchpost": {_markerType = "loc_bunker"; _locationName = "Watchpost"};
        case "camp": {_markerType = "loc_bunker"; _locationName = ([_location,"name"] call AS_fnc_location_get)};
        case "seaport": {_markerType = "b_naval"; _locationName = "Sea Port"};
        case "hill": {_markerType = "loc_rock"; _locationName = "Hill"};
        case "hillAA": {_markerType = "loc_rock"; _locationName = "Hill"};
        case "minefield": {_markerType = "hd_warning"; _locationName = "Minefield"};
        default {diag_log format ["[AS] Error: location_updateMarker with undefined type '%1'", _type]};
    };

    private _mrk = "";
    // checks if marker exists
    if (getMarkerColor _mrkName == "") then {
        _mrk = createMarker [_mrkName, _position];
        _mrk setMarkerShape "ICON";
    } else {
        _mrk = _mrkName;
    };
    _mrk setMarkerPos _position;
    _mrk setMarkerType _markerType;
    _mrk setMarkerAlpha 1;

    if (_side == "FIA") then {
        if (_type != "minefield") then {
            _mrk setMarkerText format ["%1: %2", _locationName, count (_location call AS_fnc_location_garrison)];
        } else {
            _mrk setMarkerText format ["%1: %2", _locationName, count ([_location,"mines"] call AS_fnc_location_get)];
        };
        _mrk setMarkerColor "ColorBLUFOR";
    };
    if (_side == "NATO") then {
        _mrk setMarkerText ("NATO " + _locationName);
        _mrk setMarkerColor "ColorBLUFOR";
    };
    if (_side == "AAF") then {
        // roadblocks are hidden
        _mrk setMarkerText "";
        if (_type in ["roadblock","hill","hillAA"]) then {
            _mrk setMarkerAlpha 0;
        };
        if (_type == "minefield") then {
            if (!([_location,"found"] call AS_fnc_location_get)) then {
                _mrk setMarkerAlpha 0;
            };
        };
        _mrk setMarkerColor "ColorGUER";
        // AAF does not show names
    };
};

AS_fnc_location_save = {
    params ["_saveName"];
    {
        private _location = _x;
        private _type = (_location call AS_fnc_location_type);
        {
            [_saveName, "LOCATION" + _location + "_" +  _x,
             AS_location getVariable (_location + "_" + _x)] call AS_fnc_saveStat;
        } forEach (_type call AS_fnc_location_saved_properties);
    } forEach (AS_location getVariable "all");
};

AS_fnc_location_load = {
    params ["_saveName"];
    {
        private _location = _x;
        private _type = (_location call AS_fnc_location_type);
        {
            AS_location setVariable [(_location + "_" + _x),
             [_saveName, "LOCATION" + _location + "_" + _x] call AS_fnc_loadStat, true];
        } forEach (_type call AS_fnc_location_saved_properties);

        // create hidden marker if it does not exist.
        if (getMarkerColor _location == "") then {
            private _mrk = createmarker [_location, _location call AS_fnc_location_position];
            _mrk setMarkerSize [_location call AS_fnc_location_size, _location call AS_fnc_location_size];
            _mrk setMarkerShape "ELLIPSE";
            _mrk setMarkerBrush "SOLID";
            _mrk setMarkerColor "ColorGUER";
            _mrk setMarkerAlpha 0;
        } else {
            _location setMarkerPos (_location call AS_fnc_location_position);
        };

    } forEach (AS_location getVariable "all");
};

///////////// Auxiliar functions

AS_fnc_location_getNameSize = {
    params ["_name", "_min"];
    private _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusA");
    private _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusB");
    (_sizeX max _sizeY) max _min
};
