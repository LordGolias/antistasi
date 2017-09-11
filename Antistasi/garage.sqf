#include "macros.hpp"
params ["_pool"];

if not ([player] call isMember) exitWith {hint "You cannot access the Garage as you are guest in this server"};
if (call AS_fnc_controlsAI) exitWith {hint "You cannot access the Garage while you are controlling AI"};
private _enemies = false;
{
	if ((side _x == side_red) and (_x distance player < 500) and (not(captive _x))) exitWith {_enemies = true};
} forEach allUnits;

if _enemies exitWith {Hint "You cannot manage the Garage with enemies nearby"};

if _pool then {
	vehInGarageShow = player getVariable "garage";
} else {
	vehInGarageShow = AS_P("vehiclesInGarage");
};

if (count vehInGarageShow == 0) exitWith {
	hintC "The Garage is empty"
};

private _break = false;
garagePos = [];
if (isNil "vehiclePad") then {
	garagePos = position player findEmptyPosition [5,45,"B_MBT_01_TUSK_F"];
} else {
	garagePos = position vehiclePad;
	if (count (vehiclePad nearObjects ["AllVehicles",7]) > 0) then {_break = true};
};
if _break exitWith {hintC "Clear the area, not enough space to spawn a vehicle."};

if (count garagePos == 0) exitWith {hintC "Couldn't find a safe position to spawn the vehicle, or the area is too crowded to spawn it safely"};

// the selected as an index
cuentaGarage = 0;

// the selected as a vehicle
garageVeh = createVehicle [(vehInGarageShow select cuentaGarage), garagePos, [], 0, "NONE"];
garageVeh setDir AS_S("AS_vehicleOrientation");
garageVeh allowDamage false;
garageVeh enableSimulationGlobal false;

Cam = "camera" camCreate (player modelToWorld [0,0,4]);
Cam camSetTarget garagePos;
Cam cameraEffect ["internal", "BACK"];
//Cam camCommand "Manual On";
Cam camCommit 0;

["<t size='0.6'>Garage Keys.<t size='0.5'><br/>A-D Navigate<br/>SPACE to Select<br/>ESCAPE to Exit",0,0,5,0,0,4] spawn bis_fnc_dynamicText;

garageKeys = (findDisplay 46) displayAddEventHandler ["KeyDown", {
	private _key = _this select 1;
	if not (_key in [57, 1, 32, 30]) exitWith {
		false
	};
	private _exitGarage = false;
	private _changeVehicle = false;
	private _takeVehicle = false;
	["<t size='0.6'>Garage Keys.<t size='0.5'><br/>A-D Navigate<br/>SPACE to Select<br/>ESCAPE to Exit",0,0,5,0,0,4] spawn bis_fnc_dynamicText;
	if (_this select 1 == 57) then {
		// space: take and leave
		_exitGarage = true;
		_takeVehicle = true;
	};
	if (_key == 1) then {
		// escape: leave
		_exitGarage = true;
		deleteVehicle garageVeh;
	};
	// A and D: rotate
	if (_key == 32) then {
		if (cuentaGarage + 1 > (count vehInGarageShow) - 1) then {
			cuentaGarage = 0
		} else {
			cuentaGarage = cuentaGarage + 1
		};
		_changeVehicle = true;
	};
	if (_key == 30) then {
		if (cuentaGarage - 1 < 0) then {
			cuentaGarage = (count vehInGarageShow) - 1
		} else {
			cuentaGarage = cuentaGarage - 1
		};
		_changeVehicle = true;
	};
	if _changeVehicle then {
		garageVeh enableSimulationGlobal false;
		deleteVehicle garageVeh;
		private _tipo = vehInGarageShow select cuentaGarage;
		if (isNil "_tipo") then {_exitGarage = true};
		if (typeName _tipo != typeName "") then {_exitGarage = true};
		if (!_exitGarage) then {
			garageVeh = _tipo createVehicle garagePos;
			garageVeh setDir AS_S("AS_vehicleOrientation");
			garageVeh allowDamage false;
			garageVeh enableSimulationGlobal false;
		};
	};
	if _exitGarage then {
		Cam camSetPos position player;
		Cam camCommit 1;
		Cam cameraEffect ["terminate", "BACK"];
		camDestroy Cam;
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", garageKeys];
		if not _takeVehicle then {
			["",0,0,5,0,0,4] spawn bis_fnc_dynamicText;
		} else {
			[garageVeh, "FIA"] call AS_fnc_initVehicle;
			["<t size='0.6'>Vehicle retrieved from Garage",0,0,3,0,0,4] spawn bis_fnc_dynamicText;
			private _newArr = [];
			private _found = false;
			if (vehInGarageShow isEqualTo AS_P("vehiclesInGarage")) then {
				{
					if ((_x != (vehInGarageShow select cuentaGarage)) or (_found)) then {
						_newArr pushBack _x
					} else {
						_found = true
					};
				} forEach AS_P("vehiclesInGarage");
				AS_Pset("vehiclesInGarage", _newArr);
			} else {
				{
					if ((_x != (vehInGarageShow select cuentaGarage)) or (_found)) then {
						_newArr pushBack _x
					} else {
						_found = true
					};
				} forEach (player getVariable "garage");
				player setVariable ["garage", _newArr, true];
				garageVeh setVariable ["AS_vehOwner", getPlayerUID player, true];
			};
			if (garageVeh isKindOf "StaticWeapon") then {
				[garageVeh] remoteExec ["AS_fnc_changePersistentVehicles", 2];
			};
			[garageVeh] call emptyCrate;
			garageVeh allowDamage true;
			garageVeh enableSimulationGlobal true;

			[garageVeh, "out"] call fnc_BE_checkVehicle;
		};
		//vehInGarageShow = nil;
		//garagePos = nil;
		//cuentaGarage = nil;
		//garageVeh = nil;
	};
	true
}];
