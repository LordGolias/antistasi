params ["_t", ["_position", "none"]];
private ["_item","_pos"];

if (isNil "AS_HQ_placements") then {AS_HQ_placements = [];};

_maxHQsandbags = 5;
_currentHQsandbags = ({typeOf _x == "Land_BagFence_Round_F"} count AS_HQ_placements);

if ((_t == "sandbag") && (_currentHQsandbags >= _maxHQsandbags)) exitWith {[petros,"BE","No more sandbags available."] remoteExec ["commsMP",stavros]};

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

if (_t == "delete") exitWith {
	{
		deleteVehicle _x;
	} foreach AS_HQ_placements;

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
};

_ci = _item createVehicle _pos;

AS_HQ_placements pushBack _ci; publicVariable "AS_HQ_placements";

[[_ci,"moveObject"],"flagaction"] call BIS_fnc_MP;
