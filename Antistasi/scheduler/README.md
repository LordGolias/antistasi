# Scheduler

The Scheduler is an API to distribute jobs across every machine participating on the mission.

The workflow is the following: every non-server has a infinite loop that monitors
their own FPS, and sends them to the server (`fnc_sendStatus`). Likewise,
the server receives this and stores it (`fnc_receiveStatus`).

New jobs are submitted to be executed using `fnc_execute`. This function uses
a load balancer (`fnc_getWorker`) to select the best machine to execute it,
and uses `remoteExec` to submit the job.
