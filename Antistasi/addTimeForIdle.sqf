
_sitio = _this select 0;
_time = _this select 1;
_fechaNum = server getVariable _sitio;
if (_fechaNum < dateToNumber date) then {_fechaNum = dateToNumber date};

_fechaNum = numberToDate [2035,_fechaNum];

_fechaNum = [_fechaNum select 0, _fechaNum select 1, _fechaNum select 2, _fechaNum select 3, (_fechaNum select 4) + _time];

server setVariable [_sitio,dateToNumber _fechaNum,true];
