// (un-)armed transport helicopters
opHeliTrans = ["CUP_O_Mi8_medevac_RU"];
// helicopter that dismounts troops
opHeliDismount = "CUP_O_Mi8_medevac_RU";
// helicopter that fastropes troops in
opHeliFR = "CUP_O_Mi8_medevac_RU";
// small armed helicopter
opHeliSD = "CUP_O_Mi8_RU";
// gunship
opGunship = "CUP_O_Ka52_RU";

// CAS, fixed-wing
opCASFW = ["CUP_O_SU34_AGM_RU"];

// small UAV
opUAVsmall = "CUP_O_Pchela1T_RU";

// air force
opAir = opHeliTrans + [opHeliSD, opGunship] + opCASFW;

// self-propelled anti air
opSPAA = "CUP_O_2S6M_RU";

opTruck = "CUP_O_Ural_Open_RU";

opMRAPu = "CUP_O_BMP2_RU";

// infantry classes used in missions
opI_OFF = 	"CUP_O_RU_Officer_VDV"; // officer/official
opI_PIL = 	"CUP_O_RU_Pilot_VDV"; // pilot
opI_OFF2 = 	"CUP_O_RU_Officer_VDV"; // officer/traitor
opI_SL = 	"CUP_O_RU_Soldier_SL_VDV"; // squad leader, urban camo
opI_RFL1 = 	"CUP_O_RU_Soldier_VDV"; // rifleman, urban camo
opI_CREW = 	"CUP_O_RU_Crew_VDV"; // crew

// standard group arrays, used for spawning groups
CSATConfigGroupInf = (configfile >> "CfgGroups" >> "east" >> "CUP_O_RU" >> "Infantry");
opGroup_SpecOps = ["CUP_O_RU_ReconTeam"]; // spec opcs
opGroup_Squad = ["CUP_O_RU_InfSquad"]; // squad
opGroup_Recon_Team = ["CUP_O_RU_InfSection"];

// the affiliation
opFlag = "Flag_CSAT_F";
// Its acronym
AS_CSATname = "CSAT";

opIR = "acc_pointer_IR";

opCrate = "Box_East_WpsLaunch_F";
