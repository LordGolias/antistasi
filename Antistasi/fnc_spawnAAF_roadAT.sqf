params ["_position", "_group"];

private _vehicles = [];
private _units = [];

(_position call AS_fnc_roadAndDir) params ["_road", "_dir"];
if (!isNull _road) then {
    private _pos = [getPos _road, 7, _dir + 270] call BIS_Fnc_relPos;
    private _bunker = "Land_BagBunker_Small_F" createVehicle _pos;
    _bunker setDir _dir;
    _pos = getPosATL _bunker;
    _vehicles pushBack _bunker;

    private _veh = (["AAF", "static_at"] call AS_fnc_getEntity) createVehicle _position;
    _veh setPos _pos;
    _veh setDir _dir + 180;
    [_veh, "AAF"] call AS_fnc_initVehicle;
    _vehicles pushBack _veh;

    private _unit = ([_position, 0, ["AAF", "gunner"] call AS_fnc_getEntity, _group] call bis_fnc_spawnvehicle) select 0;
    _unit moveInGunner _veh;
    [_unit, false] spawn AS_fnc_initUnitAAF;
    _units pushBack _unit;
};
[_units, _vehicles]
