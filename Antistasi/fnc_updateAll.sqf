#include "macros.hpp"
AS_SERVER_ONLY("fnc_updateAll.sqf");
private _AAFnewMoney = 0;
private _FIAnewMoney = 25;
private _FIAnewHR = 0;

private _FIAtotalPop = 0;
private _AAFtotalPop = 0;
private _AAFResIncomeMultiplier = 1;
private _FIAResIncomeMultiplier = 1;

// forEach city, add to HR and money
{
    private _city = _x;
    private _side = _city call AS_location_fnc_side;
    private _population = [_x, "population"] call AS_location_fnc_get;
    private _AAFsupport = [_x, "AAFsupport"] call AS_location_fnc_get;
    private _FIAsupport = [_x, "FIAsupport"] call AS_location_fnc_get;
    private _power = [_city] call AS_fnc_location_isPowered;

    private _incomeAAF = 0;
    private _incomeFIA = 0;
    private _HRincomeFIA = 0;

    private _popFIA = (_population * (_FIAsupport / 100));
    private _popAAF = (_population * (_AAFsupport / 100));
    _FIAtotalPop = _FIAtotalPop + _popFIA;
    _AAFtotalPop = _AAFtotalPop + _popAAF;

    if !(_city in AS_P("destroyedLocations")) then {
        private _incomeMultiplier = 0.33;
        if (not _power) then {_incomeMultiplier = 0.5*0.33};

        _incomeAAF = _incomeMultiplier*_popAAF;
        _incomeFIA = _incomeMultiplier*_popFIA;
        _HRincomeFIA = (_population * (_FIAsupport / 20000));

        if (_side == "FIA") then {
            _incomeAAF = _incomeAAF/2;
            if _power then {
                if (_FIAsupport + _AAFsupport + 1 <= 100) then {[0,1,_city] spawn AS_fnc_changeCitySupport};
            }
            else {
                if (_FIAsupport > 6) then {
                    [0,-1,_city] spawn AS_fnc_changeCitySupport;
                } else {
                    [1,0,_city] spawn AS_fnc_changeCitySupport;
                };
            };
        } else {
            _incomeFIA = (_incomeFIA/2);
            _HRincomeFIA = (_HRincomeFIA/2);
            if _power then {
                if (_AAFsupport + _FIAsupport + 1 <= 100) then {[1,0,_city] call AS_fnc_changeCitySupport};
            }
            else {
                if (_AAFsupport > 6) then {
                    [-1,0,_city] spawn AS_fnc_changeCitySupport;
                } else {
                    [0,1,_city] spawn AS_fnc_changeCitySupport;
                };
            };
        };
    };

    _AAFnewMoney = _AAFnewMoney + _incomeAAF;
    _FIAnewMoney = _FIAnewMoney + _incomeFIA;
    _FIAnewHR = _FIAnewHR + _HRincomeFIA;

    // flip cities due to majority change.
    if ((_AAFsupport < _FIAsupport) and (_side == "AAF")) then {
        [["TaskSucceeded", ["", format ["%1 joined FIA",[_city, false] call AS_fnc_getLocationName]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
        _city call AS_location_fnc_updateMarker;

        ["con_cit"] call fnc_BE_XP;

        [0,5] call AS_fnc_changeForeignSupport;
        [_city, !_power] spawn AS_fnc_changeStreetLights;
    };
    if ((_AAFsupport > _FIAsupport) and (_side == "FIA")) then {
        [["TaskFailed", ["", format ["%1 joined %2",[_city, false] call AS_fnc_getLocationName, (["AAF", "name"] call AS_fnc_getEntity)]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
        _city call AS_location_fnc_updateMarker;
        [0,-5] call AS_fnc_changeForeignSupport;
        [_city, !_power] spawn AS_fnc_changeStreetLights;
    };
} forEach call AS_location_fnc_cities;

// control the airport and have majority => win game.
if ((_FIAtotalPop > _AAFtotalPop) and ("AS_airfield_3" call AS_location_fnc_side == "FIA")) exitWith {
    ["end1",true,true,true,true] remoteExec ["BIS_fnc_endMission",0]
};

// forEach factory, add to multiplier
{
    private _side = _x call AS_location_fnc_side;
    private _power = [_x] call AS_fnc_location_isPowered;
    if ((_power) and (not(_x in AS_P("destroyedLocations")))) then {
        if (_side == "FIA") then {_FIAResIncomeMultiplier = _FIAResIncomeMultiplier + 0.25};
        if (_side == "AAF") then {_AAFResIncomeMultiplier = _AAFResIncomeMultiplier + 0.25};
    };
} forEach ("factory" call AS_location_fnc_T);

// forEach resource, add to money
{
    private _side = _x call AS_location_fnc_side;
    private _power = [_x] call AS_fnc_location_isPowered;
    if !(_x in AS_P("destroyedLocations")) then {
        private _powerMultiplier = 1;
        if _power then {
            _powerMultiplier = 3;
        };
        if (_side == "FIA") then {_FIAnewMoney = _FIAnewMoney + (100 * _powerMultiplier * _FIAResIncomeMultiplier)};
        if (_side == "AAF") then {_AAFnewMoney = _AAFnewMoney + (100 * _powerMultiplier * _AAFResIncomeMultiplier)};
    };
} forEach ("resource" call AS_location_fnc_T);

private _texto = format ["<t size='0.6' color='#C1C0BB'>Taxes Income.<br/> <t size='0.5' color='#C1C0BB'><br/>Manpower: +%1<br/>Money: +%2 €",round _FIAnewHR, round _FIAnewMoney];

_AAFnewMoney = AS_P("resourcesAAF") + round _AAFnewMoney;
_FIAnewMoney = AS_P("resourcesFIA") + round _FIAnewMoney;
_FIAnewHR = AS_P("hr") + round _FIAnewHR;

if (_FIAnewHR > 0) then {
    _FIAnewHR = _FIAnewHR min (["HR"] call fnc_BE_permission);
};

[[petros,"income",_texto],"AS_fnc_localCommunication"] call BIS_fnc_MP;

AS_Pset("hr",_FIAnewHR);
AS_Pset("resourcesFIA",_FIAnewMoney);
AS_Pset("resourcesAAF",_AAFnewMoney);
