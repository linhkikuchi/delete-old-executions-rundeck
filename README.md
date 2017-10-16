# Delete-Old-Executions-Rundeck

### deleteOldExecutionFromAPI.py
A python script to delete old executions on Rundeck

Run script in a rundeck job with 
- Invocation String
`python -u`
- Options
`KeepDays`: no of days to keep executions, `LimitJobs`: a list separated by comma of job UUID

### deleteOldExecutionFromDB.sh
- This script is for cases that there are too many executions to delete and API cannot handle it
- Run the script in rundeck job with Options
`KEEP`: no of days to keep executions, `PROJECT`: project name of the job, `UUID`: job UUID