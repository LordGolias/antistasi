#include "../macros.hpp"
AS_SERVER_ONLY("fnc_HQAddObject.sqf");
params ["_objType"];

if (_objType == "delete") exitWith {
	call fnc_deletePad;
	{
		deleteVehicle _x;
	} foreach AS_HQ_placements;
	AS_HQ_placements = [];
};

if (_objType == "pad") exitWith {
	call fnc_deletePad;
	{
		if (str typeof _x find "Land_Bucket_painted_F" > -1) then {
			[_x, {deleteVehicle _this}] remoteExec ["call", 0];
		};
	} forEach nearestObjects [petros, [], 80];
	private _padBag = "Land_Bucket_painted_F" createVehicle [0,0,0];
	_padBag setPos ([getPos fuego, 2, floor(random 361)] call BIS_Fnc_relPos);
	[[_padBag, "moveObject"], "flagaction"] call BIS_fnc_MP;
	[[_padBag, "deploy"], "flagaction"] call BIS_fnc_MP;
};

private _pos = [getPos fuego, 10, floor(random 361)] call BIS_Fnc_relPos;
private _item = objNull;
if (_objType == "lantern") then {
	_item = "Land_Camping_Light_F";
	_pos = [getPos fuego, 2, floor(random 361)] call BIS_Fnc_relPos;
};

if (_objType == "net") then {
	_item = "CamoNet_BLUFOR_open_F";
};

if (_objType == "sandbag") then {
	_item = "Land_BagFence_Round_F";
};

private _object = _item createVehicle _pos;
AS_HQ_placements pushBack _object;

[[_object,"moveObject"],"flagaction"] call BIS_fnc_MP;
