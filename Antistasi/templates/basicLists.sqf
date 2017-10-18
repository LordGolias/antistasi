//array of possible civs. Only euro types picked (this is Greece). Add any civ classnames you wish here
arrayCivs = [
	"C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_hunter_1_F",
	"C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_fugitive_F",
	"C_man_p_shorts_1_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F",
	"C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F",
	"C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_scientist_F",
	"Max_woman1", "Max_woman2", "Max_woman3", "Max_woman4","Max_woman1",
	"Max_woman2", "Max_woman3", "Max_woman4", "RDS_Priest", "RDS_Functionary1",
	"RDS_Functionary2", "RDS_Rocker2"
];

CIV_specialUnits = [
	"C_Nikos","C_Nikos_aged",
	"C_man_hunter_1_F",
	"C_man_w_worker_F"
];

//possible civ vehicles. Add any mod classnames you wish here
arrayCivVeh = [
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_Offroad_01_F",
	"C_SUV_01_F",
	"C_Van_01_box_F",
	"C_Van_01_fuel_F",
	"C_Van_01_transport_F",
	"C_Truck_02_transport_F",
	"C_Truck_02_covered_F",
	"RDS_Gaz24_Civ_03",
	"RDS_Gaz24_Civ_02",
	"RDS_Golf4_Civ_01",
	"RDS_S1203_Civ_02",
	"RDS_S1203_Civ_01",
	"RDS_Lada_Civ_01",
	"RDS_Octavia_Civ_01",
	"RDS_Old_bike_Civ_01",
	"RDS_Zetor6945_Base",
	"RDS_tt650_Civ_01",
	"RDS_JAWA353_Civ_01",
	"C_Van_02_transport_F",
	"RDS_Ikarus_Civ_01"
];

// names of FIA soldiers
namesFIASoldiers = ["Anthis","Costa","Dimitirou","Elias","Gekas","Kouris","Leventis","Markos","Nikas","Nicolo","Panas","Rosi","Samaras","Thanos","Vega"];
if (isMultiplayer) then {namesFIASoldiers = namesFIASoldiers + ["protagonista"]};

injuredSounds = [
	"a3\sounds_f\characters\human-sfx\Person0\P0_moan_13_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_14_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_15_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_16_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_17_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_18_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_19_words.wss","a3\sounds_f\characters\human-sfx\Person0\P0_moan_20_words.wss",
	"a3\sounds_f\characters\human-sfx\Person1\P1_moan_19_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_20_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_21_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_22_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_23_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_24_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_25_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_26_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_27_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_28_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_29_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_30_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_31_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_32_words.wss","a3\sounds_f\characters\human-sfx\Person1\P1_moan_33_words.wss",
	"a3\sounds_f\characters\human-sfx\Person2\P2_moan_19_words.wss"];

ladridos = ["Music\dog_bark01.wss", "Music\dog_bark02.wss", "Music\dog_bark03.wss", "Music\dog_bark04.wss", "Music\dog_bark05.wss","Music\dog_maul01.wss","Music\dog_yelp01.wss","Music\dog_yelp02.wss","Music\dog_yelp03.wss"];
