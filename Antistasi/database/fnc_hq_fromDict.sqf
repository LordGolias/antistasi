#include "../macros.hpp"
AS_SERVER_ONLY("AS_database_fnc_hq_fromDict");
params ["_dict"];

{
    (AS_permanent_HQplacements select _forEachIndex) setPos (_x select 0);
    (AS_permanent_HQplacements select _forEachIndex) setDir (_x select 1);
} forEach ([_dict, "permanents"] call DICT_fnc_get);

{deleteVehicle _x} forEach AS_HQ_placements;
AS_HQ_placements = [];
{
    _x params ["_pos", "_dir", "_type"];
    private _obj = _type createVehicle _pos;
    _obj setDir _dir;
    AS_HQ_placements pushBack _obj;
    [[_obj,"moveObject"],"AS_fnc_addAction"] call BIS_fnc_MP;
} forEach ([_dict, "placed"] call DICT_fnc_get);

fuego inflame ([_dict, "inflame"] call DICT_fnc_get);
call AS_fnc_initPetros;

placementDone = true; publicVariable "placementDone";
