#include "../macros.hpp"
if (player != AS_commander) exitWith {hint "Only Commander AS_commander has access to this function"};

// BE module
_permission = true;
if (hayBE) then {
	_permission = ["skill"] call fnc_BE_permission;
};

if !(_permission) exitWith {hint "Our troops are not experienced enough to be trained yet."};
// BE module

_skillFIA = AS_P("skillFIA");
if (_skillFIA > 19) exitWith {hint "Your troops have the maximum training"};
_resourcesFIA = AS_P("resourcesFIA");
_coste = 1000 + (1.5*(_skillFIA *750));
if (_resourcesFIA < _coste) exitWith {hint format ["You do not have enough money to afford additional training. %1 € needed",_coste]};

_resourcesFIA = _resourcesFIA - _coste;
_skillFIA = _skillFIA + 1;
hint format ["FIA Skill Level has been Upgraded\nCurrent level is %1",_skillFIA];
AS_persistent setVariable ["skillFIA",_skillFIA,true];
AS_persistent setVariable ["resourcesFIA",_resourcesFIA,true];

{
_coste = AS_data_allCosts getVariable _x;
_coste = round (_coste + (_coste * (_skillFIA/280)));
AS_data_allCosts setVariable [_x,_coste,true];
} forEach soldadosFIA;
