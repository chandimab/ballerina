package ballerina.task;

@Description { value:"Schedules a timer task"}
@Param { value:"onTrigger: The function which gets called when the timer goes off" }
@Param { value:"onError: The function that gets called if the onTrigger function returns an error" }
@Param { value:"schedule: Specifies the initial delay and interval of the timer task" }
@Return { value:"string: The unique ID of the timer task that was scheduled" }
@Return { value:"error: This error will be returned if an occurs while scheduling the timer task" }
public native function scheduleTimer (
  function() returns (error) onTrigger,
  function(error e) onError,
  struct {
    int delay = 0;
    int interval;
  } schedule) returns (string taskId, error e);

@Description { value:"Stops the timer task with ID taskID"}
@Param { value:"taskID: The unique ID of the timer task that has to be stopped" }
@Return { value:"error: This error will be returned if an error occurs while stopping the task" }
public native function stopTask (string taskID) returns (error);