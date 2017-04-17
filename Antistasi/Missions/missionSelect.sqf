
_posiblesA = _this select 0;
_posiblesB = _this select 1;

_textA = "None";
if (count _posiblesA > 0) then {
	_textA = _posiblesA select 0;
};
if (count _posiblesA > 1) then {
	for "_i" from 1 to ((count _posiblesA) - 1) do {
		_textA = _textA + ", ";
		_textA = _textA + (_posiblesA select _i);
	};
};

_textB = "None";
if (count _posiblesB > 0) then {
	_textB = _posiblesB select 0;
};
if (count _posiblesB > 1) then {
	for "_i" from 1 to ((count _posiblesB) - 1) do {
		_textB = _textB + ", ";
		_textB = _textB + (_posiblesB select _i);
	};
};

_sitio = "none";

_hintText = format ["Cities available for a Leaflet Drop: %1 \n\nCities available for a broadcast: %2",_textA,_textB];

hint _hintText;

posicionTel = [];

openMap true;
onMapSingleClick "posicionTel = _pos;";

waitUntil {sleep 1; (count posicionTel > 0) or (!visibleMap)};
onMapSingleClick "";

if (!visibleMap) exitWith {openMap false; hint "No mission for you, mate!";};

_posicionTel =+ posicionTel;
_sitio = [call AS_fnc_location_all, _posicionTel] call BIS_Fnc_nearestPosition;

if !((_sitio in _posiblesA) || (_sitio in _posiblesB)) exitWith {openMap false; hint "No mission for you, mate!";};

if (_sitio in _posiblesB) then {
	[_sitio] remoteExec ["PR_Brainwash",HCgarrisons];
}
else {
	[_sitio] remoteExec ["PR_Pamphlet",HCgarrisons];
};
openMap false;
