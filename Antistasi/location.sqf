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

// Whether the location exists or not. Used in conjunction with *_add and *_remove
AS_fnc_location_exists = {
    params ["_location"];
    ["location", _location] call AS_fnc_object_exists;
};

////////////////////////////////// Getters //////////////////////////////////
// I.e. to get properties of locations

AS_fnc_location_get = {
    params ["_location", "_property"];
    ["location", _location, _property] call AS_fnc_object_get
};

AS_fnc_location_type = {
    params ["_location"];
    [_location,"type"] call AS_fnc_location_get
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
AS_fnc_locations = {"location" call AS_fnc_objects};

AS_fnc_location_nearest = {
    [call AS_fnc_locations, _this] call BIS_Fnc_nearestPosition
};

// returns all locations of a given side
AS_fnc_location_S = {

    if (_this isEqualType []) exitWith {
        (call AS_fnc_locations) select {(_x call AS_fnc_location_side) in _this}
    };
    (call AS_fnc_locations) select {_x call AS_fnc_location_side == _this}
};

// returns all locations of a given type
AS_fnc_location_T = {
    if (_this isEqualType []) exitWith {
        (call AS_fnc_locations) select {(_x call AS_fnc_location_type) in _this}
    };
    (call AS_fnc_locations) select {_x call AS_fnc_location_type == _this}
};

// returns all locations of a given type and side
AS_fnc_location_TS = {
    params ["_type", "_side"];

    if (_type isEqualType []) exitWith {
        (call AS_fnc_locations) select {_x call AS_fnc_location_side == _side and
         (_x call AS_fnc_location_type) in _type}
    };

    (call AS_fnc_locations) select {_x call AS_fnc_location_side == _side and
     _x call AS_fnc_location_type == _type}
};

// All cities
AS_fnc_location_cities = {
    (call AS_fnc_locations) select {_x call AS_fnc_location_type == "city"}
};

/////////////////////////////////////////////////////////////////////////
///////// BELOW THIS POINT ARE FUNCTIONS THAT CHANGE THE STATE //////////
/////////////////////////////////////////////////////////////////////////


// adds a location. The first argument must be a marker. The location
// taks ownership of it. Every location requires a different marker.
AS_fnc_location_add = {
    params ["_marker", "_type"];
    ["location", _marker, true] call AS_fnc_object_add;
    [_marker, "type", _type, false] call AS_fnc_location_set;
    [_marker, "position", getMarkerPos _marker, false] call AS_fnc_location_set;
    _marker call AS_fnc_location_init;

    [_marker, "size", ((getMarkerSize _marker) select 0) max ((getMarkerSize _marker) select 1), false] call AS_fnc_location_set;
    _marker setMarkerAlpha 0;
    _marker call AS_fnc_location_updateMarker;
};

// initializes the location's required properties.
AS_fnc_location_init = {
    params ["_location"];

    switch (_location call AS_fnc_location_type) do {
        case "city": {
            [_location,"AAFsupport",50, false] call AS_fnc_location_set;
            [_location,"FIAsupport",0, false] call AS_fnc_location_set;
        };
        case "fia_hq": {
            [_location,"side","FIA", false] call AS_fnc_location_set;
        };
        case "base": {
            [_location,"side","AAF", false] call AS_fnc_location_set;
            [_location,"busy",dateToNumber date, false] call AS_fnc_location_set;
        };
        case "airfield": {
            [_location,"side","AAF", false] call AS_fnc_location_set;
            [_location,"busy",dateToNumber date, false] call AS_fnc_location_set;
        };
        case "minefield": {
            [_location, "mines", [], false] call AS_fnc_location_set;  // [type, pos, dir]
            [_location, "found", false, false] call AS_fnc_location_set;
        };
        default {
            [_location,"side","AAF", false] call AS_fnc_location_set;
        };
    };
    if ("garrison" in ((_location call AS_fnc_location_type) call AS_fnc_location_properties)) then {
        [_location,"garrison",[], false] call AS_fnc_location_set;
    };
    [_location,"spawned",false, false] call AS_fnc_location_set;
    [_location,"forced_spawned",false, false] call AS_fnc_location_set;
};

AS_fnc_location_remove = {
    params ["_location"];
    ["location", _location] call AS_fnc_object_remove;

    // the hidden marker
    deleteMarker _location;

    // the shown marker
    deleteMarker (format ["Dum%1", _location]);
};

AS_fnc_location_set = {
    params ["_location", "_property", "_value", ["_update",true]];
    if (_property != "type" and {not (_property in ((_location call AS_fnc_location_type) call AS_fnc_location_properties))}) exitWith {
        diag_log format ["[AS] Error: AS_fnc_location_set: wrong property '%1' for location '%2'", _property, _location];
    };
    ["location", _location, _property, _value] call AS_fnc_object_set;
    if not _update exitWith {};

    if (_property == "position") then {
        _location setMarkerPos _value;
    };
    if (_property in ["position", "side", "garrison"]) then {
        _location call AS_fnc_location_updateMarker;
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
    params ["_location", ["_forced", false]];
    if _forced then {
        [_location,"forced_spawned",true] call AS_fnc_location_set;
    } else {
        [_location,"spawned",true] call AS_fnc_location_set;
    };
};

// despawns a location
// use `_location` to normal despawn,
// use `[_location, true]` to forced despawn
AS_fnc_location_despawn = {
    params ["_location", ["_forced", false]];

    if _forced then {
        [_location,"forced_spawned",false] call AS_fnc_location_set;
    } else {
        [_location,"spawned",false] call AS_fnc_location_set;
    };
};

/////////// Three functions below are currently not used, but will be ///////////

// Creates roadblocks for AAF.
AS_fnc_location_addAllRoadblocks = {
    {
        _x call AS_fnc_location_addRoadblocks;
    } forEach ([["powerplant", "base", "airfield", "resource", "factory",
                 "seaport", "outpost"], "AAF"] call AS_fnc_location_TS);
};

// called during initialization
AS_fnc_location_addRoadblocks = {
    params ["_location", ["_max", 3]];
    private _position = _location call AS_fnc_location_position;

    private _count = 0;
    private _controlPoints = ("roadblock" call AS_fnc_location_T);
    {
    	private _otherPosition = _x call AS_fnc_location_position;
    	if (_otherPosition distance _position < 1000) then {
    		_count = _count + 1;
    	};
    } forEach _controlPoints;

    // iterates randomly through all roads within 500m to add roadblocks
    // adds a roadblock to a road when it:
    // 	- is between [400,500] meters
    // 	- has no roadblocks within 500 meters
    // 	- has two connected roads
    // it stops when there are 3 roadblocks
    private _roads = _position nearRoads 500;
    while {count _roads > 0 and _count < _max} do {
    	private _road = selectRandom _roads;
    	_roads = _roads - [_road];
        private _posroad = getPos _road;

    	if (_posroad distance _position > 400 and {count roadsConnectedto _road > 1}) then {
        	private _otherLocation = [_controlPoints, _posroad] call BIS_fnc_nearestPosition;
            private _otherPosition = _otherLocation call AS_fnc_location_position;
        	if (_otherPosition distance _posroad > 500) then {
				private _marker = [_posroad] call AS_fnc_location_addRoadblock;
                _count = _count + 1;
                _controlPoints pushBack _marker;
			};
    	};
    };
};

AS_fnc_location_addRoadblock = {
    params ["_position"];
    private _name = format ["roadblock_%1_%2", round (_position select 0), round (_position select 1)];
    private _marker = createMarker [_name, _position];
    [_marker, "roadblock"] call AS_fnc_location_add;
    _marker
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
            [_city, "population", _population] call AS_fnc_location_set;
            [_city, "roads", _roads] call AS_fnc_location_set;
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
    } forEach (call AS_fnc_locations);
};

// Updates location's public marker, creating a new marker if needed.
AS_fnc_location_updateMarker = {
    params ["_location"];
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
    ["location", _saveName] call AS_fnc_object_save;
};


AS_fnc_location_load = {
    params ["_saveName"];
    {_x call AS_fnc_location_remove} forEach (call AS_fnc_locations);
    ["location", _saveName] call AS_fnc_object_load;
    {
        private _location = _x;

        // ignore non-persistent properties from the save
        [_location,"spawned",false] call AS_fnc_location_set;
        [_location,"forced_spawned",false] call AS_fnc_location_set;

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

        _location call AS_fnc_location_updateMarker;

    } forEach (call AS_fnc_locations);
};

///////////// Auxiliar functions

AS_fnc_location_getNameSize = {
    params ["_name", "_min"];
    private _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusA");
    private _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusB");
    (_sizeX max _sizeY) max _min
};
