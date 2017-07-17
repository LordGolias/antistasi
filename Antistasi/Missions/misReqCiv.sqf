if (!isServer and hasInterface) exitWith {};

params ["_type"];

private _posbase = getMarkerPos "FIA_HQ";
private _posibles = [];
private _exists = false;
private _sitios = [];

private _excl = [posStranger];

private _fnc_info = {
	params ["_text", ["_hint", "none"]];
	{
		[[["Stranger", _text]],"DIRECT",0.15] remoteExec ["createConv",_x];
		if !(_hint == "none") then {[_hint] remoteExec ["hint",_x];}
	} forEach ([15,0,position Stranger,"BLUFORSpawn"] call distanceUnits);
};

private _silencio = false;
if (count _this > 1) then {_silencio = true};

if (_type in misiones) exitWith {
	if (!_silencio) then {
		["I already gave you a mission of this type"] call _fnc_info;
	};
};
if ((server getVariable "civActive") > 1) exitWith {
	if (!_silencio) then {
		["How about you prove yourself first by doing what I told you to do..."] call _fnc_info;
	};
};

if (_type == "ASS") then {
	private _locations = (["city", "AAF"] call AS_fnc_location_TS) - _excl;
	{
		private _position = _x call AS_fnc_location_position;
		if ((_position distance _posbase < 4000) and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no assassination missions for you. Move our HQ closer to the enemy or finish some other assasination missions in order to have better intel.", "Assassination Missions require AAF cities, Observation Posts or bases closer than 4Km from your HQ."] call _fnc_info;
		};
	} else {
		[_posibles call BIS_fnc_selectRandom, "civ"] remoteExec ["ASS_Traidor",HCgarrisons];
	};
};

if (_type == "CON") then {
	private _locations = (["powerplant", "AAF"] call AS_fnc_location_TS) - _excl;
	{
		private _position = _x call AS_fnc_location_position;
		if ((_position distance _posbase < 4000) and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no Conquest missions for you. Move our HQ closer to the enemy or finish some other conquest missions in order to have better intel.", "Conquest Missions require AAF power plants closer than 4Km from your HQ."] call _fnc_info;
		};
	}
	else {
		[_posibles call BIS_fnc_selectRandom, "civ"] remoteExec ["AS_mis_conquer",HCgarrisons];
	};
};


if (_type == "CONVOY") then {
	private _locations = ([["powerplant","base"], "AAF"] call AS_fnc_location_TS) - _excl;
	{
		private _position = _x call AS_fnc_location_position;
		private _base = [_position] call findBasesForConvoy;
		if ((_position distance _posbase < 4000) and (_base != "")) then {
			_posibles pushBack _x;
		};
	} forEach _locations;
	if (count _posibles == 0) then {
		if (!_silencio) then {
			["I have no Convoy missions for you. Move our HQ closer to the enemy or finish some other convoy missions in order to have better intel.", "Convoy Missions require AAF Airports, Bases or Cities closer than 4Km from your HQ, and they must have an idle friendly base in their surroundings."] call _fnc_info;
		};
	}
	else {
		_sitio = _posibles call BIS_fnc_selectRandom;
		private _base = [_sitio call AS_fnc_location_position] call findBasesForConvoy;
		[_sitio,_base,"civ"] remoteExec ["CONVOY",HCgarrisons];
	};
};

if ((count _posibles > 0) and (!_silencio)) then {
	["I have a mission for you..."] call _fnc_info;
};
