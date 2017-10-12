# Dictionary

This mod implements a dictionary API for SQF. A dictionary is a data structure to store arbitrary hierarchical data in a serializable format.

Arma does not have dictionaries implemented out of the box, and it does not provide an interface to serialize its data structures to a string. This mod solves these problems by implementing a transparent dictionary API to store data in-memory (in Arma engine) that can trivially be converted to and from a string.

Dictionaries hold associated pairs `(key,value)` where:

- key is a `"STRING"`s that is unique (case-insensitive) on a dictionary;
- value is any type, where the type `"OBJECT"` acts as a nested dictionary.

## How to install it:

Subscribe to it on steam and load it on the launcher.

## How to use it:

* create new: `_dict = call DICT_fnc_create`
* set a pair: `[_dict, _key, _value] call DICT_fnc_set`
* get value: `_value = [_dict, _key] call DICT_fnc_get`
* create sub-dictionary: `[_dict, _key, call DICT_fnc_create] call DICT_fnc_set`
* delete key (recursively): `[_dict, _key] call DICT_fnc_del`
* delete a dictionary (recursively): `_dict call DICT_fnc_del`

* list all keys: `_dict call DICT_fnc_keys`
* check whether a key exists: `if ([_dict, _key] call DICT_fnc_exists)`

* copy dictionary (recursively): `_dict1 = _dict call DICT_fnc_copy`

`get` and `exist` functions accept an arbitrary number of arguments. I.e.:

```
[_dict, _key1, _key2] call DICT_fnc_get
```

is semantically equivalent to

```
[[_dict, _key1] call DICT_fnc_get), _key2] call DICT_fnc_get
```

* `DICT_fnc_delGlobal`, `DICT_fnc_copyGlobal` and `DICT_fnc_setGlobal` are global variants of the respective local methods. For example:

```
myDict = call DICT_fnc_create;
publicVariable "myDict";
[myDict, "a", 1] call DICT_fnc_setGlobal;

// on any machine:
[myDict, "a"] call DICT_fnc_get;
```

## To and from string

Dictionaries are serializable to strings and can therefore be used to store data persistently outside the Arma engine.

* to string: `_string = _dict call DICT_fnc_serialize`
* from string: `_dict = _string call DICT_fnc_deserialize`

While dictionaries can hold arbitrary types, only the following types can be serializable to strings:

- `"OBJECT"`
- `"ARRAY"`
- `"BOOL"`
- `"STRING"`
- `"SCALAR"`

where `"OBJECT"` acts as a nested dictionary and `"ARRAY"` can only contain the types above.
Values whose type is not any of the above are not serialized (an error is printed on log file and the key is ignored).

`DICT_fnc_serialize` and `DICT_fnc_deserialize` accept optional arguments that
define how the dictionary is converted to a string. We favored the string be
human readable in detriment of space (i.e. it has line breaks).

## Use cases

There are two main use cases of dictionaries: store values systematically and add persistent storage.

### Use case 1: store values systematically

If you have two factions named `"nato"` and `"csat"` that both have a common attribute `"weapons"`, you can create a dictionary of the form
```
// during initialization
entities = call DICT_fnc_create;
[entities, "weapons", call DICT_fnc_create] call DICT_fnc_set;
[entities, "weapons", "nato", [...]] call DICT_fnc_set;
[entities, "weapons", "csat", [...]] call DICT_fnc_set;
...

// during execution
_weapons = [entities, "weapons", _faction] call DICT_fnc_get;
```

If you add `publicVariable "entities"` and replace `DICT_fnc_set` by `DICT_fnc_setGlobal`
and only run the initialization on the server, then `"weapons"` will be accessible on all machines.

### Use case 2: Add persistent saving

On the server, create a (nested) dictionary that stores persistent variables:

```
// during initialization on the server
persistents = call DICT_fnc_create;
[persistents, "foreign_support", 0] call DICT_fnc_set;

// e.g. during execution the support increased
private _support = [persistents, "foreign_support"] call DICT_fnc_get;
[persistents, "foreign_support", _support + 10] call DICT_fnc_set;
```

Then, use the following to save the whole dictionary:

```
// on the server
private _data = persistents call DICT_fnc_serialize;
profileNamespace setVariable ["MY_MISSION", _data];
```

and the following to load it back:
```
// on the server

private _data = profileNamespace getVariable "MY_MISSION";
if isNil "_data" exitWith {
    hint "No game saved";
};

// delete previous to not use memory
if not isNil "persistents" then {
    persistents call DICT_fnc_del;
};
// load new
persistents = _data call DICT_fnc_deserialize;
```

Note that we just stored the value `10` persistently, but we could have
stored a whole (nested) dictionary, which could e.g. contain information about each player
or anything else. With this mod, you do not have to worry about the nesting details,
only about what data you want to store.
