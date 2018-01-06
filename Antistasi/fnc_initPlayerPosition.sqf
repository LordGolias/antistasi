params ["_player"];
_player setPos ((getMarkerPos "FIA_HQ") findEmptyPosition [2, 10, typeOf (vehicle _player)]);
