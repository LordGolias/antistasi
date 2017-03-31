removeHeadgear petros;
removeGoggles petros;
petros setSkill 1;
petros setVariable ["inconsciente",false,true];
petros setVariable ["respawning",false];

//[] remoteExec ["petrosAnimation", 2];
[] remoteExec ["fnc_rearmPetros", 2];

petros addEventHandler ["HandleDamage",
        {
        private ["_unit","_part","_dam","_injurer"];
        _part = _this select 1;
        _dam = _this select 2;
        _injurer = _this select 3;

        if (isPlayer _injurer) then
            {
            [_injurer,60] remoteExec ["castigo",_injurer];
            _dam = 0;
            };
        if ((isNull _injurer) or (_injurer == petros)) then {_dam = 0};
        if (_part == "") then
            {
            if (_dam > 0.95) then
                {
                if (!(petros getVariable "inconsciente")) then
                    {
                    _dam = 0.9;
                    [petros] spawn inconsciente;
                    }
                else
                    {
                    petros removeAllEventHandlers "HandleDamage";
                    };
                };
            };
        _dam
        }];

petros addMPEventHandler ["mpkilled",
    {
    removeAllActions petros;
    _killer = _this select 1;
    if (isServer) then
        {
            diag_log format ["[AS] INFO: Petros died. Killer: %1", _killer];
        if ((side _killer == side_red) or (side _killer == side_green)) then {
            [] spawn
                {
                garrison setVariable ["FIA_HQ",[],true];

				// remove 1/2 of every item.
				_cargo_w = getWeaponCargo caja;
				_cargo_m = getMagazineCargo caja;
				_cargo_i = getItemCargo caja;
				_cargo_b = getBackpackCargo caja;
				{
					_values = _x select 1;
					for "_i" from 0 to (count _values - 1) do {
						_new_value = floor ((_values select _i)/2.0);
						_values set [_i, _new_value];
					};
				} forEach [_cargo_w, _cargo_m, _cargo_i, _cargo_b];
				
				[caja, _cargo_w, _cargo_m, _cargo_i, _cargo_b, true, true] call AS_fnc_populateBox;

                [] remoteExec ["fnc_MAINT_arsenal", 2];

                waitUntil {sleep 6; isPlayer AS_commander};
                [] remoteExec ["placementSelection",AS_commander];
               };
            }
        else
            {
            _viejo = petros;
            grupoPetros = createGroup side_blue;
            publicVariable "grupoPetros";
            petros = grupoPetros createUnit ["B_G_officer_F", position _viejo, [], 0, "NONE"];
            grupoPetros setGroupId ["Petros","GroupColor4"];
            petros setIdentity "amiguete";
            petros setName "Petros";
            //petros disableAI "MOVE";
            //petros disableAI "AUTOTARGET";
            petros forceSpeed 0;
            [[Petros,"buildHQ"],"flagaction"] call BIS_fnc_MP;
            call compile preprocessFileLineNumbers "initPetros.sqf";
            deleteVehicle _viejo;
            publicVariable "petros";
            };
        };
   }];
