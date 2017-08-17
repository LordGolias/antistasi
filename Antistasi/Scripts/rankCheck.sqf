#include "../macros.hpp"
AS_CLIENT_ONLY("rankCheck.sqf");

while {true} do {
	private _player = player getVariable ["owner", player];
	private _rank = _player getVariable ["rank", AS_ranks select 0];
	private _curr_index = AS_ranks find _rank;
	private _prev_index = (_curr_index - 1) max 0;
	private _next_index = (_curr_index + 1) min (count AS_ranks - 1);

	private _currentScore = _player getVariable ["score", 0];
	private _scoreToPromotion = 50*_next_index*_next_index;
	private _scoreToDemotion = 50*_prev_index*_prev_index;

	private _abbreviation = AS_rank_abbreviations select _curr_index;
	if (_next_index != _curr_index and {_currentScore >= _scoreToPromotion}) then {
		private _new_rank = AS_ranks select _next_index;
		_player setVariable ["rank", _new_rank, true];
		_player setUnitRank _new_rank;

		[petros,"hint",format ["%1: %2.\n\nCONGATULATIONS!",name _player, _new_rank]] remoteExec ["commsMP"];
		_rank = _new_rank;
		_abbreviation = AS_rank_abbreviations select _next_index;
		_next_index = (_next_index + 1) min (count AS_ranks - 1);
	};

	if (_prev_index != _curr_index and {_currentScore < _scoreToDemotion}) then {
		private _new_rank = AS_ranks select _prev_index;
		_player setVariable ["rank", _new_rank, true];
		_player setUnitRank _new_rank;

		[petros,"hint",format ["%1: %2.\n\nSAD!",name _player, _new_rank]] remoteExec ["commsMP"];
		_rank = _new_rank;
		_abbreviation = AS_rank_abbreviations select _prev_index;
		_next_index = _curr_index;
	};

	if (_rank == "COLONEL") then {
		_currentScore = 0;
	};
	// update the top bar information.
	private _percentage = (_currentScore / _scoreToPromotion) max 0;
	private _formatData = ["#1DA81D", "#C1C0BB", _abbreviation, AS_rank_abbreviations select _next_index, "Rank"];
	["Rank", _formatData, _percentage] call fnc_updateProgressBar;

	sleep 60;
};
