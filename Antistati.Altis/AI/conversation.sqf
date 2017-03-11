_unit = _this select 0;
_jugador = _this select 1;

if (!alive _unit) exitWith {};

call {
	if (typeOf _unit == "C_man_w_worker_F") exitWith {
		line1 = ["Stranger", "Do you want to get me killed?! You couldn't be more conspicuous if you tried..."];
		line2 = ["Stranger", "Return in civilian clothes, then we'll talk."];

	};
	if (typeOf _unit == "C_man_hunter_1_F") exitWith {
		line1 = ["Nomad", "You have some nerves showing up like this."];
		line2 = ["Nomad", "If you approach me once again dressed like a bloody guerilla fighter, I'll put you down like the dog you are..."];
	};
};

[[line1,line2],"DIRECT",0.15] execVM "createConv.sqf";