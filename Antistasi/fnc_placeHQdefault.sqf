if (!isNil "petros") then {
    deleteVehicle petros;
    deleteGroup grupoPetros;
};

grupoPetros = createGroup side_blue;
publicVariable "grupoPetros";
petros = grupoPetros createUnit ["B_G_officer_F", getMarkerPos "FIA_HQ", [], 0, "NONE"];
[[petros,"mission"],"flagaction"] call BIS_fnc_MP;
publicVariable "petros";
grupoPetros setGroupId ["Petros","GroupColor4"];
petros setIdentity "amiguete";
petros setName "Petros";
petros disableAI "MOVE";
petros disableAI "AUTOTARGET";

_pos = [position petros, 3, getDir petros] call BIS_Fnc_relPos;
fuego setPos _pos;
_rnd = getdir Petros;
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

call compile preprocessFileLineNumbers "initPetros.sqf";
