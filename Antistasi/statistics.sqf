#include "macros.hpp"
private ["_texto","_viejoTexto","_display","_setText"];
if (!isNil "showStatistics") exitWith {};
showStatistics = true;
disableSerialization;
//1 cutRsc ["H8erHUD","PLAIN",0,false];
_layer = ["estadisticas"] call bis_fnc_rscLayer;
_layer cutRsc ["H8erHUD","PLAIN",0,false];
waitUntil {!isNull (uiNameSpace getVariable "H8erHUD")};

_display = uiNameSpace getVariable "H8erHUD";
_setText = _display displayCtrl 1001;
_setText ctrlSetBackgroundColor [0,0,0,0];
_viejoTexto = "";
if (isMultiplayer) then
	{
	private ["_nombreC"];
	while {showStatistics} do
		{
		waitUntil {sleep 0.5; player == player getVariable ["owner",player]};
		if (player != AS_commander) then {
			if (isPlayer AS_commander) then {_nombreC = name AS_commander} else {_nombreC = "NONE"};
			_texto = format ["<t size='0.55'>" + "Commander: %3 | %2 | HR: %1 | Your Money: %4 € | NATO Support: %5 | CSAT Support: %6 | %7 | %8", AS_P("hr"), player getVariable ["Rank_PBar", "Init"], _nombreC, player getVariable "dinero",AS_P("PrestigeNATO"), AS_P("prestigeCSAT"), server getVariable "BE_PBar", ["Overt", "<t color='#1DA81D'>Incognito</t>"] select (captive player)];
		}
		else {
			_texto = format ["<t size='0.55'>" + "%5 | HR: %1 | Your Money: %6 € | FIA Money: %2 € | NATO Support: %3 | CSAT Support: %4 | %7 | %8", AS_P("hr"), AS_P("resourcesFIA"), AS_P("PrestigeNATO"), AS_P("prestigeCSAT"), player getVariable ["Rank_PBar", "Init"], player getVariable "dinero", server getVariable "BE_PBar", ["Overt", "<t color='#1DA81D'>Incognito</t>"] select (captive player)];
		};
		//if (captive player) then {_texto = format ["%1 ON",_texto]} else {_texto = format ["%1 OFF",_texto]};
		if (_texto != _viejoTexto) then
			{
			//[_texto,-0.1,-0.4,601,0,0,5] spawn bis_fnc_dynamicText;
			_setText ctrlSetStructuredText (parseText format ["%1", _texto]);
			_setText ctrlCommit 0;
			_viejoTexto = _texto;
			};
		if (player == leader (group player)) then
			{
			if (not(group player in (hcAllGroups player))) then {player hcSetGroup [group player]};
			};
		sleep 1;
		};
	}
else
	{
	while {showStatistics} do
		{
		waitUntil {sleep 0.5; player == player getVariable ["owner",player]};
		_texto = format ["<t size='0.55'>" + "HR: %1 | FIA Money: %2 € | NATO Support: %3 | CSAT Support: %4 | %5 | %6", AS_P("hr"), AS_P("resourcesFIA"), AS_P("PrestigeNATO"), AS_P("prestigeCSAT"), server getVariable "BE_PBar", ["Overt", "<t color='#1DA81D'>Incognito</t>"] select (captive player)];
		//if (captive player) then {_texto = format ["%1 ON",_texto]} else {_texto = format ["%1 OFF",_texto]};
		if (_texto != _viejoTexto) then
			{
			//[_texto,-0.1,-0.4,601,0,0,5] spawn bis_fnc_dynamicText;
			_setText ctrlSetStructuredText (parseText format ["%1", _texto]);
			_setText ctrlCommit 0;
			_viejoTexto = _texto;
			};
		sleep 1;
		};
	};
