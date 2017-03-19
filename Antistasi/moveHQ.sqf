if (player != Stavros) exitWith {hint "Only Commander Stavros has access to this function"};

if ((count weaponCargo caja >0) or (count magazineCargo caja >0) or (count itemCargo caja >0) or (count backpackCargo caja >0)) exitWith {hint "You must first empty your Ammobox in order to move the HQ"};

petros enableAI "MOVE";
petros enableAI "AUTOTARGET";
petros forceSpeed -1;

[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
//removeAllActions petros;
[true] remoteExecCall ["fnc_togglePetrosAnim", 2];
[petros] join stavros;
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

//"respawn_west" setMarkerPos [0,0,0];
"respawn_west" setMarkerAlpha 0;
_garrison = garrison getVariable ["FIA_HQ", []];
_posicion = getMarkerPos "FIA_HQ";
if (count _garrison > 0) then
	{
	_coste = 0;
	_hr = 0;
	if ({(alive _x) and (!captive _x) and ((side _x == side_green) or (side _x == side_red)) and (_x distance _posicion < 500)} count allUnits > 0) then
		{
		hint "HQ Garrison will stay here and hold the enemy";
		}
	else
		{
		_size = ["FIA_HQ"] call sizeMarker;
		{
		if ((side _x == side_blue) and (not(_x getVariable ["BLUFORSpawn",false])) and (_x distance _posicion < _size) and (_x != petros)) then
			{
			if (!alive _x) then
				{
				if (typeOf _x in soldadosFIA) then
					{
					if (typeOf _x == "b_g_soldier_unarmed_f") then {_coste = _coste - (["B_G_Mortar_01_F"] call vehiclePrice)};
					_hr = _hr - 1;
					_coste = _coste - (server getVariable (typeOf _x));
					};
				};
			if (typeOf (vehicle _x) == "B_G_Mortar_01_F") then {deleteVehicle vehicle _x};
			deleteVehicle _x;
			};
		} forEach allUnits;
		};
	{
	if (_x == "b_g_soldier_unarmed_f") then {_coste = _coste + (["B_G_Mortar_01_F"] call vehiclePrice)};
	_hr = _hr + 1;
	_coste = _coste + (server getVariable _x);
	} forEach _garrison;
	[_hr,_coste] remoteExec ["resourcesFIA",2];
	garrison setVariable ["FIA_HQ",[],true];
	hint format ["Garrison removed\n\nRecovered Money: %1 €\nRecovered HR: %2",_coste,_hr];
	};

sleep 5;

[[Petros,"buildHQ"],"flagaction"] call BIS_fnc_MP;