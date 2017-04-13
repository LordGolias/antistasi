// price of the vehicle for FIA to buy or sell
params ["_tipoVeh", ["_isSelling", false]];

private _cost = 300;
if (_tipoVeh in AS_FIArecruitment_all) then {
	_cost = AS_FIArecruitment getVariable _tipoVeh;
} else {
	diag_log format ["[AS] FIAvehiclePrice: '%1' not declared in AS_FIArecruitment.", _tipoVeh];
};

if (_isSelling) exitWith {
	// selling is half of the price +10% for each controlled port.
	round _cost/2*(1 + 0.1 * ({_x in mrkFIA} count puertos))
};
// price is -10% for each controlled port.
round _cost*(1 - 0.1 * ({_x in mrkFIA} count puertos))
