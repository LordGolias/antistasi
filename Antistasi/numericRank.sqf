private ["_unit","_idRank","_newRank","_result", "_abbr"];
_unit = _this select 0;
//_idRank = rankId _unit + 1;
_rango = _unit getVariable ["rango","PRIVATE"];
_abbr = "CPL";
switch (_rango) do
	{
	case "PRIVATE": {_idRank= 1; _newRank = "CORPORAL"; _abbr = "CPL"};
	case "CORPORAL": {_idRank = 2; _newRank = "SERGEANT"; _abbr = "SGT"};
	case "SERGEANT": {_idRank = 3; _newRank = "LIEUTENANT"; _abbr = "LT"};
	case "LIEUTENANT": {_idRank = 4; _newRank = "CAPTAIN"; _abbr = "CPT"};
	case "CAPTAIN": {_idRank = 5; _newRank = "MAJOR"; _abbr = "MAJ"};
	case "MAJOR": {_idRank = 6; _newRank = "COLONEL"; _abbr = "COL"};
	case "COLONEL": {_idRank = 7; _newRank = "COLONEL"; _abbr = "COL"};
	};
_result = [_idRank,_newRank, _abbr];
_result