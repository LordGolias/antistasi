if (isNil "gameMenu") exitWith {
    gameMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",AS_fnc_EH_KeyDown];
};

(findDisplay 46) displayRemoveEventHandler ["KeyDown", gameMenu];
gameMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",AS_fnc_EH_KeyDown];
