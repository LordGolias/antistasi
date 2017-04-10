private ["_estatica","_cercano","_jugador"];

_estatica = _this select 0;
_jugador = _this select 1;

if (!alive _estatica) exitWith {hint "You cannot steal a destroyed static weapon"};

if (alive gunner _estatica) exitWith {hint "You cannot steal a static weapon when someone is using it"};

if ((alive assignedGunner _estatica) and (!isPlayer (assignedGunner _estatica))) exitWith {hint "The gunner of this static weapon is still alive"};

_cercano = [marcadores,_estatica] call BIS_fnc_nearestPosition;

if (_cercano in mrkAAF) exitWith {hint "You have to conquer this zone in order to be able to steal this Static Weapon"};

_estatica setOwner (owner _jugador);

_tipoEst = typeOf _estatica;
_tipoB1 = "";
_tipoB2 = "";

switch _tipoEst do {
	case statMG: {
		_tipoB1 = statMGBackpacks select 0;
		_tipoB2 = statMGBackpacks select 1;
	};
	case statAA: {
		_tipoB1 = statAABackpacks select 0;
		_tipoB2 = statAABackpacks select 1;
	};
	case statAT: {
		_tipoB1 = statATBackpacks select 0;
		_tipoB2 = statATBackpacks select 1;
	};
	case statMortar: {
		_tipoB1 = statMortarBackpacks select 0;
		_tipoB2 = statMortarBackpacks select 1;
	};
	case statMGlow: {
		_tipoB1 = statMGlowBackpacks select 0;
		_tipoB2 = statMGlowBackpacks select 1;
	};
	case statMGtower: {
		_tipoB1 = statMGtowerBackpacks select 0;
		_tipoB2 = statMGtowerBackpacks select 1;
	};
	default {hint "You cannot steal this weapon."};
	};

_posicion1 = [_jugador, 1, (getDir _jugador) - 90] call BIS_fnc_relPos;
_posicion2 = [_jugador, 1, (getDir _jugador) + 90] call BIS_fnc_relPos;

deleteVehicle _estatica;

if (_tipoB1 == "") exitWith {};

_bag1 = _tipoB1 createVehicle _posicion1;
_bag2 = _tipoB2 createVehicle _posicion2;

[_bag1, "FIA"] call AS_fnc_initVehicle;
[_bag2, "FIA"] call AS_fnc_initVehicle;

// hint "Weapon Stolen. It won't despawn when you assemble it again";

/*
if (_cercano in controles) then
	{


	_jugador addEventHandler ["WeaponDisassembled",
		{
		_jugador = _this select 0;
		_bag1 = objectParent (_this select 1);
		_bag2 = objectParent (_this select 2);

		_posicion1 set [2, 0];
		_posicion2 set [2, 0];
		_bag1 setVehiclePosition [_posicion1, [], 2, "NONE"];
		_bag2 setVehiclePosition [_posicion2, [], 2, "NONE"];
		//_bag1 setPos _posicion1;
		//_bag2 setPos _posicion2;
		_jugador removeEventHandler ["WeaponDisassembled", 0];
		}
	];
	};

hint "Static Weapon stolen, it won't despawn when you move it or leave the area";


[[_estatica,"remove"],"flagaction"] call BIS_fnc_MP;

staticsToSave = staticsToSave + [_estatica];
publicVariable "staticsToSave";
_jugador action ["Disassemble", _estatica];
