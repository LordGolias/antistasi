# Database API

This directory contains the API to load and save games.
Saving a game requires serializing its relevant parts into a format that can
loaded back.

In antistasi, we go one step further an ensure that the format is human-readable.
This means that when you save the game, you can read it and understand what
the saved game has.

Essentially, a game is saved by converting the whole state to a [dictionary](../dictionary/README.md)
and serialize it to a string (and the reverse to load). This API contain a set of functions to do so.

The most important functions are `fnc_saveGame` and `fnc_loadGame`. `fnc_saveGame`
returns a string, `fnc_loadGame` receives a string.

This API also gives you access to manage and store saved games in the `profileNamespace`,
see e.g. `fnc_setData` and `fnc_getData`.

There are other functions around to serialize and deserialize variables. E.g.
if you want to persistently store a variable in `AS_P`, add it to `fnc_init`.

When the commander saves the game, the saved game is sent
to all player's clipBoards, so that everyone has access to the saved game,
and it is stored on the profileNamespace of the commander.
ATM no-one can change the profileNamespace of the server.
