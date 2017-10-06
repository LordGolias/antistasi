// given a cfgGroup, returns all units on that cfg faction
params ["_cfgGroups"];
private _result = [];
{
    for "_i" from 0 to count _x - 1 do {
        private _unitConf = _x select _i;
        if (isClass _unitConf) then {
            _result pushBack (getText (_unitConf >> "vehicle"));
        };
    };
} forEach ("true" configClasses _cfgGroups);
_result arrayIntersect _result - [""]
