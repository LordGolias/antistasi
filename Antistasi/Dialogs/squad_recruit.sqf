private ["_display","_childControl","_coste","_costeHR","_unidades","_formato"];
if (!([player] call hasRadio)) exitWith {hint "You need a radio in your inventory to be able to give orders to other squads"};
createDialog "squad_recruit";

sleep 1;
disableSerialization;

_display = findDisplay 100;

if (str (_display) != "no display") then
{
	_ChildControl = _display displayCtrl 104;
	_coste = 0;
	_costeHR = 0;
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad");
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 105;
	_coste = 0;
	_costeHR = 0;
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam");
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 106;
	_coste = 0;
	_costeHR = 0;
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam_AT");
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 107;
	_coste = 0;
	_costeHR = 0;
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M");
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 108;
	_coste = 0;
	_costeHR = 0;
	_formato = (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSentry");
	_unidades = [_formato] call groupComposition;
	{_coste = _coste + (server getVariable _x); _costeHR = _costeHR +1} forEach _unidades;
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];


	_ChildControl = _display displayCtrl 109;
	_coste = (2*(server getVariable "B_G_Soldier_lite_F"));
	_costeHR = 2;
	_coste = _coste + (["B_G_Van_01_transport_F"] call vehiclePrice) + (["B_static_AT_F"] call vehiclePrice);
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 110;
	_coste = (2*(server getVariable "B_G_Soldier_lite_F"));
	_costeHR = 2;
	_coste = _coste + (["B_G_Van_01_transport_F"] call vehiclePrice) + (["B_static_AA_F"] call vehiclePrice);
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];

	_ChildControl = _display displayCtrl 111;
	_coste = (2*(server getVariable "B_G_Soldier_lite_F"));
	_costeHR = 2;
	_coste = _coste + (["B_G_Van_01_transport_F"] call vehiclePrice) + (["B_G_Mortar_01_F"] call vehiclePrice);
	_ChildControl  ctrlSetTooltip format ["Cost: %1 €. HR: %2",_coste,_costeHR];
};