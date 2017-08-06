params ["_gunner", "_truck", "_mortar"];
private _driver = driver _truck;
private _grupo = group _gunner;

while {(alive _gunner) and (alive _mortar) and (canMove _truck)} do {
	waitUntil {sleep 1; (!unitReady _driver) or (not((alive _gunner) and (alive _mortar)))};

	moveOut _gunner;
	_gunner assignAsCargo _truck;
	_mortar attachTo [_truck, _mortar getVariable "attachPoint"];
	_mortar setDir (getDir _truck + 180);

	_driver disableAI "MOVE";
	waitUntil {sleep 1; ((_truck getCargoIndex _gunner) != -1) or (not((alive _gunner) and (alive _mortar)))};
	_driver enableAI "MOVE";

	waitUntil {sleep 1; (speed _truck == 0) or (!canMove _truck) or (!alive _driver) or (not((alive _gunner) and (alive _mortar)))};

	moveOut _gunner;
	detach _mortar;
	private _pos = position _truck findEmptyPosition [1,30,"B_MBT_01_TUSK_F"];
	_mortar setPos _pos;
	_gunner assignAsGunner _mortar;
};
