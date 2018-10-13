#include "macros.hpp"
AS_SERVER_ONLY("fnc_initPetros.sqf");

if (!isNil "petros") then {
    deleteVehicle petros;
    deleteGroup grupoPetros;
};

grupoPetros = createGroup ("FIA" call AS_fnc_getFactionSide);
petros = ["Squad Leader", getMarkerPos "FIA_HQ", grupoPetros] call AS_fnc_spawnFIAunit;
[petros, "FIA"] call AS_fnc_setSide;
[[petros,"mission"],"AS_fnc_addAction"] call BIS_fnc_MP;
grupoPetros setGroupId ["Petros","GroupColor4"];
petros setName "Petros";
petros disableAI "MOVE";
petros disableAI "AUTOTARGET";
petros setUnitPos "UP";

removeHeadgear petros;
removeGoggles petros;
petros setSkill 1;

// rearmPetros depends on the side weapons, which are defined afterwards
[] spawn {
    waitUntil {sleep 0.5; not isNil "AAFWeapons"};
    call AS_fnc_rearmPetros;
};

petros addEventHandler ["HandleDamage",
        {
        private ["_part","_dam","_injurer"];
        _part = _this select 1;
        _dam = _this select 2;
        _injurer = _this select 3;

        if (isPlayer _injurer) then
            {
            [_injurer,60] remoteExec ["AS_fnc_penalizePlayer",_injurer];
            _dam = 0;
            };
        if ((isNull _injurer) or (_injurer == petros)) then {_dam = 0};
        if (_part == "") then
            {
            if (_dam > 0.95) then
                {
                if (!(petros call AS_medical_fnc_isUnconscious)) then
                    {
                    _dam = 0.9;
                    [petros, true] call AS_medical_fnc_setUnconscious;
                    }
                else
                    {
                    petros removeAllEventHandlers "HandleDamage";
                    };
                };
            };
        _dam
        }];

petros addMPEventHandler ["mpkilled", {
    removeAllActions petros;
    private _killer = _this select 1;
    if isServer then {
        diag_log format ["[AS] INFO: Petros died. Killer: %1", _killer];
        if (side _killer == ("AAF" call AS_fnc_getFactionSide)) then {
            [] spawn {
                ["FIA_HQ", "garrison", []] call AS_location_fnc_set;

				// remove 1/2 of every item.
                waitUntil {not AS_S("lockTransfer")};
                AS_Sset("lockTransfer", true);
				([caja, true] call AS_fnc_getBoxArsenal) params ["_cargo_w", "_cargo_m", "_cargo_i", "_cargo_b"];
				{
					private _values = _x select 1;
					for "_i" from 0 to (count _values - 1) do {
						private _new_value = floor ((_values select _i)/2.0);
						_values set [_i, _new_value];
					};
				} forEach [_cargo_w, _cargo_m, _cargo_i, _cargo_b];

				[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;
                AS_Sset("lockTransfer", false);

                waitUntil {sleep 5; isPlayer AS_commander};
                [] remoteExec ["AS_fnc_selectNewHQ", AS_commander];
            };
        } else {
            call AS_fnc_initPetros;
        };
    };
}];

publicVariable "grupoPetros";
publicVariable "petros";
