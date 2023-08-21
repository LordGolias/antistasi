params ["_control", "_key", "_shift", "_ctrl", "_alt"];
_handled = false;
if (player call AS_medical_fnc_isUnconscious) exitWith {_handled};
if (player call AS_fnc_controlsAI) exitWith {_handled};
if (_key == 21) then {
	if (_shift) then {
		if (player == AS_commander) then {
			if (_ctrl) then {
				CreateDialog "com_menu";
			} else {
				[] spawn AS_fnc_callArtillerySupport;
			};
		};
	} else {
		if (player == AS_commander) then {
			closedialog 0;
			createDialog "radio_comm_commander";
		} else {
			closedialog 0;
			createDialog "radio_comm_player";
		};
	};
};

_handled
