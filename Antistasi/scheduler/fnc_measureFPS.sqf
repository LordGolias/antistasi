// sampling rate of FPS
#define SECONDS_PER_SAMPLE 2
// number of samples in the moving average of FPS
#define WINDOW_SIZE 12

private _FPSindex = 0; // the next index of AS_FPSsamples to be updated
while {true} do {
    sleep SECONDS_PER_SAMPLE;
    AS_FPSsamples set [_FPSindex, diag_fps];
    _FPSindex = _FPSindex + 1;
    if (_FPSindex == WINDOW_SIZE) then {
        _FPSindex = 0;
    };
};
