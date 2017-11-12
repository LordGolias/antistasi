private _cargo_w = [[], []];
private _cargo_m = [[], []];
private _cargo_i = [[], []];
private _cargo_b = [[], []];

{
    (_cargo_w select 0) pushBack _x;
    (_cargo_w select 1) pushBack 100;
} forEach unlockedWeapons;

{
    (_cargo_m select 0) pushBack _x;
    (_cargo_m select 1) pushBack 100;
} forEach unlockedMagazines;

{
    (_cargo_i select 0) pushBack _x;
    (_cargo_i select 1) pushBack 100;
} forEach unlockedItems;
{
    (_cargo_b select 0) pushBack _x;
    (_cargo_b select 1) pushBack 100;
} forEach unlockedBackpacks;

[_cargo_w, _cargo_m, _cargo_i, _cargo_b]
