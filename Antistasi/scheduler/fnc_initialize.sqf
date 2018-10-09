// number of samples in the moving average of FPS
#define WINDOW_SIZE 12

AS_FPSsamples = []; // the recent FPS samples of each machine (local)
for "_i" from 0 to WINDOW_SIZE do {
    AS_FPSsamples pushBack 60;
};

if isServer then {
    // the server stores status of the clients
    AS_workers = createSimpleObject ["Static", [0, 0, 0]];
    AS_workers setVariable ["_all", []];
} else {
    // clients send status to the server
    [] spawn {
        while {true} do {
            call AS_scheduler_fnc_sendStatus;
            sleep 5;
        };
    };
};
// all sides measure FPS
[] spawn AS_scheduler_fnc_measureFPS;
