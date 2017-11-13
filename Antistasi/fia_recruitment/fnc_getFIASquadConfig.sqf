params ["_type"];
configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> ([_type] call AS_fnc_getFIASquadClass)
