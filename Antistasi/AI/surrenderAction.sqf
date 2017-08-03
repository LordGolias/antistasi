private ["_unit","_coste","_armas","_municion","_caja","_items"];

_unit = _this select 0;

if (typeOf _unit == "Fin_random_F") exitWith {};

_unit setVariable ["surrendered",true];
if ((side _unit == side_green) or (side _unit == side_red)) then
	{
	[[_unit,"interrogar"],"AS_fnc_addAction"] call BIS_fnc_MP;
	[[_unit,"capturar"],"AS_fnc_addAction"] call BIS_fnc_MP;
	[0,10] remoteExec ["resourcesFIA",2];
	[-2,0,getPos _unit] remoteExec ["citySupportChange",2];
	_coste = AS_data_allCosts getVariable (typeOf _unit);
    if (isNil "_coste") then {diag_log format ["[AS] ERROR: cost of %1 not defined.",typeOf _unit]; _coste = 0};
	[-_coste] remoteExec ["resourcesAAF",2];
	}
else
	{
	[-2,2,getPos _unit] remoteExec ["citySupportChange",2];
	[1,0] remoteExec ["AS_fnc_changeForeignSupport",2];
	};
_armas = [];
_municion = [];
_items = [];
_unit allowDamage false;
[_unit] orderGetin false;
_unit stop true;
_unit disableAI "MOVE";
_unit disableAI "AUTOTARGET";
_unit disableAI "TARGET";
_unit disableAI "ANIM";
//_unit disableAI "FSM";
_unit setUnitPos "UP";

// create box and add all content to it.
_box = "Box_IND_Wps_F" createVehicle position _unit;
_cargoArray = [_unit] call AS_fnc_getUnitArsenal;
[_box, _cargoArray select 0, _cargoArray select 1, _cargoArray select 2, _cargoArray select 3, false, true] call AS_fnc_populateBox;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllassignedItems _unit;
removeVest _unit;
removeHeadgear  _unit;
removeBackpackGlobal _unit;

_unit setCaptive true;
sleep 1;
if (alive _unit) then
	{
	_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	};
_unit setSpeaker "NoVoice";
_unit addEventHandler ["HandleDamage",
	{
	_unit = _this select 0;
	_unit enableAI "ANIM";
	if (!simulationEnabled _unit) then {_unit enableSimulationGlobal true};
	}
	];
if (_unit getVariable ["OPFORSpawn",false]) then {_unit setVariable ["OPFORSpawn",nil,true]};
[_unit] remoteExec ["postmortem",2];
[_box] remoteExec ["postmortem",2];
sleep 10;
_unit allowDamage true;
_unit enableSimulationGlobal false;
