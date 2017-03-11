private ["_unit"];

_unit = _this select 0;
_result = false;

call {
	if ("ItemRadio" in assignedItems _unit) exitWith {_result = true};

	if (hayTFAR) exitWith {
		if (count (_unit call TFAR_fnc_radiosList) > 0) then {
			_result = true;
		};
	};
};

_result