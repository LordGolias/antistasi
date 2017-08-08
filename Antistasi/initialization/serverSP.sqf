HCciviles = 2;
HCgarrisons = 2;
HCattack = 2;
hcArray = [HC1,HC2,HC3];
publicVariable "HCciviles";
publicVariable "HCgarrisons";
publicVariable "HCattack";
publicVariable "hcArray";

[] execVM "Scripts\fn_advancedTowingInit.sqf"; // the installation is done for all clients by this
[] execVM "modBlacklist.sqf";
