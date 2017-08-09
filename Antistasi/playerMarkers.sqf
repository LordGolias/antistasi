while {true} do {
	waitUntil {sleep 0.5; (visibleMap or visibleGPS) and ([player] call hasRadio)};
	private _jugadores = [];
	private _marcadores = [];
	while {visibleMap or visibleGPS} do {
		{
			private _jugador = _x getVariable ["owner",_x];
			if ((not(_jugador in _jugadores)) and (player != _jugador)) then {
				_jugadores pushBack _jugador;
				private _mrk = createMarkerLocal [format ["%1",_jugador],position _jugador];
				_mrk setMarkerTypeLocal "mil_triangle";
				_mrk setMarkerColorLocal "ColorWhite";
				_mrk setMarkerTextLocal format ["%1",name _jugador];
				_marcadores pushBack _mrk;
			};
		} forEach playableUnits;
		if (count _jugadores > 0) then {
			{
				private _jugador = _x;
				private _mrk = format ["%1",_jugador];
				if (vehicle _jugador == _jugador) then {
					_mrk setMarkerPosLocal position _jugador;
					_mrk setMarkerDirLocal getDir _jugador;
					if (_jugador call AS_fnc_isUnconscious) then {
						_mrk setMarkerTypeLocal "mil_join";
						_mrk setMarkerTextLocal format ["%1 Injured",name _jugador];
						_mrk setMarkerColorLocal "ColorPink";
					} else {
						_mrk setMarkerTypeLocal "mil_triangle";
						_mrk setMarkerTextLocal format ["%1",name _jugador];
						_mrk setMarkerColorLocal "ColorWhite";
					};
				} else {
					private _veh = vehicle _jugador;
					if ((isNull driver _veh) or (driver _veh == _jugador)) then {
						_mrk setMarkerPosLocal position _veh;
						_mrk setMarkerDirLocal getDir _veh;
						private _texto = format ["%1 (%2)/",name _jugador,getText(configFile>>"CfgVehicles">>typeOf _veh>>"DisplayName")];
						{
							if ((_x!=_jugador) and (vehicle _x == _veh)) then {
								_texto = format ["%1%2/",_texto,name _x];
							};
						} forEach playableUnits;
						_mrk setMarkerTextLocal _texto;
					} else {
						_mrk setMarkerAlphaLocal 0;
					};
				};
			} forEach _jugadores;
		};
		sleep 1;
	};
	{deleteMarkerLocal _x} forEach _marcadores;
};
