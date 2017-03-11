//NOTA: TAMBIÉN LO USO PARA FIA
if (!isServer and hasInterface) exitWith{};

_marcador = _this select 0;

_grupos = [];
_soldados = [];

_posicion = getMarkerPos (_marcador);

_num = [_marcador] call sizeMarker;

_num = round (_num / 100);

private ["_grupo","_grp","_params","_datos","_prestigeOPFOR","_prestigeBLUFOR"];

_datos = server getVariable _marcador;
//_prestigeOPFOR = _datos select 3;
//_prestigeBLUFOR = _datos select 4;
_prestigeOPFOR = _datos select 2;
_prestigeBLUFOR = _datos select 3;
_esAAF = true;
if (_marcador in mrkAAF) then
	{
	_num = round (_num * ((_prestigeOPFOR + _prestigeBLUFOR)/100));
	_frontera = [_marcador] call isFrontline;
	if (_frontera) then {_num = _num * 2};
	_tipoGrupo = [infGarrisonSmall, side_green] call fnc_pickGroup;
	_params = [_posicion, side_green, _tipogrupo];

	if (random 10 < 5) then {
		_tipoGrupo = [opGroup_Sniper, side_red] call fnc_pickGroup;
		_grupoCSAT = [_posicion, side_red, _tipoGrupo] call BIS_Fnc_spawnGroup;
		[leader _grupoCSAT, _marcador, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
		{[_x] spawn CSATinit; _soldados = _soldados + [_x]} forEach units _grupoCSAT;
		_grupos = _grupos + [_grupoCSAT];
	};
	}
else
	{
	_esAAF = false;
	_num = round (_num * (_prestigeBLUFOR/100));
	_params = [_posicion, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSentry")];
	};

if (_num < 1) then {_num = 1};

_cuenta = 0;
while {(spawner getVariable _marcador) and (_cuenta < _num)} do
	{
	_grupo = _params call BIS_Fnc_spawnGroup;
	{[_x] spawn genInitBASES; _soldados = _soldados + [_x]} forEach units _grupo;
	sleep 1;
	if (_esAAF) then {
		if (random 10 < 2.5) then
			{
			_perro = _grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"];
			[_perro] spawn guardDog;
			_soldados pushBack _perro;
			};
	};
	[leader _grupo, _marcador, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
	_grupos = _grupos + [_grupo];
	_cuenta = _cuenta + 1;
	};

if !(_esAAF) then
	{
	{_grp = _x;
	{[_x] spawn FIAinitBASES; _soldados = _soldados + [_x]} forEach units _grp;} forEach _grupos;
	};

waitUntil {sleep 1;(not (spawner getVariable _marcador)) or ({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)};

if ((({alive _x} count _soldados == 0) or ({fleeing _x} count _soldados == {alive _x} count _soldados)) and (_marcador in mrkAAF)) then
	{
	[_posicion] remoteExec ["patrolCA",HCattack];
	};

waitUntil {sleep 1;not (spawner getVariable _marcador)};

{if (alive _x) then {deleteVehicle _x}} forEach _soldados;
{deleteGroup _x} forEach _grupos;