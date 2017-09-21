# Dictionary

Dictionaries are an organized way to store data in a serializable format.

Dictionaries hold associated pairs `(key,value)` where:

- keys are `"STRING"`s unsorted and (case-insensitive) unique.
- values are any of the following types:

- `"OBJECT"`
- `"ARRAY"`
- `"BOOL"`
- `"STRING"`
- `"SCALAR"`

where `"OBJECT"` acts as a nested dictionary and `"ARRAY"` can contain only the types above.

## How to use dictionaries:

* create dictionary: `_dict = call DICT_fnc_create`
* add sub-dictionary: `[_dict, _key] = call DICT_fnc_add`
* (recursively) delete a dictionary: `_dict call DICT_fnc_delete`

* list keys (whose value is not nil): `_dict call DICT_fnc_keys`
* whether a key exists: `[_dict,_key] call DICT_fnc_exists`

* set pair: `[_dict, _key, _value] call DICT_fnc_set`
* get value: `_value = [_dict, _key] call DICT_fnc_get`
* (recursively) delete key: `[_dict, _key] call DICT_fnc_del`

* (recursively) copy dictionary: `_dict1 = _dict call DICT_fnc_copy`

`get` and `exist` functions accept an arbitrary number of arguments:

```
[_dict, _key1, _key2] call DICT_fnc_get
```

is semantically equivalent to

```
[[_dict, _key1] call DICT_fnc_get), _key2] call DICT_fnc_get
```

### Serialization to string

Dictionaries are fully serializable to strings. This means that they can be used
to store data persistently outside Arma.

* serialize to string: `_string = _dict call DICT_fnc_serialize`
* deserialize from string: `_dict = _string call DICT_fnc_deserialize`
