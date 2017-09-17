// price of the vehicle for FIA to buy or sell
params ["_tipoVeh", ["_isSelling", false]];

private _cost = 300;
if (_tipoVeh in AS_FIArecruitment_all) then {
	_cost = AS_FIArecruitment getVariable _tipoVeh;
} else {
	diag_log format ["[AS] AS_fnc_getFIAvehiclePrice: '%1' not declared in AS_FIArecruitment.", _tipoVeh];
};


private _FIAseaports = count ([["seaport"], "FIA"] call AS_location_fnc_TS);

if (_isSelling) exitWith {
	// selling is half of the price +10% for each controlled port.
	round _cost/2*(1 + 0.1*_FIAseaports)
};
// price is -10% for each controlled port.
round _cost*(1 - 0.1 *_FIAseaports)
