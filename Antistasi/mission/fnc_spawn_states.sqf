params ["_mission"];
private _missionType = _mission call AS_mission_fnc_type;
if (_missionType == "nato_uav") exitWith {
    [AS_mission_natoUAV_states, AS_mission_natoUAV_state_functions]
};
if (_missionType == "nato_armor") exitWith {
    [AS_mission_natoArmor_states, AS_mission_natoArmor_state_functions]
};
if (_missionType == "nato_cas") exitWith {
    [AS_mission_natoCAS_states, AS_mission_natoCAS_state_functions]
};
if (_missionType == "nato_qrf") exitWith {
    [AS_mission_natoQRF_states, AS_mission_natoQRF_state_functions]
};
if (_missionType == "nato_qrf") exitWith {
    [AS_mission_natoAttack_states, AS_mission_natoAttack_state_functions]
};
if (_missionType == "nato_artillery") exitWith {
    [AS_mission_natoArtillery_states, AS_mission_natoArtillery_state_functions]
};
if (_missionType == "nato_roadblock") exitWith {
    [AS_mission_natoRoadblock_states, AS_mission_natoRoadblock_state_functions]
};
if (_missionType == "nato_ammo") exitWith {
    [AS_mission_natoAmmo_states, AS_mission_natoAmmo_state_functions]
};
if (_missionType == "establish_fia_location") exitWith {
    [AS_mission_establishFIAlocation_states, AS_mission_establishFIAlocation_state_functions]
};
if (_missionType == "establish_fia_minefield") exitWith {
    [AS_mission_establishFIAminefield_states, AS_mission_establishFIAminefield_state_functions]
};
if (_missionType == "steal_ammo") exitWith {
    [AS_mission_stealAmmo_states, AS_mission_stealAmmo_state_functions]
};
if (_missionType == "repair_antenna") exitWith {
    [AS_mission_repairAntenna_states, AS_mission_repairAntenna_state_functions]
};
if (_missionType in ["kill_specops", "kill_officer"]) exitWith {
    [AS_mission_assassinate_states, AS_mission_assassinate_state_functions]
};
if (_missionType == "kill_traitor") exitWith {
    [AS_mission_killTraitor_states, AS_mission_killTraitor_state_functions]
};
if (_missionType == "destroy_vehicle") exitWith {
    [AS_mission_destroyVehicle_states, AS_mission_destroyVehicle_state_functions]
};
if (_missionType == "destroy_antenna") exitWith {
    [AS_mission_destroyAntenna_states, AS_mission_destroyAntenna_state_functions]
};
if (_missionType == "destroy_helicopter") exitWith {
    [AS_mission_destroyHelicopter_states, AS_mission_destroyHelicopter_state_functions]
};
if (_missionType in ["rescue_prisioners", "rescue_refugees"]) exitWith {
    [AS_mission_rescue_states, AS_mission_rescue_state_functions]
};
if (_missionType == "conquer") exitWith {
    [AS_mission_conquer_states, AS_mission_conquer_state_functions]
};
if (_missionType == "rob_bank") exitWith {
    [AS_mission_robBank_states, AS_mission_robBank_state_functions]
};
if (_missionType == "send_meds") exitWith {
    [AS_mission_sendMeds_states, AS_mission_sendMeds_state_functions]
};
if (_missionType == "help_meds") exitWith {
    [AS_mission_helpMeds_states, AS_mission_helpMeds_state_functions]
};
if (_missionType == "black_market") exitWith {
    [AS_mission_blackMarket_states, AS_mission_blackMarket_state_functions]
};
if (_missionType == "broadcast") exitWith {
    [AS_mission_broadcast_states, AS_mission_broadcast_state_functions]
};
if (_missionType == "pamphlets") exitWith {
    [AS_mission_pamphlets_states, AS_mission_pamphlets_state_functions]
};
if (_missionType == "defend_camp") exitWith {
    [AS_mission_defendCamp_states, AS_mission_defendCamp_state_functions]
};
if (_missionType == "defend_city") exitWith {
    [AS_mission_defendCity_states, AS_mission_defendCity_state_functions]
};
if (_missionType == "defend_location") exitWith {
    [AS_mission_defendLocation_states, AS_mission_defendLocation_state_functions]
};
if (_missionType == "defend_hq") exitWith {
    [AS_mission_defendHQ_states, AS_mission_defendHQ_state_functions]
};
if (_missionType in ["convoy_armor", "convoy_ammo", "convoy_prisoners", "convoy_hvt", "convoy_money", "convoy_supplies"]) exitWith {
    [AS_mission_convoy_states, AS_mission_convoy_state_functions]
};
diag_log format ["[AS] Error: mission_spawn_states: mission type '%1' has no states defined", _missionType];
[[], []]
