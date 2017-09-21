# Location API

A location is a place in the map that is spawned/despawned under certain conditions.
Each location is represented by a string (e.g. `_location = "FIA_HQ";`)
and has a type (e.g. `"base"`, `"resource"`). Each location "owns" a hidden marker
that is used to represent its position.

This API uses the [dictionary API](../dictionary/README.md) to store data
persistently and globally.

All properties of a location are defined in `fnc_properties` (they depend on the location type)
that can be accessed either using `fnc_[property]` for common properties or `fnc_get` (any property).

Likewise, locations' properties can be modified using `fnc_set`, locations can be added using `fnc_add`
and removed using `fnc_remove`.

There are common iterators for locations that are already defined:

```
call AS_location_fnc_all
// [T]ype and [S]ide
_bases = "base" call AS_location_fnc_T;
_FIAlocations = "FIA" call AS_location_fnc_S;
_FIAbases = ["base","AAF"] call AS_location_fnc_TS;
[["base","airfield"],"FIA"] call AS_location_fnc_TS;
```

`AS_spawn_fnc_update.sqf` is the function that controls which locations are spawned.
When opposing forces reach (or other conditions), this loop spawns the location using
the [spawn API](../spawn/README.md).
The spawns for each type of location is defined in `spawns`.
