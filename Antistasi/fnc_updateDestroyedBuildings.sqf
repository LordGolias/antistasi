params ["_buildings"];

// locks to avoid race conditions
waitUntil {isNil "AS_destroyingBuildings"};
AS_destroyingBuildings = true;

private _destroyedBuildings = AS_P("destroyedBuildings");
{
	if ((!alive _x) and (not(_x in _destroyedBuildings))) then {
		_destroyedBuildings pushBack (position _x);
	};
} forEach _buildings;
AS_Pset("destroyedBuildings", _destroyedBuildings);

AS_destroyingBuildings = nil;
