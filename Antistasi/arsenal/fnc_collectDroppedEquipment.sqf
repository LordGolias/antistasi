#include "../macros.hpp"
AS_SERVER_ONLY("fnc_collectDroppedEquipment");
params ["_position", "_size", "_box"];
{
    ([_x, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
    [_box, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
    deleteVehicle _x;
} forEach nearestObjects [_position, ["WeaponHolderSimulated", "WeaponHolder"], _size];

{
    if not (alive _x) then {
        ([_x, true] call AS_fnc_getUnitArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
        [_box, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true] call AS_fnc_populateBox;
        _x call AS_fnc_emptyUnit;
    };
} forEach (_position nearObjects ["Man", _size]);
