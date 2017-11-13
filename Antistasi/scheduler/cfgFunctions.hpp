class AS_scheduler {
    class server {
        FNC(scheduler,getWorker);
        FNC(scheduler,execute);
        FNC(scheduler,receiveStatus);
    };
    class common {
        INIT_FNC(scheduler,init);
        FNC(scheduler,sendStatus);
        FNC(scheduler,measureFPS);
    };
};
