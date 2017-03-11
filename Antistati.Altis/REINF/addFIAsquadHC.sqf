
if (player != Stavros) exitWith {hint "Only Commander Stavros has access to this function"};
if (!allowPlayerRecruit) exitWith {hint "Server is very loaded. \nWait one minute or change FPS settings in order to fulfill this request"};
if (markerAlpha "respawn_west" == 0) exitWith {hint "You cant recruit a new squad while you are moving your HQ"};
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};
_chequeo = false;
{
	if (((side _x == side_red) or (side _x == side_green)) and (_x distance petros < 500) and (not(captive _x))) then {_chequeo = true};
} forEach allUnits;

if (_chequeo) exitWith {Hint "You cannot Recruit Squads with enemies near your HQ"};

private ["_tipogrupo","_esinf","_tipoVeh","_coste","_costeHR","_exit","_formato","_pos","_hr","_resourcesFIA","_grupo","_roads","_road","_grupo","_camion","_vehicle","_mortero","_morty"];


_tipogrupo = _this select 0;
_esinf = false;
_tipoVeh = "";
_coste = 0;
_costeHR = 0;
_exit = false;
_formato = "";

_hr = server getVariable "hr";
_resourcesFIA = server getVariable "resourcesFIA";

private ["_grupo","_roads","_camion"];

if ((_tipogrupo == "IRG_InfSquad") or (_tipogrupo == "IRG_InfTeam") or (_tipogrupo == "IRG_InfTeam_AT") or (_tipogrupo == "IRG_SniperTeam_M") or (_tipogrupo == "IRG_InfSentry")) then
	{
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> _tipogrupo);
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;

	//if (_costeHR > 4) then {_tipoVeh = "B_G_Van_01_transport_F"} else {_tipoVeh = "B_G_Offroad_01_F"};
	//_coste = _coste + ([_tipoVeh] call vehiclePrice);
	_esinf = true;
	}
else
	{
	_coste = _coste + (2*(server getVariable "B_G_Soldier_lite_F"));
	_costeHR = 2;
	_coste = _coste + ([_tipogrupo] call vehiclePrice) + (["B_G_Van_01_transport_F"] call vehiclePrice);

	if ((hayRHS) && (_tipogrupo == "B_static_AA_F")) then {
		_coste = 3*(server getVariable "B_G_Soldier_lite_F");
		_costeHR = 3;
		_coste = _coste + ([vehTruckAA] call vehiclePrice);
	};
};

if (_hr < _costeHR) then {_exit = true;hint format ["You do not have enough HR for this request (%1 required)",_costeHR]};

if (_resourcesFIA < _coste) then {_exit = true;hint format ["You do not have enough money for this request (%1 € required)",_coste]};

if (_exit) exitWith {};

[- _costeHR, - _coste] remoteExec ["resourcesFIA",2];

_pos = getMarkerPos "respawn_west";
_tam = 10;
while {true} do
	{
	_roads = _pos nearRoads _tam;
	if (count _roads < 1) then {_tam = _tam + 10};
	if (count _roads > 0) exitWith {};
	};
_road = _roads select 0;

if (hayRHS) then {
	if (_esinf) then {
		_pos = [(getMarkerPos "respawn_west"), 30, random 360] call BIS_Fnc_relPos;
		_grupo = [_pos, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> _tipogrupo)] call BIS_Fnc_spawnGroup;
		if (_tipogrupo == "IRG_InfSquad") then {_formato = "Squd-"};
		if (_tipogrupo == "IRG_InfTeam") then {_formato = "Tm-"};
		if (_tipogrupo == "IRG_InfTeam_AT") then {_formato = "AT-"};
		if (_tipogrupo == "IRG_SniperTeam_M") then {_formato = "Snpr-"};
		if (_tipogrupo == "IRG_InfSentry") then {_formato = "Stry-"};
		_formato = format ["%1%2",_formato,{side (leader _x) == side_blue} count allGroups];
		_grupo setGroupId [_formato];
		}
	else {
		_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
		if (_tipogrupo == "B_static_AA_F") then {
			_vehicle=[_pos, 0, vehTruckAA, side_blue] call bis_fnc_spawnvehicle;
			_veh = _vehicle select 0;
			_vehCrew = _vehicle select 1;
			{deleteVehicle _x} forEach crew _veh;
			_grupo = _vehicle select 2;
			[_veh] spawn VEHinit;
			_driv = _grupo createUnit ["b_g_soldier_unarmed_f", _pos, [],0, "NONE"];
			_driv moveInDriver _veh;
			driver _veh action ["engineOn", vehicle driver _veh];
			_gun = _grupo createUnit ["b_g_soldier_unarmed_f", _pos, [],0, "NONE"];
			_gun moveInGunner _veh;
			_com = _grupo createUnit ["b_g_soldier_unarmed_f", _pos, [],0, "NONE"];
			_com moveInCommander _veh;
			_grupo setGroupId [format ["M.AA-%1",{side (leader _x) == side_blue} count allGroups]];
		}
		else {
			_vehicle=[_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
			_camion = _vehicle select 0;
			_grupo = _vehicle select 2;
			_pos = _pos findEmptyPosition [1,30,"B_G_Mortar_01_F"];
			_attachPos = [0,-1.5,0.2];
			if (_tipogrupo == "B_static_AT_F") then {
				_mortero = "rhs_SPG9M_MSV" createVehicle _pos;
				_attachPos = [0,-2.4,-0.6];
			}
			else {
				_mortero = _tipogrupo createVehicle _pos;
			};

			//_mortero = "rhs_SPG9M_MSV" createVehicle _pos;
			[_mortero] spawn VEHinit;
			_morty = _grupo createUnit ["b_g_soldier_unarmed_f", _pos, [],0, "NONE"];
			//_mortero attachTo [_camion,[0,-1.5,0.2]];
			//_mortero setDir (getDir _camion + 180);
			_grupo setVariable ["staticAutoT",false,true];
			if (_tipogrupo == "B_G_Mortar_01_F") then {
				_morty moveInGunner _mortero;
				[_morty,_camion,_mortero] spawn mortyAI;
				_grupo setGroupId [format ["Mort-%1",{side (leader _x) == side_blue} count allGroups]];
				}
			else {
				//_mortero attachTo [_camion,[0,-2.4,-0.6]];
				_mortero attachTo [_camion,_attachPos];
				_mortero setDir (getDir _camion + 180);
				_morty moveInGunner _mortero;
				/*
				_mortero attachTo [_camion,[0,-1.5,0.2]];
				_mortero setDir (getDir _camion + 180);
				_morty moveInGunner _mortero;
				*/
				if (_tipogrupo == "B_static_AT_F") then {_grupo setGroupId [format ["M.AT-%1",{side (leader _x) == side_blue} count allGroups]]};
				//if (_tipogrupo == "B_static_AA_F") then {_grupo setGroupId [format ["M.AA-%1",{side (leader _x) == side_blue} count allGroups]]};
				};
		driver _camion action ["engineOn", vehicle driver _camion];
		[_camion] spawn VEHinit;
		};

	};



}
else {

if (_esinf) then
	{
	//_camion = _tipoveh createVehicle _pos;
	_pos = [(getMarkerPos "respawn_west"), 30, random 360] call BIS_Fnc_relPos;
	_grupo = [_pos, side_blue, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> _tipogrupo)] call BIS_Fnc_spawnGroup;
	if (_tipogrupo == "IRG_InfSquad") then {_formato = "Squd-"};
	if (_tipogrupo == "IRG_InfTeam") then {_formato = "Tm-"};
	if (_tipogrupo == "IRG_InfTeam_AT") then {_formato = "AT-"};
	if (_tipogrupo == "IRG_SniperTeam_M") then {_formato = "Snpr-"};
	if (_tipogrupo == "IRG_InfSentry") then {_formato = "Stry-"};
	_formato = format ["%1%2",_formato,{side (leader _x) == side_blue} count allGroups];
	_grupo setGroupId [_formato];
	//[_grupo] spawn dismountFIA;
	//_grupo addVehicle _camion;
	}
else
	{
	_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
	_vehicle=[_pos, 0,"B_G_Van_01_transport_F", side_blue] call bis_fnc_spawnvehicle;
	_camion = _vehicle select 0;
	_grupo = _vehicle select 2;
	_pos = _pos findEmptyPosition [1,30,"B_G_Mortar_01_F"];
	_mortero = _tipogrupo createVehicle _pos;
	[_mortero] spawn VEHinit;
	_morty = _grupo createUnit ["b_g_soldier_unarmed_f", _pos, [],0, "NONE"];
	//_mortero attachTo [_camion,[0,-1.5,0.2]];
	//_mortero setDir (getDir _camion + 180);
	_grupo setVariable ["staticAutoT",false,true];
	if (_tipogrupo == "B_G_Mortar_01_F") then
		{
		_morty moveInGunner _mortero;
		[_morty,_camion,_mortero] spawn mortyAI;
		_grupo setGroupId [format ["Mort-%1",{side (leader _x) == side_blue} count allGroups]];
		//artyFIA synchronizeObjectsAdd [_morty];
		//_morty synchronizeObjectsAdd [artyFIA];
		//[player, apoyo, artyFIA] call BIS_fnc_addSupportLink;
		}
	else
		{
		_mortero attachTo [_camion,[0,-1.5,0.2]];
		_mortero setDir (getDir _camion + 180);
		_morty moveInGunner _mortero;
		if (_tipogrupo == "B_static_AT_F") then {_grupo setGroupId [format ["M.AT-%1",{side (leader _x) == side_blue} count allGroups]]};
		if (_tipogrupo == "B_static_AA_F") then {_grupo setGroupId [format ["M.AA-%1",{side (leader _x) == side_blue} count allGroups]]};
		};
	driver _camion action ["engineOn", vehicle driver _camion];
	[_camion] spawn VEHinit;
	};

};

{[_x] call FIAinit} forEach units _grupo;
leader _grupo setBehaviour "SAFE";
Stavros hcSetGroup [_grupo];
_grupo setVariable ["isHCgroup", true, true];
petros directSay "SentGenReinforcementsArrived";
hint format ["Group %1 at your command.\n\nGroups are managed from the High Command bar (Default: CTRL+SPACE)\n\nIf the group gets stuck, use the AI Control feature to make them start moving. Mounted Static teams tend to get stuck (solving this is WiP)\n\nTo assign a vehicle for this group, look at some vehicle, and use Vehicle Squad Mngmt option in Y menu", groupID _grupo];

if (!_esinf) exitWith {};

if (_tipogrupo == "IRG_InfSquad") then
	{
	_tipoVeh = "B_G_Van_01_transport_F";
	}
else
	{
	if ((_tipogrupo == "IRG_SniperTeam_M") or (_tipogrupo == "IRG_InfSentry")) then
		{
		_tipoVeh = "B_G_Quadbike_01_F";
		}
	else
		{
		_tipoVeh = "B_G_Offroad_01_F";
		};
	};

_coste = [_tipoVeh] call vehiclePrice;
private ["_display","_childControl"];
if (_coste > server getVariable "resourcesFIA") exitWith {};

createDialog "veh_query";

sleep 1;
disableSerialization;

_display = findDisplay 100;

if (str (_display) != "no display") then
	{
	_ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format ["Buy a vehicle for this squad for %1 €",_coste];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip "Barefoot Infantry";
	};

waitUntil {(!dialog) or (!isNil "vehQuery")};

if ((!dialog) and (isNil "vehQuery")) exitWith {};

//if (!vehQuery) exitWith {vehQuery = nil};

vehQuery = nil;
//_resourcesFIA = server getVariable "resourcesFIA";
//if (_resourcesFIA < _coste) exitWith {hint format ["You do not have enough money for this vehicle: %1 € required",_coste]};
_pos = position _road findEmptyPosition [1,30,"B_G_Van_01_transport_F"];
_mortero = _tipoVeh createVehicle _pos;
[_mortero] spawn VEHinit;
_grupo addVehicle _mortero;
_mortero setVariable ["owner",_grupo,true];
[0, - _coste] remoteExec ["resourcesFIA",2];
leader _grupo assignAsDriver _mortero;
{[_x] orderGetIn true; [_x] allowGetIn true} forEach units _grupo;
hint "Vehicle Purchased";
petros directSay "SentGenBaseUnlockVehicle";
