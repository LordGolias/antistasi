#include "macros.hpp"
AS_SERVER_ONLY("fnc_HQdeployPad.sqf");
// _obj is the paint
params ["_obj"];

private _pos = position _obj;
if ((_pos distance fuego) > 30) exitWith {
    [petros,"hint","Too far from HQ."] remoteExec ["AS_fnc_localCommunication",AS_commander];
    deleteVehicle _obj;
};
if !(isNil "vehiclePad") exitWith {
    [petros,"hint","Pad already deployed."] remoteExec ["AS_fnc_localCommunication",AS_commander];
    deleteVehicle _obj;
};

AS_Sset("AS_vehicleOrientation", [_caller, _obj] call BIS_fnc_dirTo);
vehiclePad = createVehicle ["Land_JumpTarget_F", _pos, [], 0, "CAN_COLLIDE"];
publicVariable "vehiclePad";

deleteVehicle _obj;
