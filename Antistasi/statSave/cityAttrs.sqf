// every city name is a variable of `AS_persistent_cities` and each contains an array with data. This maps names to its respective array index.
// the first two indexes are occupied (with city pop and city civ vehicles).
// Add other variables for more data.
AS_cityVars = ["population", "vehicles", "prestigeOPFOR", "prestigeBLUFOR"];

// given a city and an array of variable names, it returns a list of values refering to each var name.
AS_fnc_getCityAttrs = {
	private ["_values", "_data"];
	params ["_city", "_varNames"];

	_data = AS_persistent_cities getVariable _city;

	_values = [];
	{
		_index = AS_cityVars find _x;
		if (_index == -1) throw ("AS_fnc_getCityAttrs: property " + _x + " does not exist");
		_values pushBack (_data select _index);
	} forEach _varNames;
	_values
};

// given a city, an array of variables names and another of values, sets the variables respectively.
AS_fnc_setCityAttrs = {
	private ["_data"];
	params ["_city", "_varNames", "_varValues"];

	_data = AS_persistent_cities getVariable _city;

	for "_i" from 0 to (count _varNames - 1) do {
		_varName = _varNames select _i;
		_varValue = _varValues select _i;

		_index = AS_cityVars find _varName;
		if (_index == -1) throw ("AS_fnc_setCityAttrs: property " + _varName + " does not exist");
		_data set [_index, _varValue];
	};
	AS_persistent_cities setVariable [_city, _data, true];
};

AS_fnc_initCity = {
	params ["_city", "_values"];
	if (count _values != count AS_cityVars) throw "AS_fnc_initCity: wrong initialisation.";
    AS_persistent_cities setVariable [_city,_values, true];
};
