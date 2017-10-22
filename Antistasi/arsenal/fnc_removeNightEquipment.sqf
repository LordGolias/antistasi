params ["_unit"];

// remove NV goggles
private _nvg = hmd _unit;
if (_nvg != "") then {
    _unit unlinkItem _nvg;
};
// remove laser pointer and flashlight
private _items = primaryWeaponItems _unit;
{
    _unit unassignItem _x;
    _unit removePrimaryWeaponItem _x;
} forEach ((AS_allLasers + AS_allFlashlights) arrayIntersect CSATItems arrayIntersect _items);
