class AS_scheduler {
    class server {
        FNC(scheduler,getWorker);
        FNC(scheduler,execute);
        FNC(scheduler,receiveStatus);
    };
    class common {
        FNC(scheduler,initialize);
        FNC(scheduler,sendStatus);
        FNC(scheduler,measureFPS);
    };
};
