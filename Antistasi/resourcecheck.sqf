#include "macros.hpp"
AS_SERVER_ONLY("resourcecheck.sqf");

private _timeBetweenResources = 600;

scriptName "resourcecheck";
while {true} do {
	call AS_fnc_mission_updateAvailable;
	sleep _timeBetweenResources;
	if (isMultiplayer) then {waitUntil {sleep 10; isPlayer AS_commander}};

	call AS_fnc_updateAll;

	// Assign new commander if needed.
	if isMultiplayer then {[] spawn AS_fnc_chooseCommander;};

	// if too little patrols, generate new patrols.
	if (AAFpatrols < 3) then {[] remoteExec ["AS_fnc_createRoadPatrol",hcAttack]};

	// repair and re-arm all statics.
	{
		private _veh = _x;
		if ((_veh isKindOf "StaticWeapon") and ({isPlayer _x} count crew _veh == 0) and (alive _veh)) then {
			_veh setDamage 0;
			[_veh,1] remoteExec ["setVehicleAmmoDef",_veh];
		};
	} forEach vehicles;

	// update the counter by the time that has passed
	[-_timeBetweenResources] remoteExec ["AS_fnc_changeSecondsforAAFattack",2];

	// start AAF attacks under certain conditions.
	if ((AS_P("secondsForAAFAttack") < 1) and (diag_fps > AS_P("minimumFPS"))) then {
		private _awActive = server getVariable ["waves_active",false];
		if ((count ("aaf_attack" call AS_fnc_active_missions) == 0) and !_awActive) then {
			private _script = [] spawn ataqueAAF;
			waitUntil {sleep 5; scriptDone _script};
		};
	};

	// update AAF economics.
	sleep 3;
	call AAFeconomics;

	// Check if any communications were intercepted.
	sleep 4;
	[] call FIAradio;
};
