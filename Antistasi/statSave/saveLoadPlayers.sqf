/*
Relevant functions of this module:
	Server side:
		- AS_fnc_savePlayers: saves all players.

	Client side:
		- AS_fnc_loadLocalPlayer: loads player data.
		- AS_fnc_saveLocalPlayer: saves player on the server.
*/


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
			_money = _money + (server getVariable (typeOf _hired));
			if (vehicle _hired != _hired) then {
				_veh = vehicle _hired;
				_tipoVeh = typeOf _veh;
				if (not(_veh in staticsToSave)) then {
					if ((_veh isKindOf "StaticWeapon") or (driver _veh == _hired)) then {
						_money = _money + ([_tipoVeh] call vehiclePrice);
						if (count attachedObjects _veh != 0) then {{_money = _money + ([typeOf _x] call vehiclePrice)} forEach attachedObjects _veh};
					};
				};
			};
		};
		} forEach units group player;
		_result = [_score, _rank, _money, personalGarage];
	};
	_result
};

// client function.
AS_fnc_sendLocalPlayerData = {
	[AS_profileID, [] call AS_fnc_serializeLocalPlayer] remoteExec ["AS_fnc_savePlayer", 2];
};

AS_fnc_saveLocalPlayer = AS_fnc_sendLocalPlayerData;

// server function. Triggers all clients to send own data to server.
AS_fnc_savePlayers = {
	[] remoteExec ["AS_fnc_sendLocalPlayerData", 0];  // to every client.
};

// server function. Saves profile data.
AS_fnc_savePlayer = {
	params ["_profileID", "_data"];

	[_profileID, _data] call AS_fnc_SaveStat;
};

// client function. Sends request to get saved data from server.
AS_fnc_loadLocalPlayer = {
	[AS_profileID, owner player] remoteExec ["AS_fnc_sendPlayerData", 2];
};

// server function. Loads data from profile id and sends it back for loading. 
AS_fnc_sendPlayerData = {
	params ["_profileID", "_clientID"];
	[[_profileID] call AS_fnc_LoadStat] remoteExec ["AS_fnc_setPlayerData", _clientID];
};

// client function. Loads the data
AS_fnc_setPlayerData = {
	params ["_data"];

	// e.g. profile is new.
	if (!isNil "_data") then {
		[_data] call AS_fnc_deserializeLocalPlayer;
	};
};

// client function. Maps an array to local data.
AS_fnc_deserializeLocalPlayer = {
	if (isMultiplayer) then {
		player setVariable ["score", _data select 0, true];
		player setRank (_data select 1);
		[player, (_data select 1)] remoteExec ["ranksMP"];
		player setVariable ["dinero", _data select 2, true];
		personalGarage = _data select 3;
	};
};
