/*
Relevant functions of this module:
	Server side:
		- AS_fnc_savePlayers: saves all players.

	Client side:
		- AS_fnc_loadLocalPlayer: loads player data.
		- AS_fnc_saveLocalPlayer: saves player on the server.
*/

// The ids and data of the players.
AS_profileIDs = [];
AS_profileID_data = [];

// client function. Maps local data into an array.
AS_fnc_serializeLocalPlayer = {
	_result = [];
	if (isMultiplayer) then {
		_score = player getVariable "score";
		_rank = rank player;
		_money = player getVariable "dinero";
		{
		_hired = _x;
		if ((!isPlayer _hired) and (alive _hired)) then {
			_money = _money + (AS_data_allCosts getVariable ([_x] call AS_fnc_getFIAUnitNameType));
			if (vehicle _hired != _hired) then {
				_veh = vehicle _hired;
				_tipoVeh = typeOf _veh;
				if (not(_veh in staticsToSave)) then {
					if ((_veh isKindOf "StaticWeapon") or (driver _veh == _hired)) then {
						_money = _money + ([_tipoVeh] call FIAvehiclePrice);
						if (count attachedObjects _veh != 0) then {{_money = _money + ([typeOf _x] call FIAvehiclePrice)} forEach attachedObjects _veh};
					};
				};
			};
		};
		} forEach units group player;
		_result = [_score, _rank, _money, personalGarage];
	};
	_result
};

// client function. Sends the data to the server to be stored (and later saved).
AS_fnc_saveLocalPlayerData = {
	[AS_profileID, [] call AS_fnc_serializeLocalPlayer] remoteExec ["AS_fnc_receivePlayerData", 2];
};

// server function. Triggers all clients to send own data to server.
AS_fnc_getPlayersData = {
	remoteExec ["AS_fnc_saveLocalPlayerData", 0];  // to every client.
};

// server function. Stores profile data.
AS_fnc_receivePlayerData = {
	params ["_profileID", "_data"];
    _index = AS_profileIDs find _profileID;
    if (_index == -1) then {
        AS_profileIDs pushback _profileID;
        AS_profileID_data pushback _data;
    } else {
        AS_profileID_data set [_index, _data];
    };
};

// server function. Saves all profiles.
AS_fnc_savePlayers = {
    params ["_saveName"];
    for "_i" from 0 to count AS_profileIDs - 1 do {
        [_saveName, AS_profileIDs select _i, AS_profileID_data select _i] call AS_fnc_SaveStat;
    };
};

// server function. Asks all clients to load profiles.
AS_fnc_loadPlayers = {
    remoteExec ["AS_fnc_loadLocalPlayer", 0];  // to every client (including server-client
    diag_log '[AS] Server: asked clients to load profiles.';
};

// client function. Sends request to get saved data from server.
AS_fnc_loadLocalPlayer = {
    diag_log format ['[AS] Client "%1": asking for saved data.', AS_profileID];
	[AS_profileID, owner player] remoteExec ["AS_fnc_sendPlayerData", 2];
};

// server function. Loads data from profile id and sends it back for loading, if it exists.
AS_fnc_sendPlayerData = {
	params ["_profileID", "_clientID"];

    private _text = format ['[AS] Server: received request for profile data from "%1". ', _profileID];

    if (AS_currentSave != "") then {
        private _data = [AS_currentSave, _profileID] call AS_fnc_LoadStat;
        if (!isNil "_data") then {
            diag_log (_text + 'It was sent');
            [_data] remoteExec ["AS_fnc_setPlayerData", _clientID];
        } else {
            diag_log (_text + 'Save exists but profile does not exist.');
        };
    } else {
        diag_log (_text + 'There is no current save.');
    };
};

// client function. Loads the data
AS_fnc_setPlayerData = {
	params ["_data"];
    diag_log format ['[AS] Client "%1": received data. Loading player.', AS_profileID];
    [_data] call AS_fnc_deserializeLocalPlayer;
};

// client function. Maps an array to local data.
AS_fnc_deserializeLocalPlayer = {
    params ["_data"];
	if (isMultiplayer) then {
		player setVariable ["score", _data select 0, true];
		player setRank (_data select 1);
		[player, (_data select 1)] remoteExec ["ranksMP"];
		player setVariable ["dinero", _data select 2, true];
		personalGarage = _data select 3;
        hint "Profile loaded."
	};
};
