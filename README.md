# Antistasi by Golias

This is a modified version of Antistasi scenario for ARMA 3 that deals with some of the issues of the original version.

Antistasi is a scenario where you fight as a guerrilla liberator to flip the island to your side.
This modified version has the same mechanics and the same features but improves some aspects of it.

* The arsenal works as expected: weapons that are in the HQ ammo box are available to use.
* Multiple saved games: server/SP can now chose the saved game to load, save, or delete.
* Clients stats are saved in the server and saved when the server is saved.
* The HQ is now fully saved: both items positions (e.g. flag) and new constructions (e.g. sandbags).
* There is no unlocking mechanism: everything is always finite. You lose half of every item if the HQ is destroyed.
* Camps gives access to the arsenal: everything available in the HQ is available in camps (and you can store things there without having them lost).
* All game and performance options, including AI skill and cleanup time, are now modifiable by the commander.
* There is no "petros cavalary": this is the commander's responsibility.
* Menus were remade from scratch to better accommodate more buttons and other layouts.

The code was greatly simplified, cleaned, and reduced for DRY (e.g. for every 1 line added, 2 lines were deleted, I have +4 years experience as professional software developer).

# Debug tools

In the debug window, run

     [true] AS_DEBUG_init;

to show in the map all units (dead or alive) and locations that are currently spawned.
This helps tracking if CPU is being used unnecessarily. Use `false` to
reverse it.

# Code structure

- Municion/ -> scripts related with weapons, arsenal and boxes.
- CREATE/ -> scripts related with spawing places, units and convoys.
- statSave/ -> scripts related with loading and saving the game.
- ...

## Initialization

The relevant scripts are `init.sqf`, `initServer.sqf`, and `initPlayerLocal.sqf`.

`initPlayerLocal.sqf` is responsible for initializing the player. This includes
Event Handling, available actions, etc.

In SP, `init.sqf` is called and then `initPlayerLocal.sqf`.
In MP, `initServer.sqf` is responsible for the server, and `initPlayerLocal.sqf` for the client.

## Memory management

- Scripts that create stuff are responsible for cleaning them in the end, by tracking everything they created.
- Other units are managed by the client or server.

## Persistent saving

The code in `statSave/saveFuncs.sqf` is responsible for saving stuff.
Essentially, the following things are saved:

- Variables in the Logic `AS_persistent` named in the array `statSave/saveFuncs.AS_serverVariables`.
- Variables in the Logic `AS_persistent_cities` named in the array `statSave/cityAttrs.AS_cityVars`.
- Various global variables
