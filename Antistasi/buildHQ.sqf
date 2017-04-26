private ["_pos","_rnd"];
_movido = false;
if (group petros != grupoPetros) then {
	_movido = true;
	[petros] join grupoPetros;
};
[[petros,"remove"],"flagaction"] call BIS_fnc_MP;
petros forceSpeed 0;

["FIA_HQ","position",getPos petros] call AS_fnc_location_set;
"FIA_HQ" call AS_fnc_location_updateMarker;

if (isMultiplayer) then
	{
	caja hideObjectGlobal false;
	cajaVeh hideObjectGlobal false;
	mapa hideObjectGlobal false;
	fuego hideObjectGlobal false;
	bandera hideObjectGlobal false;
	}
else
	{
	if (_movido) then {hint "Please wait while moving HQ Assets to selected position"};
	//sleep 5
	caja hideObject false;
	cajaVeh hideObject false;
	mapa hideObject false;
	fuego hideObject false;
	bandera hideObject false;
	};
fuego inflame true;
call AS_fnc_placeHQdefault;
if (_movido) then {[] call vaciar};
placementDone = true; publicVariable "placementDone";
sleep 5;
[[Petros,"mission"],"flagaction"] call BIS_fnc_MP;
