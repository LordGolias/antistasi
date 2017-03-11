_nr = _this select 0;
_rad = _this select 1;
_type = _this select 2;

finPos = [];

openMap true;
onMapSingleClick "finPos = _pos;";

waitUntil {sleep 1; (count finPos > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

_minePos =+ finPos;
openMap false;

if (surfaceIsWater _minePos) exitWith {hint "Restriced to land usage."};

_nr = _this select 0;
_rad = _this select 1;
_type = _this select 2;

for "_i" from 1 to _nr do
{
_kaboom = createMine [_type,_minePos,[],_rad];
side_green revealMine _kaboom;
side_red revealMine _kaboom;
side_blue revealMine _kaboom;
};