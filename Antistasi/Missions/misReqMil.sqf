if (!isServer and hasInterface) exitWith {};

private ["_tipo","_posbase","_posibles","_ciudad"];

_tipo = _this select 0;

_posbase = getMarkerPos "FIA_HQ";
_posibles = [];

_fnc_info = {
	params ["_text", ["_hint", "none"]];
	{
		[[["Nomad", _text]],"DIRECT",0.15] remoteExec ["createConv",_x];
		if !(_hint == "none") then {[_hint] remoteExec ["hint",_x];}
	} forEach ([15,0,position Nomad,"BLUFORSpawn"] call distanceUnits);
};

_silencio = false;
if (count _this > 1) then {_silencio = true};

if (_tipo in misiones) exitWith {
	if (!_silencio) then {
		["I already gave you a mission of this type."] call _fnc_info;
	};
};

if ((server getVariable "milActive") > 1) exitWith {
	if (!_silencio) then {
		["How about you prove yourself first by doing what I told you to do..."] call _fnc_info;
	};
};

if (_tipo == "AS") exitWith {
	private _locations = [["base", "city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if ((_pos distance _posbase < 5000) and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no assassination missions for you. Move our HQ closer to the enemy or finish some other assassination missions in order to have better intel.", "Assasination Missions require AAF cities, Observation Posts or bases closer than 4Km from your HQ."] call _fnc_info;
		};
	} else {
		private _location = selectRandom _posibles;
		private _type = _location call AS_fnc_location_type;
		if (_type == "city") then {[_location, "mil"] remoteExec ["AS_specOP",HCgarrisons];};
		if (_type == "base") then {[_location, "mil"] remoteExec ["AS_Oficial",HCgarrisons];};
		["I have a mission for you..."] call _fnc_info;
	};
};
if (_tipo == "CON") exitWith {
	private _locations = [["hillAA"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if ((_pos distance _posbase < 5000) and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;
	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no Conquest missions for you. Move our HQ closer to the enemy or finish some other conquest missions in order to have better intel.", "Conquest Missions require AAF roadblocks or outposts closer than 4Km from your HQ."] call _fnc_info;
		};
	}
	else {
		[selectRandom _posibles, "mil"] remoteExec ["CON_AA",HCgarrisons];
		["I have a mission for you..."] call _fnc_info;
	};
};
if (_tipo == "DES") exitWith {
	private _locations = [["base", "city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if ((_pos distance _posbase < 4000) and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no destroy missions for you. Move our HQ closer to the enemy or finish some other destroy missions in order to have better intel.", "Destroy Missions require AAF bases or airports closer than 4Km from your HQ."] call _fnc_info;
		};
	} else {
		private _location = selectRandom _posibles;
		private _type = _location call AS_fnc_location_type;
		if (_type == "base") then {[_location, "mil"] remoteExec ["DES_Vehicle",HCgarrisons]};
		if (_type == "airfield") then {[_location, "mil"] remoteExec ["DES_Heli",HCgarrisons]};
		["I have a mission for you..."] call _fnc_info;
	};
};
if (_tipo == "CONVOY") exitWith {
	private _locations = [["base", "city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		private _base = [_pos] call findBasesForConvoy;
		if ((_pos distance _posbase < 4000) and not(_x call AS_fnc_location_spawned) and (_base !="")) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no Convoy missions for you. Move our HQ closer to the enemy or finish some other rescue missions in order to have better intel.", "Convoy Missions require AAF Airports, Bases or Cities closer than 4Km from your HQ, and they must have an idle friendly base in their surroundings."] call _fnc_info;
		};
	}
	else {
		private _location = selectRandom _posibles;
		_base = [_location call AS_fnc_location_position] call findBasesForConvoy;
		[_location,_base,"mil"] remoteExec ["CONVOY",HCgarrisons];
		["I have a mission for you..."] call _fnc_info;
	};
};
