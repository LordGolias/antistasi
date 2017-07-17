#include "../macros.hpp"
AS_SERVER_ONLY("Missions/missionrequest.sqf");

params ["_tipo", ["_silencio", false], ["_pickTarget", false]];

private _posbase = getMarkerPos "FIA_HQ";
private _posibles = [];
private _sitios = [];
private _exists = false;

if (_tipo in misiones) exitWith {
	if (!_silencio) then {
		[[petros,"globalChat","I already gave you a mission of this type"],"commsMP"] call BIS_fnc_MP
	};
};

if (_tipo == "DES") exitWith {
	{
		private _base = (getPos _x) call AS_fnc_location_nearest;
		if (((getPos _x) distance _posbase < 4000) and
		    (_base call AS_fnc_location_side == "AAF")) then {
			_posibles pushBack _base;
		};
	} forEach (antenas - antenasMuertas);

	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[petros,"globalChat","I have no destroy missions for you. Move our HQ closer to the enemy or finish some other destroy missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
			[[petros,"hint","Destroy Missions require Radio Towers closer than 4Km from your HQ."],"commsMP"] call BIS_fnc_MP;
		};
	} else {
		[selectRandom _posibles] remoteExec ["DES_antena",HCgarrisons];
		[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
	};
};
if (_tipo == "LOG") exitWith {
	private _locations = [["outpost", "city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if (_pos distance _posbase < 4000) then {
			_posibles pushBack _x;
		}
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[petros,"globalChat","I have no logistics missions for you. Move our HQ closer to the enemy or finish some other logistics missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
			[[petros,"hint","Logistics Missions require AAF Outposts, Cities or Banks closer than 4Km from your HQ."],"commsMP"] call BIS_fnc_MP;
		};
	}
	else {
		private _location = selectRandom _posibles;
		private _type = _location call AS_fnc_location_type;

		if (_type == "city") then {
			if (random 10 < 5) then {
				[_location] remoteExec ["LOG_Suministros",HCgarrisons];
			}
			else {
				[_location] remoteExec ["LOG_Medical",HCgarrisons];
			};
		};
		if (_type == "outpost") then {[_location] remoteExec ["LOG_Ammo",HCgarrisons]};
		if (_type == "bank") then {[_location] remoteExec ["LOG_Bank",HCgarrisons]};
		[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
	};
};
if (_tipo == "RES") exitWith {
	private _locations = [["city", "outpost", "base"], "AAF"] call AS_fnc_location_TS;

	{
		private _pos = _x call AS_fnc_location_position;
		if (_pos distance _posbase < 4000) then {
			_posibles pushBack _x;
		}
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[petros,"globalChat","I have no rescue missions for you. Move our HQ closer to the enemy or finish some other rescue missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
			[[petros,"hint","Rescue Missions require AAF Cities or Bases closer than 4Km from your HQ."],"commsMP"] call BIS_fnc_MP;
		};
	} else {
		private _location = selectRandom _posibles;
		private _type = _location call AS_fnc_location_type;
		if (_type == "city") then {
			[_location] remoteExec ["RES_Refugiados",HCgarrisons]
		} else {
			[_location] remoteExec ["RES_Prisioneros",HCgarrisons]
		};
		[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
	};
};
if (_tipo in ["FND_M","FND_C","FND_E"]) exitWith {
	private _locations = call AS_fnc_location_cities;
	{
		private _pos = _x call AS_fnc_location_position;
		if (_pos distance _posbase < 4000) then {
			_posibles pushBack _x;
		};
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[petros,"globalChat","I have no contact missions right now."],"commsMP"] call BIS_fnc_MP;
			};
	} else {
		private _location = selectRandom _posibles;
		call {
			if (_tipo == "FND_M") exitWith {
				[_location] remoteExec ["FND_MilCon", 2];
			};
			if (_tipo == "FND_C") exitWith {
				[_location] remoteExec ["FND_CivCon", 2];
			};
			if (_tipo == "FND_E") exitWith {
				[_location] remoteExec ["FND_ExpDealer", 2];
			}
		};
		[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
	};
};
if (_tipo == "CONVOY") exitWith {
	private _locations = [["city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		private _base = [_pos] call findBasesForConvoy;
		if ((_pos distance _posbase < 4000) and (_base !="")) then {
			_posibles pushBack _x;
		}
	} forEach _locations;

	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[petros,"globalChat","I have no Convoy missions for you. Move our HQ closer to the enemy or finish some other rescue missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
			[[petros,"hint","Convoy Missions require AAF Airports, Bases or Cities closer than 4Km from your HQ, and they must have an idle friendly base in their surroundings."],"commsMP"] call BIS_fnc_MP;
		};
	}
	else {
		private _location = selectRandom _posibles;
		private _base = [_location call AS_fnc_location_position] call findBasesForConvoy;
		[_location,_base,"auto"] remoteExec ["CONVOY",HCgarrisons];
		[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
	};
};

if (_tipo == "PR") then {
	private _posiblesA = [];
	private _posiblesB = [];
	private _locations = [["city"], "AAF"] call AS_fnc_location_TS;

	if (_pickTarget) then {
		{
			private _pos = _x call AS_fnc_location_position;
			if (_pos distance _posbase < 4000) then {
				if ([_x, "AAFsupport"] call AS_fnc_location_get > 0) then {
					_posiblesA pushBack _x;
				};
				if ([_x, "FIAsupport"] call AS_fnc_location_get > 10) then {
					_posiblesB pushBack _x;
				};
			}
		} forEach _locations;

		{
			if ((isPlayer _x) && (_x == AS_commander)) then {
				[_posiblesA, _posiblesB] remoteExec ["missionSelect",_x];
			}
		} forEach ([20,0,petros,"BLUFORSpawn"] call distanceUnits);
	} else {
		{
			private _pos = _x call AS_fnc_location_position;
			if (_pos distance _posbase < 4000) then {
				_posibles pushBack _x;
			};
		} forEach _locations;

		if (count _posibles == 0) then {
			if (!_silencio) then {
				[[petros,"globalChat","I have no PR missions for you. Move our HQ closer to the enemy or finish some other PR missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
				[[petros,"hint","PR missions require AAF cities closer than 4Km from your HQ."],"commsMP"] call BIS_fnc_MP;
			};
		} else {
			[selectRandom _posibles] remoteExec ["PR_Pamphlet",HCgarrisons];
			[[petros,"globalChat","I have a mission for you"],"commsMP"] call BIS_fnc_MP;
		};
	};
};

if (_tipo == "ASS") then {
	private _locations = [["city"], "AAF"] call AS_fnc_location_TS;
	{
		private _pos = _x call AS_fnc_location_position;
		if (_pos distance _posbase < 4000 and !(_x call AS_fnc_location_spawned)) then {
			_posibles pushBack _x;
		};
	} forEach _locations;
	if (count _posibles == 0) then {
		if (!_silencio) then {
			[[Stranger,"globalChat","I have no assasination missions for you. Move our HQ closer to the enemy or finish some other assasination missions in order to have better intel"],"commsMP"] call BIS_fnc_MP;
			[[Stranger,"hint","Assasination Missions require AAF cities closer than 4Km from your HQ."],"commsMP"] call BIS_fnc_MP;
		};
	}
	else {
		[selectRandom _posibles, "civ"] remoteExec ["ASS_Traidor",HCgarrisons];
	};
};
