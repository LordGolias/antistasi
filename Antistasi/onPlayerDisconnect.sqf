private ["_unit","_recursos","_hr","_armas","_municion","_items","_pos"];

_unit = _this select 0;

_recursos = 0;
_hr = 0;

if (_unit == stavros) then
	{
	{
	if (!(_x getVariable ["esNATO",false])) then
		{
		if ((leader _x getVariable ["BLUFORspawn",false]) and (!isPlayer leader _x)) then
			{
			_uds = units _x;
				{
				if (alive _x) then
					{
					_recursos = _recursos + (server getVariable (typeOf _x));
					_hr = _hr + 1;
					};
				if (!isNull (assignedVehicle _x)) then
					{
					_veh = assignedVehicle _x;
					_tipoVeh = typeOf _veh;
					if ((_veh isKindOf "StaticWeapon") and (not(_veh in staticsToSave))) then
						{
						_recursos = _recursos + ([_tipoVeh] call vehiclePrice) + ([typeOf (vehicle leader _x)] call vehiclePrice);
						}
					else
						{
						if (_tipoVeh in vehFIA) then {_recursos = _recursos + ([_tipoVeh] call vehiclePrice);};
						if (_tipoVeh in (vehTrucks + vehPatrol + vehSupply)) then {_recursos = _recursos + 300};
						if (_tipoVeh in vehAAFAT) then {
							call {
								if (_tipoVeh in vehAPC) exitWith {_recursos = _recursos + 1000};
								if (_tipoVeh in vehIFV) exitWith {_recursos = _recursos + 2000};
								if (_tipoVeh in vehTank) exitWith {_recursos = _recursos + 5000};
								};
							};
						if (count attachedObjects _veh > 0) then
							{
							_subVeh = (attachedObjects _veh) select 0;
							_recursos = _recursos + ([(typeOf _subVeh)] call vehiclePrice);
							deleteVehicle _subVeh;
							};
						};
					if (!(_veh in staticsToSave)) then {deleteVehicle _veh};
					};
				deleteVehicle _x;
				} forEach _uds;
			};
		};
	} forEach allGroups;
	if (((count playableUnits > 0) and (count miembros == 0)) or ({(getPlayerUID _x) in miembros} count playableUnits > 0)) then
		{
		[] spawn assignStavros;
		};
	if (group petros == group _unit) then {[] spawn buildHQ};
	};
if ((_hr > 0) or (_recursos > 0)) then {[_hr,_recursos] spawn resourcesFIA};
_armas = weapons _unit;
_municion = magazines _unit + [currentMagazine _unit];
_items = (items _unit) + (primaryWeaponItems _unit);
if (hayTFAR) then
	{
	_items pushBack hmd _unit;
	if (backpack _unit != "tf_rt1523g_sage") then {caja addBackpackCargoGlobal [(backpack _unit) call BIS_fnc_basicBackpack,1];};
	}
else
	{
	_items = _items + (assignedItems _unit);
	caja addBackpackCargoGlobal [(backpack _unit) call BIS_fnc_basicBackpack,1];
	};

{caja addWeaponCargoGlobal [_x,1]} forEach _armas;
{caja addMagazineCargoGlobal [_x,1]} forEach _municion;
{caja addItemCargoGlobal [_x,1]} forEach _items;

_pos = getPosATL _unit;
_wholder = nearestObjects [_pos, ["weaponHolderSimulated", "weaponHolder"], 2];
{deleteVehicle _x;} forEach _wholder + [_unit];
if (alive _unit) then
	{
	_unit setVariable ["owner",_unit,true];
	_unit setDamage 1;
	};

