if (player call AS_fnc_safeDropAIcontrol) then {
    {[_x] joinsilent group player} forEach units group player;
    group player selectLeader player;
};
