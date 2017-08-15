class NATO_Missions
{
	idd=-1;
	movingenable=false;

	class controls
	{
AS_DIALOG(5,"NATO support", "closeDialog 0; createDialog ""radio_comm_commander"";");

BTN_L(1,-1,"Attack Mission", "Cost: 20 points", "closeDialog 0; [""nato_attack""] spawn AS_fncUI_natoMissions;");
BTN_L(2,-1,"Armored Column", "Cost: 20 points", "closeDialog 0; [""nato_armor""] spawn AS_fncUI_natoMissions;");
BTN_L(3,-1,"Artillery", "Cost: 10 points", "closeDialog 0; [""nato_artillery""] spawn AS_fncUI_natoMissions;");
BTN_L(4,-1,"Roadblock", "Cost: 10 points", "closeDialog 0; [""nato_roadblock""] spawn AS_fncUI_natoMissions;");

BTN_R(1,-1,"NATO UAV", "Cost: 10 points", "closeDialog 0; [""nato_uav""] spawn AS_fncUI_natoMissions;");
BTN_R(2,-1,"Ammo drop", "Cost: 5 points", "closeDialog 0; [""nato_ammo""] spawn AS_fncUI_natoMissions;");
BTN_R(3,-1,"CAS Support", "Cost: 10 points", "closeDialog 0; [""nato_cas""] spawn AS_fncUI_natoMissions;");
BTN_R(4,-1,"Bomb Run", "Cost: 10 points", "closeDialog 0; createDialog ""carpet_bombing"";");

BTN_M(5, -1, "NATO QRF", "Cost: 10 points", "closeDialog 0; [""nato_qrf""] spawn AS_fncUI_natoMissions;");
	};
};
