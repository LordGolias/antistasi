if (count hcSelected player != 1) exitWith {hint "You must select an artillery group"};

private ["_grupo","_artyArray","_artyRoundsArr","_hayMuni","_estanListos","_hayArty","_estanVivos","_soldado","_veh","_tipoMuni","_tipoArty","_posicionTel","_artyArrayDef1","_artyRoundsArr1","_pieza","_isInRange","_posicionTel2","_rounds","_roundsMax","_texto","_mrkfin","_mrkfin2","_tiempo","_eta","_cuenta","_pos","_ang"];

_grupo = hcSelected player select 0;

_artyArray = [];
_artyRoundsArr = [];

_hayMuni = 0;
_estanListos = false;
_hayArty = false;
_estanVivos = false;
{
_soldado = _x;
_veh = vehicle _soldado;
if ((_veh != _soldado) and (not(_veh in _artyArray))) then
	{
	if (( "Artillery" in (getArray (configfile >> "CfgVehicles" >> typeOf _veh >> "availableForSupportTypes")))) then
		{
		_hayArty = true;
		if ((canFire _veh) and (alive _veh)) then
			{
			_estanVivos = true;
			if (typeOf _veh in bluMLRS) then
				{
				_tipoMuni = "12Rnd_230mm_rockets"
				}
			else
				{
				if (typeOf _veh in bluArty) then
					{
					createDialog "mbt_type";
					waitUntil {!dialog or !(isNil "tipoMuni")};
					if !(isNil "tipoMuni") then
						{
						_tipoMuni = tipoMuni;
						tipoMuni = nil;
						};
					}
				else
					{
					if ((typeOf _veh in bluStatMortar) || (typeOf _veh in allStatMortars)) then
						{
						createDialog "mortar_type";
						waitUntil {!dialog or !(isNil "tipoMuni")};
						if !(isNil "tipoMuni") then
							{
							_tipoMuni = tipoMuni;
							tipoMuni = nil;
							};
						};
					};
				};
			if (! isNil "_tipoMuni") then
				{
				{
				if (_x select 0 == _tipoMuni) then
					{
					_hayMuni = _hayMuni + 1;
					};
				} forEach magazinesAmmo _veh;
				};
			if (_hayMuni > 0) then
				{
				if (unitReady _veh) then
					{
					_estanListos = true;
					_artyArray pushBack _veh;
					_artyRoundsArr pushBack (((magazinesAmmo _veh) select 0)select 1);
					};
				};
			};
		};
	};
} forEach units _grupo;

if (isNil "_tipoMuni") exitWith {};
if (!_hayArty) exitWith {hint "You must select an artillery group or it is a Mobile Mortar and it's moving"};
if (!_estanVivos) exitWith {hint "All elements in this Batery cannot fire or are disabled"};
if ((_hayMuni < 2) and (!_estanListos)) exitWith {hint "The Battery has no ammo to fire. Reload it on HQ"};
if (!_estanListos) exitWith {hint "Selected Battery is busy right now"};

hcShowBar false;
hcShowBar true;

if (_tipoMuni != "2Rnd_155mm_Mo_LG") then
	{
	closedialog 0;
	createDialog "strike_type";
	}
else
	{
	tipoArty = "NORMAL";
	};

waitUntil {!dialog or (!isNil "tipoArty")};

if (isNil "tipoArty") exitWith {};

_tipoArty = tipoArty;
tipoArty = nil;


posicionTel = [];

hint "Select the position on map where to perform the Artillery strike";

openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

_posicionTel = posicionTel;

_artyArrayDef1 = [];
_artyRoundsArr1 = [];

for "_i" from 0 to (count _artyArray) - 1 do
	{
	_pieza = _artyArray select _i;
	_isInRange = _posicionTel inRangeOfArtillery [[_pieza], ((getArtilleryAmmo [_pieza]) select 0)];
	if (_isInRange) then
		{
		_artyArrayDef1 pushBack _pieza;
		_artyRoundsArr1 pushBack (_artyRoundsArr select _i);
		};
	};

if (count _artyArrayDef1 == 0) exitWith {hint "The position you marked is out of bounds for that Battery"};

_mrkfin = createMarker [format ["Arty%1", random 100], _posicionTel];
_mrkfin setMarkerShape "ICON";
_mrkfin setMarkerType "hd_destroy";
_mrkfin setMarkerColor "ColorRed";

if (_tipoArty == "BARRAGE") then
	{
	_mrkfin setMarkerText "Arty Barrage Begin";
	posicionTel = [];

	hint "Select the position to finish the barrage";

	openMap true;
	onMapSingleClick "posicionTel = _pos;";

	waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
	onMapSingleClick "";

	_posicionTel2 = posicionTel;
	};

if ((_tipoArty == "BARRAGE") and (isNil "_posicionTel2")) exitWith {deleteMarker _mrkfin};

if (_tipoArty != "BARRAGE") then
	{
	if (_tipoMuni != "2Rnd_155mm_Mo_LG") then
		{
		closedialog 0;
		createDialog "rounds_number";
		}
	else
		{
		rondas = 1;
		};
	waitUntil {!dialog or (!isNil "rondas")};
	};

if ((isNil "rondas") and (_tipoArty != "BARRAGE")) exitWith {deleteMarker _mrkfin};

if (_tipoArty != "BARRAGE") then
	{
	_mrkfin setMarkerText "Arty Strike";
	_rounds = rondas;
	_roundsMax = _rounds;
	rondas = nil;
	}
else
	{
	_rounds = round (_posicionTel distance _posicionTel2) / 10;
	_roundsMax = _rounds;
	};

private _location = [call AS_location_fnc_all,_posicionTel] call BIS_fnc_nearestPosition;

private _forcedSpawned = false;
if !(_location call AS_location_fnc_forced_spawned) then {
	_forcedSpawned = true;
	[_location,true] call AS_location_fnc_spawn;
};

_texto = format ["Requesting fire support on Grid %1. %2 Rounds", mapGridPosition _posicionTel, round _rounds];
[[AS_commander,"sideChat",_texto],"AS_fnc_localCommunication"] call BIS_fnc_MP;

if (_tipoArty == "BARRAGE") then
	{
	_mrkfin2 = createMarker [format ["Arty%1", random 100], _posicionTel2];
	_mrkfin2 setMarkerShape "ICON";
	_mrkfin2 setMarkerType "hd_destroy";
	_mrkfin2 setMarkerColor "ColorRed";
	_mrkfin2 setMarkerText "Arty Barrage End";
	_ang = [_posicionTel,_posicionTel2] call BIS_fnc_dirTo;
	sleep 5;
	_eta = (_artyArrayDef1 select 0) getArtilleryETA [_posicionTel, ((getArtilleryAmmo [(_artyArrayDef1 select 0)]) select 0)];
	_tiempo = time + _eta;
	_texto = format ["Acknowledged. Fire mission is inbound. ETA %1 secs for the first impact",round _eta];
	[[petros,"sideChat",_texto],"AS_fnc_localCommunication"] call BIS_fnc_MP;
	[_tiempo] spawn
		{
		private ["_tiempo"];
		_tiempo = _this select 0;
		waitUntil {sleep 1; time > _tiempo};
		[[petros,"sideChat","Splash. Out"],"AS_fnc_localCommunication"] call BIS_fnc_MP;
		};
	};

_pos = [_posicionTel,random 10,random 360] call BIS_fnc_relPos;

for "_i" from 0 to (count _artyArrayDef1) - 1 do {
	if (_rounds > 0) then {
		_pieza = _artyArrayDef1 select _i;
		_cuenta = _artyRoundsArr1 select _i;
		//hint format ["Rondas que faltan: %1, rondas que tiene %2",_rounds,_cuenta];
		if (_cuenta >= _rounds) then {
			if (_tipoArty != "BARRAGE") then {
				if ((typeOf _veh in bluStatMortar) || (typeOf _veh in allStatMortars) || (typeOf _veh in bluArty)) then {
					for "_r" from 1 to _rounds do {
						_pieza commandArtilleryFire [_pos,_tipoMuni,1];
						sleep 2;
					};
				} else {
					_pieza commandArtilleryFire [_pos,_tipoMuni,_rounds];
				};
			} else {
				for "_r" from 1 to _rounds do {
					_pieza commandArtilleryFire [_pos,_tipoMuni,1];
					sleep 2;
					_pos = [_pos,10,_ang + 5 - (random 10)] call BIS_fnc_relPos;
					};
				};
			_rounds = 0;
		} else {
			if (_tipoArty != "BARRAGE") then {
				if ((typeOf _veh in bluStatMortar) || (typeOf _veh in allStatMortars) || (typeOf _veh in bluArty)) then {
					for "_r" from 1 to _cuenta do {
						_pieza commandArtilleryFire [_pos,_tipoMuni,1];
						sleep 2;
					};
				} else {
					_pieza commandArtilleryFire [_pos,_tipoMuni,_cuenta];
				};
			} else {
				for "_r" from 1 to _cuenta do {
					_pieza commandArtilleryFire [_pos,_tipoMuni,1];
					sleep 2;
					_pos = [_pos,10,_ang + 5 - (random 10)] call BIS_fnc_relPos;
				};
			};
		_rounds = _rounds - _cuenta;
		};
	};
};

if (_tipoArty != "BARRAGE") then
	{
	sleep 5;
	_eta = (_artyArrayDef1 select 0) getArtilleryETA [_posicionTel, ((getArtilleryAmmo [(_artyArrayDef1 select 0)]) select 0)];
	_tiempo = time + _eta - 5;
	_texto = format ["Acknowledged. Fire mission is inbound. %2 Rounds fired. ETA %1 secs",round _eta,_roundsMax - _rounds];
	[[petros,"sideChat",_texto],"AS_fnc_localCommunication"] call BIS_fnc_MP;
	};

if (_tipoArty != "BARRAGE") then
	{
	waitUntil {sleep 1; time > _tiempo};
	[[petros,"sideChat","Splash. Out"],"AS_fnc_localCommunication"] call BIS_fnc_MP;
	};
sleep 10;
deleteMarker _mrkfin;
if (_tipoArty == "BARRAGE") then {deleteMarker _mrkfin2};

if (_forcedSpawned) then {
	// wait some time until despawn
	sleep 60;
	[_location, true] call AS_location_fnc_despawn;
};
