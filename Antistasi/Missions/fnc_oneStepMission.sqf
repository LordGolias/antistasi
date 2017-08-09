params ["_fnc_missionFailedCondition", "_fnc_missionFailed",
        "_fnc_missionSuccessfulCondition", "_fnc_missionSuccessful"];

waitUntil  {sleep 5; False or _fnc_missionFailedCondition or _fnc_missionSuccessfulCondition};

if (call _fnc_missionFailedCondition) then _fnc_missionFailed else _fnc_missionSuccessful;
