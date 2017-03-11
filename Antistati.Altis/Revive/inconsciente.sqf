private ["_unit","_grupo","_grupos","_isLeader","_dummyGroup","_bleedOut","_suicide","_saveVolume","_ayuda","_ayudado","_texto","_isPlayer","_camTarget","_saveVolumeVoice"];
_unit = _this select 0;
_unit setVariable ["inconsciente",true,true];
_bleedOut = time + 300;//300
_isPlayer = false;
if (isPlayer _unit) then {_isPlayer = true};
_fa = {_x == "FirstAidKit"} count items _unit;
_mk = {_x == "Medikit"} count items _unit;
//{_unit removeItems _x} foreach ["FirstAidKit","Medikit"];  <<<<<<<<<---------------------

if (vehicle _unit != _unit) then
	{
	_unit action ["getOut", vehicle _unit];
	if (_isPlayer) then
		{
		{
		if ((!isPlayer _x) and (vehicle _x != _x) and (_x distance _unit < 50)) then {unassignVehicle _x; [_x] orderGetIn false}
		} forEach units group _unit;
		};
	};

if (_isPlayer) then
	{
	closeDialog 0;
	respawnMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",
		{
		_handled = false;
		if (_this select 1 == 57) then
			{
			[player] spawn respawn;
			};
		_handled;
		}];
	_unit setCaptive true;
	disableUserInput true;
	titleText ["", "BLACK FADED"];
	openMap false;
	}
else
	{
	{_unit disableAI _x} foreach ["TARGET","AUTOTARGET","MOVE","ANIM"];
	_unit stop true;
	if (isPlayer (leader group _unit)) then {_unit setCaptive true};
	};


_unit switchMove "";
_unit playActionNow "Unconscious";
_unit setFatigue 1;
sleep 2;
if (_isPlayer) then
	{
	if (hayTFAR) then
		{
		_saveVolume = player getVariable ["tf_globalVolume", 1.0];
		player setVariable ["tf_unable_to_use_radio", true, true];
		player setVariable ["tf_globalVolume", 0];
		_saveVolumeVoice = player getVariable ["tf_voiceVolume", 1.0];
		if (random 100 < 20) then {player setVariable ["tf_voiceVolume", 0.0, true]};
		};
	titleText ["", "BLACK IN", 1];
	disableUserInput false;
	group _unit setCombatMode "YELLOW";
	deadCam = "camera" camCreate (player modelToWorld [0,0,2]);
	deadCam camSetTarget player;
	_camTarget = player;
	deadCam cameraEffect ["internal", "BACK"];
	deadCam camCommit 0;
	};

if (alive _unit) then {_unit switchMove "AinjPpneMstpSnonWrflDnon"};

while {(time < _bleedOut) and (damage _unit > 0.25) and (alive _unit) and (_unit getVariable "inconsciente") and (!(_unit getVariable "respawning"))} do
	{
	_tiempo = 1 + random 9;
	if (random 10 < 1) then {playSound3D [(injuredSounds call BIS_fnc_selectRandom),_unit,false, getPosASL _unit, 1, 1, 50];};
	if (_isPlayer) then
		{
		_ayudado = _unit getVariable "ayudado";
		if (isNil "_ayudado") then
			{
			_ayuda = [_unit] call pedirAyuda;
			if (isNull _ayuda) then
				{
				_texto = format ["<t size='0.6'>There is no AI near to help you.<t size='0.5'><br/>Hit SPACE to Respawn"];
				_camTarget = player;
				}
			else
				{
				_texto = format ["<t size='0.6'>%1 is on the way to help you.<t size='0.5'><br/>Hit SPACE to Respawn",name _ayuda];
				_camTarget = _ayuda;
				};
			}
		else
			{
			if (!isNil "_ayuda") then
				{
				_texto = format ["<t size='0.6'>%1 is on the way to help you.<t size='0.5'><br/>Hit SPACE to Respawn",name _ayuda];
				_camTarget = _ayuda;
				}
			else
				{
				_texto = "<t size='0.6'>Wait until you get assistance or<t size='0.5'><br/>Hit SPACE to Respawn";
				};
			};
		[_texto,0,0,_tiempo,0,0,4] spawn bis_fnc_dynamicText;
		if (_unit getVariable "respawning") exitWith {};
		//disableUserInput false;
		//titleText ["", "BLACK IN", _tiempo / 2];
		//deadCam camSetPos [(position player select 0) + 5 - (random 10), (position player select 1) + 5 - (random 10), random 10 + 2];
		deadCam camSetPos [(position player select 0), (position player select 1), (position player select 2) + 10];
		deadCam camSetTarget _camTarget;
		deadCam camCommit _tiempo;
		sleep _tiempo;
		}
	else
		{
		if (isPlayer (leader group _unit)) then
			{
			if (autoheal) then
				{
				_ayudado = _unit getVariable "ayudado";
				if (isNil "_ayudado") then {[_unit] call pedirAyuda;};
				};
			};
		sleep _tiempo;
		};
	};

if (_isPlayer) then
	{
	deadCam camSetPos position player;
	deadCam camCommit 1;
	sleep 1;
	deadCam cameraEffect ["terminate", "BACK"];
	camDestroy deadCam;
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", respawnMenu];
	_unit setCaptive false;
	if (hayTFAR) then
		{
		player setVariable ["tf_unable_to_use_radio", false, true];
		player setVariable ["tf_globalVolume", _saveVolume];
		player setVariable ["tf_voiceVolume", _saveVolumeVoice, true];
		};
	}
else
	{
	_unit stop false;
	_unit setCaptive false;
	};

// for "_i" from 1 to _fa do {_unit addItem "FirstAidKit";};  <<<<<<<<<<<<--------------
// for "_i" from 1 to _mk do {_unit addItem "Medikit";};  <<<<<<<<<<<<<<<<--------------

if (time > _bleedOut) exitWith
	{
	if (_isPlayer) then
		{
		_unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
		_ayudado = _unit getVariable "ayudado";
		if (!isNil "_ayudado") then
			{
			_ayuda = [_unit] call pedirAyuda;
			if (!isNull _ayuda) then {_unit setdamage 0.2} else {[_unit] call respawn};
			}
		else
			{
			[_unit] call respawn;
			};
		}
	else
		{
		_unit setDamage 1;
		};
	};
if (_unit getVariable "inconsciente") then {_unit setVariable ["inconsciente",false,true]};
if (alive _unit) then
	{
	_unit playMoveNow "AmovPpneMstpSnonWnonDnon_healed";
	if (!_isPlayer) then
		{
		{_unit enableAI _x} foreach ["TARGET","AUTOTARGET","MOVE","ANIM"];
		};
	};
