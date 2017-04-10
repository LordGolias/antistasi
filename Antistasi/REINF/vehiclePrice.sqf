// price of the vehicle for FIA to buy
params ["_tipoVeh"];
if !(_tipoVeh in vehFIA) exitWith {
	diag_log format ["[AS] vehiclePrice: '%1' not buyable by FIA.", _tipoVeh];
	0
};

private _coste = AS_data_allCosts getVariable _tipoVeh;

// less 10% for each controlled port.
round _coste*(1 - 0.1 * ({_x in mrkFIA} count puertos))
