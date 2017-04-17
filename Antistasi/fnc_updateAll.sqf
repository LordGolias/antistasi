#include "macros.hpp"
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
    private _side = _city call AS_fnc_location_side;
    private _population = [_x, "population"] call AS_fnc_location_get;
    private _AAFsupport = [_x, "AAFsupport"] call AS_fnc_location_get;
    private _FIAsupport = [_x, "FIAsupport"] call AS_fnc_location_get;
    private _power = [_city] call powerCheck;

    private _incomeAAF = 0;
    private _incomeFIA = 0;
    private _HRincomeFIA = 0;

    private _popFIA = (_population * (_FIAsupport / 100));
    private _popAAF = (_population * (_AAFsupport / 100));
    _FIAtotalPop = _FIAtotalPop + _popFIA;
    _AAFtotalPop = _AAFtotalPop + _popAAF;

    if !(_city in destroyedCities) then {
        _incomeMultiplier = 0.33;
        if (not _power) then {_incomeMultiplier = 0.5*0.33};

        _incomeAAF = _incomeMultiplier*_popAAF;
        _incomeFIA = _incomeMultiplier*_popFIA;
        _HRincomeFIA = (_population * (_FIAsupport / 20000));

        if (_side == "FIA") then {
            _incomeAAF = _incomeAAF/2;
            if (_power) then {
                if (_FIAsupport + _AAFsupport + 1 <= 100) then {[0,1,_city] spawn citySupportChange};
            }
            else {
                if (_FIAsupport > 6) then {
                    [0,-1,_city] spawn citySupportChange;
                } else {
                    [1,0,_city] spawn citySupportChange;
                };
            };
        } else {
            _incomeFIA = (_incomeFIA/2);
            _HRincomeFIA = (_HRincomeFIA/2);
            if (_power) then {
                if (_AAFsupport + _FIAsupport + 1 <= 100) then {[1,0,_city] call citySupportChange};
            }
            else {
                if (_AAFsupport > 6) then {
                    [-1,0,_city] spawn citySupportChange;
                } else {
                    [0,1,_city] spawn citySupportChange;
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
        _city call AS_fnc_location_updateMarker;

        if (hayBE) then {["con_cit"] remoteExec ["fnc_BE_XP", 2]};
        [0,5] remoteExec ["prestige",2];
        [_city, !_power] spawn apagon;
        sleep 5;
        _city call deleteControles;

        if (!("CONVOY" in misiones)) then {
            _base = [_city call AS_fnc_location_position] call findBasesForConvoy;
            if ((_base != "") and (random 3 < 1)) then {
                [_city,_base,"city"] remoteExec ["CONVOY",HCattack];
            };
        };
    };
    if ((_AAFsupport > _FIAsupport) and (_side == "FIA")) then {
        [["TaskFailed", ["", format ["%1 joined AAF",[_city, false] call AS_fnc_getLocationName]]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
        _location call AS_fnc_location_updateMarker;
        [0,-5] remoteExec ["prestige",2];
        sleep 5;
        [_city, !_power] spawn apagon;
    };
} forEach call AS_fnc_location_cities;

// control the airport and have majority => win game.
if ((_FIAtotalPop > _AAFtotalPop) and ("AS_airport_3" call AS_fnc_location_side == "FIA")) exitWith {
    ["end1",true,true,true,true] remoteExec ["BIS_fnc_endMission",0]
};

// forEach factory, add to multiplier
{
    private _side = _x call AS_fnc_location_side;
    _power = [_x] call powerCheck;
    if ((_power) and (not(_x in destroyedCities))) then {
        if (_side == "FIA") then {_FIAResIncomeMultiplier = _FIAResIncomeMultiplier + 0.25};
        if (_side == "AAF") then {_AAFResIncomeMultiplier = _AAFResIncomeMultiplier + 0.25};
    };
} forEach ("factory" call AS_fnc_location_T);

// forEach resource, add to money
{
    private _side = _x call AS_fnc_location_side;
    _power = [_x] call powerCheck;
    if !(_x in destroyedCities) then {
        _powerMultiplier = 1;
        if (_power) then {
            _powerMultiplier = 3;
        };
        if (_side == "FIA") then {_FIAnewMoney = _FIAnewMoney + (100 * _powerMultiplier * _FIAResIncomeMultiplier)};
        if (_side == "AAF") then {_AAFnewMoney = _AAFnewMoney + (100 * _powerMultiplier * _AAFResIncomeMultiplier)};
    };
} forEach ("resource" call AS_fnc_location_T);

private _texto = format ["<t size='0.6' color='#C1C0BB'>Taxes Income.<br/> <t size='0.5' color='#C1C0BB'><br/>Manpower: +%1<br/>Money: +%2 €",round _FIAnewHR, round _FIAnewMoney];

_AAFnewMoney = AS_P("resourcesAAF") + round _AAFnewMoney;
_FIAnewMoney = AS_P("resourcesFIA") + round _FIAnewMoney;
_FIAnewHR = AS_P("hr") + round _FIAnewHR;

if (hayBE) then {
    if (_FIAnewHR > 0) then {
        _FIAnewHR = _FIAnewHR min (["HR"] call fnc_BE_permission);
    };
};

[[petros,"taxRep",_texto],"commsMP"] call BIS_fnc_MP;

AS_Pset("hr",_FIAnewHR);
AS_Pset("resourcesFIA",_FIAnewMoney);
AS_Pset("resourcesAAF",_AAFnewMoney);
