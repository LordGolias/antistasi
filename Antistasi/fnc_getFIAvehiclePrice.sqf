// price of the vehicle for FIA to buy or sell
params ["_tipoVeh", ["_isSelling", false]];

// `initialization/checkFactionAttributes` guarantees that this exists
private _cost = AS_data_allCosts getVariable _tipoVeh;

private _FIAseaports = count ([["seaport"], "FIA"] call AS_location_fnc_TS);

if (_isSelling) exitWith {
	// selling is half of the price +10% for each controlled port.
	round _cost/2*(1 + 0.1*_FIAseaports)
};
// price is -10% for each controlled port.
round _cost*(1 - 0.1 *_FIAseaports)
