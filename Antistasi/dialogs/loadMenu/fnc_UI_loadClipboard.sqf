private _data = copyFromClipboard;
hint "wait for the server to load the game...";
[_data] remoteExec ["AS_database_fnc_loadGame", 2];
closeDialog 0;
