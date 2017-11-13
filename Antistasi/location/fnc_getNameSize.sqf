params ["_name", "_min"];
private _sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusA");
private _sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> _name >> "radiusB");
(_sizeX max _sizeY) max _min
