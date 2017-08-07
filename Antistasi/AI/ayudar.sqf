params ["_unit","_medic"];

private _fnc_heal = {
	if (_medic == _unit) then {
		_medic action ["HealSoldierSelf",_medic];
	} else {
		_medic action ["HealSoldier",_unit];
	};
	if hayACEMedical then {
		_medic playMove "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 10;
	if hayACEMedical then {
		[_unit, _unit] call ace_medical_fnc_treatmentAdvanced_fullHeal;
	};
};

// lock the units so others cannot help
_unit setVariable ["ayudado",true];
_medic setVariable ["ayudando",true];
[_medic, _unit] call cubrirConHumo;

if (_medic == _unit) exitWith {
	_medic groupChat "I am patching myself";
	[_unit,_medic] call _fnc_heal;
	_unit setVariable ["ayudado",nil];
	_medic setVariable ["ayudando",nil];
	_unit groupChat "I am ready";
	true
};

if ((not (_unit getVariable "inconsciente")) and (not(_unit getVariable ["ayudado",false]))) then {
	_unit groupChat format ["Comrades, this is %1. I'm hurt",name _unit];
	sleep 2;
	_medic groupChat format ["Wait a minute comrade %1, I will patch you up",name _unit];
};

private _canHeal = {(!alive _medic) or (!alive _unit) or (_medic distance _unit < 3)};

_medic groupChat format ["Hold on %1, on my way to help you",name _unit];
private _timeOut = time + 60;

while {true} do {
	_medic doMove getPosATL _unit;
	if ((_timeOut < time) or _canHeal or (_medic getVariable "inconsciente") or (_unit != vehicle _unit) or (_medic != vehicle _medic)) exitWith {};
	if (isPlayer _unit) then {
		if ((unitReady _medic) and (alive _medic) and (_medic distance _unit > 3) and (!(_medic getVariable "inconsciente"))) then {
			_medic setPos position _unit;
		};
	};
	sleep 1;
};
private _healed = false;
if (call _canHeal) then {
	_medic stop true;
	_unit stop true;
	[_unit,_medic] call _fnc_heal;
	_medic stop false;
	_unit stop false;
	_unit dofollow leader group _unit;
	_medic doFollow leader group _unit;
	_healed = true;
	_medic groupChat format ["You are ready, %1", name _unit];
};
// release the units so others can help
_unit setVariable ["ayudado",nil];
_medic setVariable ["ayudando",nil];
_healed
