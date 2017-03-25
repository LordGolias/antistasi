private ["_hqDestroyed", "_hqInitialPlacement", "_posicionTel","_marcador","_closestEnemyLocation"];

_hqInitialPlacement = isNil "placementDone";
_hqDestroyed = !_hqInitialPlacement;

if (_hqDestroyed) then {
	stavros allowDamage false;
	"Petros is Dead" hintC "Petros has been killed. You lost part of your assets and need to select a new HQ position far from the enemies.";
}
else {
	diag_log "Antistasi: New Game selected";
	hint "Select the position you want to put your HQ.
          \nClose the map to start in the default position.
          \nChoose wisely: game changes a lot with the initial position!
          \nYou can move your HQ later.";
};

_enemyLocations = mrkAAF;
if (_hqDestroyed) then {
	openMap [true,true];
}
else {
	_enemyLocations = _enemyLocations - controles;  // first-time location can be close to controllers.
	openMap true;
};

// +100 so the location is not spawned every time.
// This is for placement only: moving the HQ still allows to place it anywhere.
private _minDistanceToLocation = distanciaSPWN + 100;
// min distance from enemy troops to do not get killed on placement.
private _minDistanceToEnemy = 500;


// Add markers to simplify the selection
_tempMarkers = [];
for "_i" from 0 to count _enemyLocations - 1 do {
    private _loc = _enemyLocations select _i;
    _mrk = createMarker [format ["initialHelper%1",_i], getMarkerPos _loc];
    _mrk setMarkerShape "ELLIPSE";
    _mrk setMarkerSize [_minDistanceToLocation, _minDistanceToLocation];
    _mrk setMarkerColor "ColorRed";
    _mrk setMarkerAlpha 0.1;
    _tempMarkers pushBack _mrk;
};

// wait until a valid position (or cancelled positioning for hqmoving)
while {true} do {
	posicionTel = [];
	onMapSingleClick "posicionTel = _pos;";

	waitUntil {sleep 1; (count posicionTel > 0) or (not visiblemap)};
	onMapSingleClick "";
	if (not visiblemap) exitWith {};
	_posicionTel = posicionTel;
	posicionTel = nil;
	_closestEnemyLocation = getMarkerPos ([_enemyLocations, _posicionTel] call BIS_fnc_nearestPosition);
	
	_validLocation = true;
	
	if (_closestEnemyLocation distance _posicionTel < _minDistanceToLocation) then {
		_validLocation = false;
		hint "That is too close from the enemy. Select another place.";
	};
	if (_validLocation and surfaceIsWater _posicionTel) then {
		_validLocation = false;
		hint "Selected position cannot be in water";
	};

	// check if there is any enemy in the surroundings.
	if (_validLocation and _hqDestroyed) then {
		_enemigos = false;
		{
            if ((side _x == side_green) or (side _x == side_red)) then {
                if (_x distance _posicionTel < _minDistanceToEnemy) exitWith {_enemigos = true};
            };
		} forEach allUnits;
        if (_enemigos) then {
			_validLocation = false;
			hint "There are enemies in the surroundings. Select another place.";
		};
	};

	if (_validLocation) exitWith {};
};

if (visiblemap) then {
	if (_hqDestroyed) then {
		_viejo = petros;
		grupoPetros = createGroup side_blue;
		publicVariable "grupoPetros";
        petros = grupoPetros createUnit ["B_G_officer_F", _posicionTel, [], 0, "NONE"];
        grupoPetros setGroupId ["Petros","GroupColor4"];
        petros setIdentity "amiguete";
        petros setName "Petros";
        petros disableAI "MOVE";
        petros disableAI "AUTOTARGET";
        [[petros,"buildHQ"],"flagaction"] call BIS_fnc_MP;

		call compile preprocessFileLineNumbers "initPetros.sqf";
        deleteVehicle _viejo;
        publicVariable "petros";
	}
	else {
		// update controllers' ownership close to chosen location
		{
			if (getMarkerPos _x distance _posicionTel < 1000) then {
				mrkAAF = mrkAAF - [_x];
				mrkFIA = mrkFIA + [_x];
			};
		} forEach controles;
		publicVariable "mrkAAF";
		publicVariable "mrkFIA";
		petros setPos _posicionTel;
	};

	"respawn_west" setMarkerPos _posicionTel;
	"respawn_west" setMarkerAlpha 1;

	// delete vehiclePad
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

	if (_hqInitialPlacement) then {
		// move all players to the HQ.
		if (isMultiplayer) then {
			{_x setPos getPos petros} forEach playableUnits;
		} else {
			stavros setPos (getMarkerPos "respawn_west");
		}
	}
	else {
		stavros allowDamage true;
	};
	if (isMultiplayer) then {
		caja hideObjectGlobal false;
		cajaVeh hideObjectGlobal false;
		mapa hideObjectGlobal false;
		fuego hideObjectGlobal false;
		bandera hideObjectGlobal false;
	}
	else {
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

{
    deleteMarker _x;
} forEach _tempMarkers;

if (_hqInitialPlacement) then {
	placementDone = true;
	publicVariable "placementDone";
	createDialog "boost_menu";
};
