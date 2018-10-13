_pos = _this select 0;

{
	if ((side _x == ("FIA" call AS_fnc_getFactionSide)) and (_x distance _pos < 20)) then {
		if (hasACE) then {
      		[_x, _x] call ace_medical_fnc_treatmentAdvanced_fullHeal;
    	} else {
      		_x setDamage 0;
		};
	};
} forEach allUnits;

hint "Your stomach stopped growling.\n\n Get back in the fight, soldier!";
