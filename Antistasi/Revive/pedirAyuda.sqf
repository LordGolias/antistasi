params ["_unit"];

private _bestDistance = 81;  // best distance of the current medic (max distance for first medic)
private _hasMedic = false;
private _medic = objNull;

private _medItem = "FirstAidKit";
if hayACEMedical then {_medItem = "ACE_fieldDressing"};

private _canHeal = {
	params ["_candidate"];
	(alive _candidate) and
	{not (_candidate call AS_fnc_isUnconscious)} and
	{vehicle _candidate == _candidate} and
	{_medItem in (items _candidate)} and
	{_candidate distance _unit < _bestDistance}
};

private _units = units group _unit;
{
	if ((!isPlayer _x) and {[_x] call AS_fnc_getFIAUnitType == "Medic"}) then {
		if (_x call _canHeal) then {
			_hasMedic = true;
			if (not (_x getVariable ["ayudando", false]) and (!(_x getVariable "rearming"))) then {
				_medic = _x;
				_bestDistance = _x distance _unit;
			};
		};
	};
	if not isNull _medic exitWith {}; // medic found, short circuit loop
} forEach _units;

if not _hasMedic then {
	{
		if ((!isPlayer _x) and {[_x] call AS_fnc_getFIAUnitType != "Medic"}) then {
			if (_x call _canHeal) then {
				if (not (_x getVariable ["ayudando", false]) and (!(_x getVariable "rearming"))) then {
					_medic = _x;
					_bestDistance = _x distance _unit;
				};
			};
		};
		if not isNull _medic exitWith {}; // medic found, short circuit loop
	} forEach _units;
};

if (not isNull _medic and (_unit call AS_fnc_isUnconscious)) then {
	[_unit,_medic] spawn ayudar;
};

_medic
