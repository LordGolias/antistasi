# Mission API

The Mission API contains all the code to manage, initialize, and complete missions.

A mission is a shared object
A mission is a shared and persistent data structure (using the [dictionary API](../dictionary/README.md))
that has a `type` (e.g. `kill_officer`), a `status` (e.g. `available`), and other properties.

When a mission starts (`fnc_execute`), a [spawn](../spawn/README.md) is initialized.
The actual states of the missions are defined in `spawns`, and the spawn follows these states.

Every outcome (success or fail) of a mission is defined in `fnc__getFailData` and
`fnc__getSuccessData`.

Each mission is defined by a set of states (e.g. `"initialize"`, `"wait_to_deliver"`)
and functions that execute those states.

## Example of usage

To start the mission `"kill_officer"` in city `_cityName`, use

```
// create and save it persistently
["kill_officer", _cityName] call AS_mission_fnc_add;
// spawn it
"kill_officer" call AS_mission_fnc_activate;
```

The mission is deleted automatically once the it completed (successfully or not).

## How to add a new mission

Follow the following steps:

1. decide on a unique name for the mission type (`name`).

2. Create a file in `spawns` called `fnc_[name].sqf`, which declares 2 global arrays,
`AS_mission_[name]_states` and `AS_mission_[name]_state_functions` and populate it with functions.
Make sure the functions store the state of the mission in the end. Check [existing examples](spawns) for inspiration.

3. Add the outcomes of the mission in `fnc__getFailData` and `fnc__getSuccessData`.

4. Add the mission to the `fnc_spawn_states` as the others.

5. Add conditions for the mission to be available to `fnc_updateAvailable`

6. Add the `fnc_[name].sqf` to the `cfgFunctions.hpp` as the others.
