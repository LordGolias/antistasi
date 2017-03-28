if (isNil "gameMenu") exitWith {
    gameMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",teclas];
};

(findDisplay 46) displayRemoveEventHandler ["KeyDown", gameMenu];
gameMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",teclas];
