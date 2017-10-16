#!/bin/sh

# keep last $KEEP executions for each job
KEEP=@option.KEEP@


cd /var/lib/rundeck/logs/rundeck

JOBS=@option.PROJECT@/job/@option.UUID@/logs

for j in $JOBS ; do
        echo "Processing job $j"
        ids=`find $j -iname "*.rdlog" | sed -e "s/.*\/\([0-9]*\)\.rdlog/\1/" | sort -n -r`
        declare -a JOBIDS=($ids)

        if [ ${#JOBIDS[@]} -gt $KEEP ]; then
          for job in ${JOBIDS[@]:$KEEP};do
             echo " * Deleting job: $job"
             echo "   rm -rf $j/$job.*"
             rm -rf $j/$job.*
             echo "   mysql -u rundeck -p 'delete from execution where id=$job'"
             mysql -u rundeck -ppassword rundeck -e "delete from execution where id=$job"
             echo "   mysql -u rundeck -p -c 'delete from base_report where jc_exec_id=${job}'"
             mysql -u rundeck -ppassword rundeck -e "delete from base_report where jc_exec_id=${job}"
             mysql -u rundeck -ppassword rundeck -e "commit"
          done
        fi
done
