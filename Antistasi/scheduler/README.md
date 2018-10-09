# Scheduler

The Scheduler is an API to distribute jobs across every
machine participating on the mission.

Once a machine is ready to execute jobs, it calls
[`fnc_initialize`](fnc_initialize.sqf). This starts an infinite loop that
monitors the machine's own FPS, and sends them to the server using
[`fnc_sendStatus`](fnc_sendStatus.sqf). The server receives this
update and stores it using [`fnc_receiveStatus`](fnc_sendStatus.sqf).

New jobs are submitted to be executed using [`fnc_execute`](fnc_execute.sqf).
This function uses a load balancer ([`fnc_getWorker`](fnc_getWorker.sqf)) to
select the best machine to execute it, and uses `remoteExec` to submit the job.

If a machine is lost, the server takes over its jobs.

Note that this configuration requires every machine to have the necessary
requirements (e.g. have the code) to run every job, and jobs must be written
in a distributed manner.
