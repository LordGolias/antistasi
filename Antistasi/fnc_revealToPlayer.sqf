#include "macros.hpp"
while {AS_S("revealFromRadio")} do {
	if ((player == leader group player) and ([player] call AS_fnc_hasRadio)) then {
		{
			private _lider = leader _x;
			if ((side _lider != ("FIA" call AS_fnc_getFactionSide)) and
				(vehicle _lider != _lider) and
				(player knowsAbout _lider < 1.5)) then {
				player reveal [_lider,4];
				sleep 1;
			};
		} forEach allGroups;
	};
	sleep 10;
};
