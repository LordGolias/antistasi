// the valid vehicles of a given category or list of categories.
// If no argument is provided, returns all valid vehicles of all categories
private _categories = _this;
if (typeName _categories == "STRING") then {
    _categories = [_this];
};
if (isNil "_categories") then {
    _categories = call AS_AAFarsenal_fnc_all;
};
private _all = [];
{_all append ([_x, "valid"] call AS_AAFarsenal_fnc_get)} forEach _categories;
_all
