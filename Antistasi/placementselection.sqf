if (!isNil "placementDone") then
	{
	stavros allowDamage false;
	"Petros is Dead" hintC "Petros has been killed. You lost part of your assets and need to select a new HQ position far from the enemies.";
	}
else
	{
	diag_log "Antistasi: New Game selected";
	"Initial HQ Placement Selection" hintC ["Click on the Map Position you want to start the Game.","Close the map with M to start in the default position.","Don't select areas with enemies nearby!!\n\nGame experience changes a lot on different starting positions."];
	};

hintC_arr_EH = findDisplay 72 displayAddEventHandler ["unload",
	{
	0 = _this spawn
		{
		_this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
		hintSilent "";
		};
	}];

private ["_posicionTel","_marcador","_marcadores"];
_marcadores = mrkAAF;
if (isNil "placementDone") then
	{
	_marcadores = _marcadores - controles;
	openMap true;
	}
else
	{
	openMap [true,true];
	};
while {true} do
	{
	posicionTel = [];
	onMapSingleClick "posicionTel = _pos;";

	waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
	onMapSingleClick "";
	if (not visiblemap) exitWith {};
	_posicionTel = posicionTel;
	_marcador = [_marcadores,_posicionTel] call BIS_fnc_nearestPosition;
	if (getMarkerPos _marcador distance _posicionTel < 1000) then {hint "Place selected is very close to enemy zones.\n\n Please select another position"};
	if (surfaceIsWater _posicionTel) then {hint "Selected position cannot be in water"};
	_enemigos = false;
	if (!isNil "placementDone") then
		{
		{
		if ((side _x == side_green) or (side _x == side_red)) then
			{
			if (_x distance _posicionTel < 1000) then {_enemigos = true};
			};
		} forEach allUnits;
		};
	if (_enemigos) then {hint "There are enemies in the surroundings of that area, please select another."};
	if ((getMarkerPos _marcador distance _posicionTel > 1000) and (!surfaceIsWater _posicionTel) and (!_enemigos)) exitWith {};
	};

if (visiblemap) then
	{
	if (isNil "placementDone") then
		{
		{
		if (getMarkerPos _x distance _posicionTel < 1000) then
			{
			mrkAAF = mrkAAF - [_x];
			mrkFIA = mrkFIA + [_x];
			};
		} forEach controles;
		publicVariable "mrkAAF";
		publicVariable "mrkFIA";
		petros setPos _posicionTel;
		}
	else
		{
		_viejo = petros;
		grupoPetros = createGroup side_blue;
		publicVariable "grupoPetros";
        petros = grupoPetros createUnit ["B_G_officer_F", _posicionTel, [], 0, "NONE"];
        grupoPetros setGroupId ["Petros","GroupColor4"];
        petros setIdentity "amiguete";
        petros setName "Petros";
        petros disableAI "MOVE";
        petros disableAI "AUTOTARGET";
        if (group _viejo == grupoPetros) then {[[Petros,"mission"],"flagaction"] call BIS_fnc_MP;} else {[[Petros,"buildHQ"],"flagaction"] call BIS_fnc_MP;};
         call compile preprocessFileLineNumbers "initPetros.sqf";
        deleteVehicle _viejo;
        publicVariable "petros";
		};
	"respawn_west" setMarkerPos _posicionTel;
	"respawn_west" setMarkerAlpha 1;
	if !(isNil "vehiclePad") then {
		[vehiclePad, {deleteVehicle _this}] remoteExec ["call", 0];
		[vehiclePad, {vehiclePad = nil}] remoteExec ["call", 0];
		server setVariable ["AS_vehicleOrientation", 0, true];
	};
	if (isMultiplayer) then {hint "Please wait while moving HQ Assets to selected position";sleep 5};
	_pos = [_posicionTel, 3, getDir petros] call BIS_Fnc_relPos;
	fuego setPos _pos;
	_rnd = getdir Petros;
	if (isMultiplayer) then {sleep 5};
	_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
	caja setPos _pos;
	_rnd = _rnd + 45;
	_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
	mapa setPos _pos;
	mapa setDir ([fuego, mapa] call BIS_fnc_dirTo);
	_rnd = _rnd + 45;
	_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
	bandera setPos _pos;
	_rnd = _rnd + 45;
	_pos = [getPos fuego, 3, _rnd] call BIS_Fnc_relPos;
	cajaVeh setPos _pos;
	if (isNil "placementDone") then {if (isMultiplayer) then {{_x setPos getPos petros} forEach playableUnits} else {stavros setPos (getMarkerPos "respawn_west")}} else {stavros allowDamage true};
	if (isMultiplayer) then
		{
		caja hideObjectGlobal false;
		cajaVeh hideObjectGlobal false;
		mapa hideObjectGlobal false;
		fuego hideObjectGlobal false;
		bandera hideObjectGlobal false;
		}
	else
		{
		caja hideObject false;
		cajaVeh hideObject false;
		mapa hideObject false;
		fuego hideObject false;
		bandera hideObject false;
		};
	openmap [false,false];
	};
"FIA_HQ" setMarkerPos (getMarkerPos "respawn_west");
posHQ = getMarkerPos "respawn_west"; publicVariable "posHQ";
if (isNil "placementDone") then {
	placementDone = true;
	publicVariable "placementDone";
	createDialog "boost_menu";
};