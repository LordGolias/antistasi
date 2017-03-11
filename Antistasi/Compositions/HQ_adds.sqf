params ["_t", ["_position", "none"]];

private ["_item","_pos"];

if ((_t == "sandbag") && ((server getVariable ["AS_HQ_sandbag", 0]) > 2)) exitWith {[petros,"BE","No more sandbags for you!"] remoteExec ["commsMP",stavros]};

if (_t == "pad") exitWith {
	if (isNil "vehiclePad") then {
		{
			if (str typeof _x find "Land_Bucket_painted_F" > -1) then {
		    	[_x, {deleteVehicle _this}] remoteExec ["call", 0];
		   	};
		} forEach nearestObjects [petros, [], 80];
		_padBag = "Land_Bucket_painted_F" createVehicle [0,0,0];
		_padBag setPos ([getPos fuego, 2, floor(random 361)] call BIS_Fnc_relPos);
		[[_padBag,"moveObject"],"flagaction"] call BIS_fnc_MP;
		[[_padBag,"deploy"],"flagaction"] call BIS_fnc_MP;
	} else {
		[vehiclePad, {deleteVehicle _this}] remoteExec ["call", 0];
		[vehiclePad, {vehiclePad = nil}] remoteExec ["call", 0];
		server setVariable ["AS_vehicleOrientation", 0, true];
	};
};

_objs = [];

if (_t == "delete") exitWith {
	{
    	if ((  str typeof _x find "Land_Camping_Light_F" > -1
    	    or str typeof _x find "Land_BagFence_Round_F" > -1
        	or str typeof _x find "CamoNet_BLUFOR_open_F" > -1))
		then {
        	_objs pushBack _x;
   		};
	} forEach nearestObjects [getPos fuego, [], 50];

	{
		deleteVehicle _x;
	} foreach _objs;

	server setVariable ["AS_HQ_sandbag", 0];

	[vehiclePad, {deleteVehicle _this}] remoteExec ["call", 0];
	[vehiclePad, {vehiclePad = nil}] remoteExec ["call", 0];
	server setVariable ["AS_vehicleOrientation", 0, true];
};

_pos = [getPos fuego, 10, floor(random 361)] call BIS_Fnc_relPos;

if (_t == "lantern") then {
	_item = "Land_Camping_Light_F";
	_pos = [getPos fuego, 2, floor(random 361)] call BIS_Fnc_relPos;
};

if (_t == "net") then {
	_item = "CamoNet_BLUFOR_open_F";
};

if (_t == "sandbag") then {
	_item = "Land_BagFence_Round_F";
	_count = server getVariable ["AS_HQ_sandbag", 0];
	server setVariable ["AS_HQ_sandbag", _count + 1];
};

_ci = _item createVehicle [0,0,0];
_ci setpos _pos;

[[_ci,"moveObject"],"flagaction"] call BIS_fnc_MP;