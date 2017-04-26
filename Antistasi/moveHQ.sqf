if (player != AS_commander) exitWith {hint "Only Commander AS_commander has access to this function"};

if ((count weaponCargo caja >0) or (count magazineCargo caja >0) or (count itemCargo caja >0) or (count backpackCargo caja >0)) exitWith {hint "You must first empty your Ammobox in order to move the HQ"};

petros enableAI "MOVE";
petros enableAI "AUTOTARGET";
petros forceSpeed -1;

[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
//removeAllActions petros;
[] remoteExec ["fnc_rearmPetros", 2];
[petros] join AS_commander;
petros setBehaviour "AWARE";
if (isMultiplayer) then
	{
	caja hideObjectGlobal true;
	cajaVeh hideObjectGlobal true;
	mapa hideObjectGlobal true;
	fuego hideObjectGlobal true;
	bandera hideObjectGlobal true;
	}
else
	{
	caja hideObject true;
	cajaVeh hideObject true;
	mapa hideObject true;
	fuego hideObject true;
	bandera hideObject true;
	};

fuego inflame false;

if !(isNil "vehiclePad") then {
	[vehiclePad, {deleteVehicle _this}] remoteExec ["call", 0];
	[vehiclePad, {vehiclePad = nil}] remoteExec ["call", 0];
	server setVariable ["AS_vehicleOrientation", 0, true];
};

private _garrison = ["FIA_HQ", "garrison"] call AS_fnc_location_get;
private _posicion = "FIA_HQ" call AS_fnc_location_position;
private _size = "FIA_HQ" call AS_fnc_location_size;
if (count _garrison > 0) then
	{
	_coste = 0;
	_hr = 0;
	if ({(alive _x) and (!captive _x) and ((side _x == side_green) or (side _x == side_red)) and (_x distance _posicion < 500)} count allUnits > 0) then
		{
		hint "HQ Garrison will stay here and hold the enemy";
		}
	else {
		{
		if ((side _x == side_blue) and (not(_x getVariable ["BLUFORSpawn",false])) and (_x distance _posicion < _size) and (_x != petros)) then
			{
			if (!alive _x) then
				{
				if (typeOf _x in AS_allFIASoldierClasses) then
					{
					if (typeOf _x == "Crew") then {_coste = _coste - (["B_G_Mortar_01_F"] call FIAvehiclePrice)};
					_hr = _hr - 1;
					_coste = _coste - (AS_data_allCosts getVariable ([_x] call AS_fnc_getFIAUnitNameType));
					};
				};
			if (typeOf (vehicle _x) == "B_G_Mortar_01_F") then {deleteVehicle vehicle _x};
			deleteVehicle _x;
			};
		} forEach allUnits;
		};
	{
	if (_x == "Crew") then {_coste = _coste + (["B_G_Mortar_01_F"] call FIAvehiclePrice)};
	_hr = _hr + 1;
	_coste = _coste + (AS_data_allCosts getVariable _x);
	} forEach _garrison;
	[_hr,_coste] remoteExec ["resourcesFIA",2];
	hint format ["Garrison removed\n\nRecovered Money: %1 €\nRecovered HR: %2",_coste,_hr];
	};

sleep 5;

[[Petros,"buildHQ"],"flagaction"] call BIS_fnc_MP;
