// sampling rate of FPS
#define SECONDS_PER_SAMPLE 2

private _FPSindex = 0; // the next index of AS_FPSsamples to be updated
while {true} do {
    sleep SECONDS_PER_SAMPLE;
    AS_FPSsamples set [_FPSindex, diag_fps];
    _FPSindex = _FPSindex + 1;
    if (_FPSindex == count AS_FPSsamples) then {
        _FPSindex = 0;
    };
};
