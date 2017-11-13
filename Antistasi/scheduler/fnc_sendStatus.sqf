// client side: send status information to the server
private _data = [AS_FPSsamples, hasInterface, isDedicated];

[clientOwner, _data] remoteExec ["AS_scheduler_fnc_receiveStatus", 2];
