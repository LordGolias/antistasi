// The list of all categories. Order defines what is bought first at AAFeconomics.sqf.
AS_AAFarsenal_categories = ["supplies", "trucks", "apcs", "transportHelis", "tanks", "armedHelis", "planes"];

// checks if the _category is valid.
#define CHECK_CATEGORY(_category) (if !(_category in AS_AAFarsenal_categories) then { \
	diag_log format ["[AS] AAFarsenal: category %1 does not exist.", _category];} \
);

// Has to have the same order as above
AS_AAFarsenal_category_names = [
	"Supply trucks", "Trucks", "APCs",
	"Transport Helicopters", "Tanks", "Armed Helicopters", "Planes"
];

// get a presentable name of the category.
AS_fnc_AAFarsenal_name = {
	params ["_category"];
	CHECK_CATEGORY(_category);
	AS_AAFarsenal_category_names select (AS_AAFarsenal_categories find _category)
};

// Initializes the AAF Arsenal.
AS_fnc_AAFarsenal_init = {
	// AAF will only buy and use vehicles of the types added here. See template.
	{
		AS_AAFarsenal setVariable ["valid_" + _x, [], true];
	} forEach AS_AAFarsenal_categories;

	// the current arsenal by categories. AAF vehicles bought are added here.
	{
		AS_AAFarsenal setVariable [_x, [], true];
	} forEach AS_AAFarsenal_categories;

	// the max size of the arsenal
	// 	To modders: do not modify these in the template as they are updated
	// 	by the simulation.
	{
		AS_AAFarsenal setVariable ["max_" + _x, 0, true];
	} forEach AS_AAFarsenal_categories;

	// the buying cost (to AAF) of each category
    AS_AAFarsenal setVariable ["cost_planes", 20000, true];
	AS_AAFarsenal setVariable ["cost_armedHelis", 10000, true];
	AS_AAFarsenal setVariable ["cost_transportHelis", 4000, true];
    AS_AAFarsenal setVariable ["cost_tanks", 10000, true];
	AS_AAFarsenal setVariable ["cost_apcs", 5000, true];
	AS_AAFarsenal setVariable ["cost_trucks", 600, true];
	AS_AAFarsenal setVariable ["cost_supplies", 600, true];

	// the selling value of each category (to FIA). Currently half of the AAF cost.
    AS_AAFarsenal setVariable ["value_planes", 10000, true];
	AS_AAFarsenal setVariable ["value_armedHelis", 5000, true];
	AS_AAFarsenal setVariable ["value_transportHelis", 2000, true];
    AS_AAFarsenal setVariable ["value_tanks", 5000, true];
	AS_AAFarsenal setVariable ["value_apcs", 2000, true];
	AS_AAFarsenal setVariable ["value_trucks", 300, true];
	AS_AAFarsenal setVariable ["value_supplies", 300, true];
};

// given a vehicle type (`typeOf _veh`), returns its category (or "" if it belongs to none)
AS_fnc_AAFarsenal_category = {
	params ["_type"];
	private _category = "";
	{
		if (_type in (AS_AAFarsenal getVariable ("valid_" + _x))) exitWith {_result = _x;};
	} forEach AS_AAFarsenal_categories;
	_category
};

// Returns bool of whether the category has space for more vehicles.
AS_fnc_AAFarsenal_canAdd = {
    params ["_category"];
	CHECK_CATEGORY(_category);
    private _current = AS_AAFarsenal getVariable _category;
    count _current < (AS_AAFarsenal getVariable ("max_" + _category))
};

// Adds a vehicle to the arsenal.
// Returns "" if it was not added or the vehicle type added.
AS_fnc_AAFarsenal_addVehicle = {
    params ["_category"];
	CHECK_CATEGORY(_category);
    private _current = AS_AAFarsenal getVariable _category;

    if !([_category] call AS_fnc_AAFarsenal_canAdd) exitWith {
        ""
    };

    private _valid = AS_AAFarsenal getVariable ("valid_" + _category);
	private _type = selectRandom _valid;
    _current pushBack (_type);

    AS_AAFarsenal setVariable [_category, _current, true];
	_type
};

// Given a list of categories, returns all available vehicles on them.
AS_fnc_AAFarsenal_all = {
	private _all = [];
	{CHECK_CATEGORY(_x);_all = _all + (AS_AAFarsenal getVariable _x)} forEach _this;
    _all
};

// Given a list of categories, returns all valid vehicles on them.
// This is useful to force-create a vehicle (e.g. AAF does not have it, but a mission requires it).
AS_fnc_AAFarsenal_valid = {
	private _all = [];
	{CHECK_CATEGORY(_x);_all = _all + (AS_AAFarsenal getVariable ("valid_" + _x))} forEach _this;
    _all
};

// Same as above, but counts instead.
AS_fnc_AAFarsenal_count = {
	count (_this call AS_fnc_AAFarsenal_all)
};

// Removes the vehicle type from the arsenal.
AS_fnc_AAFarsenal_deleteVehicle = {
    params ["_type"];
	private _category = [typeOf _veh] call AS_fnc_AAFarsenal_category;
	private _current = AS_AAFarsenal getVariable _category;
	_current deleteAt (_current find _type);
	AS_AAFarsenal setVariable [_category, _current, true];
};

// Returns the cost of buying for a given category
AS_fnc_AAFarsenal_cost = {
    params ["_category"];
	CHECK_CATEGORY(_category);
    AS_AAFarsenal getVariable ("cost_" + _category)
};

// Returns the value of selling a given category
AS_fnc_AAFarsenal_cost = {
    params ["_category"];
	CHECK_CATEGORY(_category);
    AS_AAFarsenal getVariable ("value_" + _category)
};

AS_fnc_saveAAFarsenal = {
	params ["_saveName"];
	{
		[_saveName, ("AAFarsenal_v1_" + _x), AS_AAFarsenal getVariable _x] call AS_fnc_SaveStat;
	} forEach AS_AAFarsenal_categories;
};

AS_fnc_loadAAFarsenal = {
	params ["_saveName"];
	call AS_fnc_AAFarsenal_init;
	{
		AS_AAFarsenal setVariable [_x, [_saveName, "AAFarsenal_v1_" + _x] call AS_fnc_LoadStat, true];
	} forEach AS_AAFarsenal_categories;
};

// Updates the maximal number of units based on the airfields and bases controlled
// by AAF.
AS_fnc_updateAAFarsenal = {
	// Increases the maximum capacity for a category. Use "_set" to not increase,
	// but set a new value.
	private _AS_fnc_AAFarsenal_setMax = {
		params ["_category", "_newValue"];
		AS_AAFarsenal setVariable ["max_" + _category, _newValue, true];
	};

	private _AAFairfields = count (mrkAAF arrayIntersect aeropuertos);
	private _AAFbases = count (mrkAAF arrayIntersect bases);
	["planes", _AAFairfields] call _AS_fnc_AAFarsenal_setMax;
	["armedHelis", 2*_AAFairfields] call _AS_fnc_AAFarsenal_setMax;
	["transportHelis", 2*_AAFairfields] call _AS_fnc_AAFarsenal_setMax;
	["tanks", _AAFbases] call _AS_fnc_AAFarsenal_setMax;
	["apcs", 2*_AAFbases] call _AS_fnc_AAFarsenal_setMax;
	["trucks", 2*_AAFbases] call _AS_fnc_AAFarsenal_setMax;
	["supplies", _AAFbases] call _AS_fnc_AAFarsenal_setMax;
};
