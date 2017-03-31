if !(isPlayer AS_commander) exitWith {};

private ["_veh","_tipo"];
_veh = _this select 0;
_tipo = typeOf _veh;

if ((_tipo in vehAPC) or (_tipo in vehIFV)) then {
	APCAAFcurrent = APCAAFcurrent -1;
	if (APCAAFcurrent < 1) then
		{
		if (APCAAFcurrent < 0) then {APCAAFcurrent = 0};
		vehAAFAT = vehAAFAT - vehAPC - vehIFV;
		publicVariable "vehAAFAT";
		};
	publicVariable "APCAAFcurrent";
	}
else {
	if (_tipo in vehTank) then
		{
		tanksAAFcurrent = tanksAAFcurrent - 1;
		if (tanksAAFcurrent < 1) then
			{
			if (tanksAAFcurrent < 0) then {tanksAAFcurrent = 0};
			vehAAFAT = vehAAFAT - vehTank;
			publicVariable "vehAAFAT";
			};
		publicVariable "tanksAAFcurrent";
		}
	else
		{
		if (_veh isKindOf "Helicopter") then
			{
			helisAAFcurrent = helisAAFcurrent -1;
			if (helisAAFcurrent < 1) then
				{
				if (helisAAFcurrent < 0) then {helisAAFcurrent = 0};
				planesAAF = planesAAF - heli_armed;
				publicVariable "planesAAF";
				};
			publicVariable "helisAAFcurrent";
			}
		else
			{
			planesAAFcurrent = planesAAFcurrent - 1;
			if (planesAAFcurrent < 1) then
				{
				if (planesAAFcurrent < 0) then {planesAAFcurrent = 0};
				planesAAF = planesAAF - planes;
				publicVariable "planesAAF";
				};
			publicVariable "planesAAFcurrent";
			};
		};
	};
