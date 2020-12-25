

if [[ -f pids.out ]];then
    echo "Shutting down wekan"
    wekan_pid=$(awk 'NR==1' pids.out)
    mongo_pid=$(awk 'NR==2' pids.out)
    singularity_pid=$(awk 'NR==3' pids.out)
    kill $wekan_pid
    sleep 2
    kill $mongo_pid
    sleep 2
    kill $singularity_pid
    rm pids.out
    echo "Completed"
else
    echo "Wekan does not seem to be running"
fi
