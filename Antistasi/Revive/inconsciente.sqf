params ["_unit"];
_unit setVariable ["inconsciente",true,true];

private _bleedOut = time + 300;
private _isPlayer = false;

if (isPlayer _unit) then {_isPlayer = true};

if (vehicle _unit != _unit) then {
	_unit action ["getOut", vehicle _unit];
	if _isPlayer then {
		{
			if ((!isPlayer _x) and (vehicle _x != _x) and (_x distance _unit < 50)) then {
				unassignVehicle _x; [_x] orderGetIn false
			};
		} forEach units group _unit;
	};
};

if _isPlayer then {
	closeDialog 0;
	respawnMenu = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		if (_this select 1 == 57) then {
			[player] spawn respawn;
		};
		false;
	}];
	_unit setCaptive true;
	disableUserInput true;
	titleText ["", "BLACK FADED"];
	openMap false;
} else {
	{_unit disableAI _x} foreach ["TARGET","AUTOTARGET","MOVE","ANIM"];
	_unit stop true;
	_unit groupChat "Medic!";
	if (isPlayer (leader group _unit)) then {_unit setCaptive true};
};

_unit switchMove "";
_unit playActionNow "Unconscious";
_unit setFatigue 1;
sleep 2;
if _isPlayer then {
	titleText ["", "BLACK IN", 1];
	disableUserInput false;
	group _unit setCombatMode "YELLOW";
	deadCam = "camera" camCreate (player modelToWorld [0,0,2]);
	deadCam camSetTarget player;
	deadCam cameraEffect ["internal", "BACK"];
	deadCam camCommit 0;
};

if (alive _unit) then {
	_unit switchMove "AinjPpneMstpSnonWrflDnon";
};

private _medic = objNull;
private _tiempo = 5;
while {(time < _bleedOut) and (damage _unit > 0.25) and (alive _unit) and (_unit call AS_fnc_isUnconscious) and (!(_unit getVariable "respawning"))} do {
	sleep _tiempo;
	if (random 10 < 5) then {
		playSound3D [(injuredSounds call BIS_fnc_selectRandom),_unit,false, getPosASL _unit, 1, 1, 50];
	};
	if _isPlayer then {
		private _ayudado = _unit getVariable "ayudado";
		private _camTarget = player;
		private _texto = "";
		if (isNil "_ayudado") then {
			private _medic = [_unit] call pedirAyuda;
			if (isNull _medic) then {
				_texto = format ["<t size='0.6'>There is no AI near to help you.<t size='0.5'><br/>Hit SPACE to Respawn"];
				_camTarget = player;
			} else {
				_texto = format ["<t size='0.6'>%1 is on the way to help you.<t size='0.5'><br/>Hit SPACE to Respawn",name _medic];
				_camTarget = _medic;
			};
		} else {
			if (!isNil "_medic") then {
				_texto = format ["<t size='0.6'>%1 is on the way to help you.<t size='0.5'><br/>Hit SPACE to Respawn",name _medic];
				_camTarget = _medic;
			} else {
				_texto = "<t size='0.6'>Wait until you get assistance or respawn.<t size='0.5'><br/>Hit SPACE to Respawn";
			};
		};
		[_texto,0,0,_tiempo,0,0,4] spawn bis_fnc_dynamicText;
		if (_unit getVariable "respawning") exitWith {};
		deadCam camSetPos [(position player select 0), (position player select 1), (position player select 2) + 10];
		deadCam camSetTarget _camTarget;
		deadCam camCommit _tiempo;
	} else {
		if (isPlayer (leader group _unit) and autoheal) then {
			private _ayudado = _unit getVariable "ayudado";
			if (isNil "_ayudado") then {
				[_unit] call pedirAyuda;
			};
		};
	};
};

if _isPlayer then {
	deadCam camSetPos position player;
	deadCam camCommit 1;
	sleep 1;
	deadCam cameraEffect ["terminate", "BACK"];
	camDestroy deadCam;
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", respawnMenu];
	_unit setCaptive false;
} else {
	_unit stop false;
	_unit setCaptive false;
};

if (time > _bleedOut) exitWith {
	if _isPlayer then {
		_unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		private _ayudado = _unit getVariable "ayudado";
		if (!isNil "_ayudado") then {
			private _medic = [_unit] call pedirAyuda;
			if (!isNull _medic) then {
				_unit setdamage 0.2;
			} else {
				[_unit] call respawn;
			};
		} else {
			[_unit] call respawn;
		};
	} else {
		_unit setDamage 1;
	};
};


if (_unit call AS_fnc_isUnconscious) then {
	_unit setVariable ["inconsciente",false,true]
};
if (alive _unit) then {
	_unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
	if (!_isPlayer) then {
		{_unit enableAI _x} foreach ["TARGET","AUTOTARGET","MOVE","ANIM"];
	};
};
