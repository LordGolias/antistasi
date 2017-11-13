# Spawn API

A `spawn` is a list of execution blocks that are to be executed sequentially.
Between blocks, the state of the spawn is saved globally, which makes spawns
fault-tolerant against client disconnections.

The API derives from [the dictionary API](../dictionary/README.md), each spawn
is stored as a dictionary. Spawns are shared across all machines and are owned
by one machine (that is currently executing it). Like dictionaries, spawns use `add/set/get/delete`.

Every spawn has a unique `"name"` and a `"type"`.
The spawn type is used to get the list of execution blocks (defined at `AS_spawn_fnc_states`).
To track on which state the spawn is, every spawn has a property `"state_index"` that
identifies on which state it currently is.
When a spawn is executed, its `"spawnOwner"` becomes the local `clientOwner`, which
is used to track which clients are running what.
Whenever a client disconnects, the server takes over the spawns of that client (since
the resources are also taken over by the server).

The current spawns are:
* [locations](../location/spawns)
* [missions](../mission/spawns)
* [AAF movements](../movement/spawns)

that are declared on their respective directories.
