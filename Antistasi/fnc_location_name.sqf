params ["_location"];

private _type = _location call AS_location_fnc_type;
private _pos = _location call AS_location_fnc_position;

if (_type == "fia_hq")  exitWith {"FIA HQ"};
if (_type == "hill") exitWith {format ["Observation Post at Mount %1",[_location,false] call AS_fnc_getLocationName]};
if (_type == "city") exitWith {_location};
private _cityname = [call AS_location_fnc_cities, _pos] call BIS_fnc_nearestPosition;
if (_type == "powerplant") exitWith {format ["Powerplant near %1",_cityname]};
if (_type == "base")       exitWith {format ["%1 Base",_cityname]};
if (_type == "airfield")   exitWith {format ["%1 Airport",_cityname]};
if (_type == "resource")   exitWith {format ["Resource near %1",_cityname]};
if (_type == "factory")    exitWith {format ["Factory near %1",_cityname]};
if (_type == "outpost")    exitWith {format ["Outpost near %1",_cityname]};
if (_type == "seaport")    exitWith {format ["Seaport near %1",_cityname]};
if (_type == "roadblock")  exitWith {format ["Roadblock near %1",_cityname]};
