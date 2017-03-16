
private ["_objetivos","_marcadores","_base","_objetivo","_cuenta","_aeropuerto","_datos","_prestigeOPFOR","_scoreLand","_scoreAir","_analizado","_garrison","_size","_estaticas","_salir"];

_objetivos = [];
_marcadores = [];
_cuentaFacil = 0;

_marcadores = mrkFIA - destroyedCities - controles - colinas - puestosFIA - ["FIA_HQ"];

_hayCSAT = true;

cuentaCA = cuentaCA + 600; //experimental

if ((random 100 > (server getVariable "prestigeCSAT")) or ({_x in bases} count mrkFIA == 0) || (server getVariable "blockCSAT")) then
	{
	_marcadores = _marcadores - ciudades;
	_hayCSAT = false;
	};

if (count _marcadores == 0) exitWith {};

_scoreLand = APCAAFcurrent + (5*tanksAAFcurrent);
_scoreAir = helisAAFcurrent + (5*planesAAFcurrent);
if (_hayCSAT) then {_scoreLand = _scoreLand + 15; _scoreAir = _scoreAir + 15};
//stavros sideChat format ["AAF Land forces: %1. AAF Air forces: %2",_scoreLand,_scoreAir];
_scoreNeededLandBase = 0;
_scoreNeededAirBase = 0;
if (count (unlockedWeapons - genATLaunchers) != count unlockedWeapons) then {_scoreNeededLandBase = 3};
if (count (unlockedWeapons - genAALaunchers) != count unlockedWeapons) then {_scoreNeededAirBase = 5};
{
_objetivo = _x;
_esFacil = false;

if (_objetivo in ciudades) then
	{
	_data = [_objetivo, ["prestigeBLUFOR", "prestigeOPFOR"]] call AS_fnc_getCityAttrs;
	_prestigeBLUFOR = _data select 0;
	_prestigeOPFOR = _data select 1;
	if ((_prestigeOPFOR == 0) and (_prestigeBLUFOR > 0)) then {_objetivos pushBack _objetivo};
	}
else
	{
	_base= [_objetivo,true] call findBasesForCA;
	_aeropuerto = [_objetivo,true] call findAirportsForCA;
	if ((_base != "") or (_aeropuerto != "")) then
		{
		_posObjetivo = getMarkerPos _objetivo;
		_scoreNeededLand = _scoreNeededLandBase;
		_scoreNeededAir = _scoreNeededAirBase;
		if (_base != "") then
			{
			_scoreNeededLand = _scoreNeededLand + 2 * ({(isOnRoad getMarkerPos _x) and (getMarkerPos _x distance _posObjetivo < distanciaSPWN)} count puestosFIA);
			};
		{
		if (getMarkerPos _x distance _posObjetivo < distanciaSPWN) then
			{
			_analizado = _x;
			_garrison = garrison getVariable [_analizado,[]];
			if (_base != "") then
				{
				_scoreNeededLand = _scoreNeededLand + (2*({(_x == "B_G_Soldier_A_F")} count _garrison)) + (floor((count _garrison)/8));
				if ((_analizado in bases) or (_analizado in aeropuertos)) then {_scoreNeededLand = _scoreNeededLand + 3};
				};
			if (_aeropuerto != "") then
				{
				_scoreNeededAir = _scoreNeededAir + (floor((count _garrison)/8));
				if ((_analizado in bases) or (_analizado in aeropuertos)) then {_scoreNeededAir = _scoreNeededAir + 3};
				};
			_size = [_analizado] call sizeMarker;
			_estaticas = staticsToSave select {_x distance (getMarkerPos _analizado) < _size};
			if (count _estaticas > 0) then
				{
				if (_base != "") then {_scoreNeededLand = _scoreNeededLand + ({typeOf _x in allStatMortars} count _estaticas) + (2*({typeOf _x in allStatATs} count _estaticas))};
				if (_aeropuerto != "") then {_scoreNeededAir = _scoreNeededAir + ({typeOf _x in allStatMGs} count _estaticas) + (5*({typeOf _x in allStatAAs} count _estaticas))}
				};
			};
		} forEach _marcadores;
		//if (debug) then {hint format ["Marcador: %1. ScoreneededLand: %2. ScoreneededAir: %3. ScoreLand: %4. ScoreAir: %5",_objetivo, _scoreNeededLand, _scoreNeededAir,_scoreLand,_scoreAir]; sleep 5};
		if (_scoreNeededLand > _scoreLand) then
			{
			_base = "";
			}
		else
			{
			if ((_base != "") and (_scoreNeededLand < 4)) then
				{
				if (((count (garrison getVariable [_objetivo,[]])) < 4) and (_cuentaFacil < 4)) then
					{
					if ((not(_objetivo in bases)) and (not(_objetivo in aeropuertos))) then
						{
						_esFacil = true;
						if (!(_objetivo in smallCAmrk)) then
							{
							//if (debug) then {hint format ["%1 Es facil para bases",_objetivo]; sleep 5};
							_cuentaFacil = _cuentaFacil + 2;
							[_objetivo,_base] remoteExec ["patrolCA",HCattack];
							sleep 15;
							};
						};
					};
				};
			};
		if (_scoreNeededAir > _scoreAir) then
			{
			_aeropuerto = "";
			}
		else
			{
			if ((_aeropuerto != "") and (_base == "") and (!_esFacil) and (_scoreNeededAir < 4)) then
				{
				if (((count (garrison getVariable [_objetivo,[]])) < 4) and (_cuentaFacil < 4)) then
					{
					if ((not(_objetivo in bases)) and (not(_objetivo in aeropuertos))) then
						{
						_esFacil = true;
						if (!(_objetivo in smallCAmrk)) then
							{
							//if (debug) then {hint format ["%1 Es facil para aire",_objetivo]; sleep 5};
							_cuentaFacil = _cuentaFacil + 1;
							[_objetivo,_aeropuerto] remoteExec ["patrolCA",HCattack];
							sleep 15;
							};
						};
					};
				};
			};
		//stavros globalChat format ["Marcador: %1. ScoreNeededLand: %2. ScoreLand: %3. ScoreNeededAir: %4. ScoreAir: %5",_objetivo,_scoreNeededLand,_scoreLand,_scoreNeededAir,_scoreAir]; sleep 5;
		if (((_base != "") or (_aeropuerto != "")) and (!_esFacil)) then
			{
			_cuenta = 1;
			if ((_objetivo in power) or (_objetivo in fabricas)) then {_cuenta = 4};
			if ((_objetivo in bases) or (_objetivo in aeropuertos)) then {_cuenta = 5};
			if (_objetivo in recursos) then {_cuenta = 3};
			if (_base != "") then
				{
				if (_aeropuerto != "") then {_cuenta = _cuenta *2};
				if (_objetivo == [_marcadores,_base] call bis_fnc_nearestPosition) then {_cuenta = _cuenta *2};
				};
			for "_i" from 1 to _cuenta do
				{
				_objetivos pushBack _objetivo;
				}
			};
		};
	};
} forEach _marcadores;

if ((count _objetivos > 0) and (_cuentaFacil < 3)) then
	{
	_objetivo = selectRandom _objetivos;
	if (not(_objetivo in ciudades)) then {[_objetivo] remoteExec ["combinedCA",HCattack]} else {[_objetivo] remoteExec ["CSATpunish",HCattack]};
	cuentaCA = cuentaCA - 600; //experimental
	};
if (not("CONVOY" in misiones)) then
	{
	if (count _objetivos == 0) then
		{
		{
		_base = [_x] call findBasesForConvoy;
		if (_base != "") then
			{
			_data = [_x, ["prestigeBLUFOR", "prestigeOPFOR"]] call AS_fnc_getCityAttrs;
			_prestigeBLUFOR = _data select 0;
			_prestigeOPFOR = _data select 1;
			if (_prestigeOPFOR + _prestigeBLUFOR < 95) then
				{
				_objetivos pushBack [_x,_base];
				};
			};
		} forEach (ciudades - mrkAAF);
		if (count _objetivos > 0) then
			{
			_objetivo = selectRandom _objetivos;
			[(_objetivo select 0),(_objetivo select 1),"civ"] remoteExec ["CONVOY",HCattack];
			};
		};
	};
