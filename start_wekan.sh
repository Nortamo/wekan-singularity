set -e

if [[ -f pids.out  ]];then

    echo "Pid file has not been removed"
    echo "Check that wekan has been shutdown properly"
    exit 1 

fi

nohup singularity run -B /home/hnortamo/Projects/wekan/db:/data/db -B /home/hnortamo/Projects/wekan/wekan_run.env:/etc/default/wekan wekan.sif &
sleep 3 
mongo_pid=$(ps -aux --sort=start_time | grep mongod | grep -v "grep" | tail -n 1 | awk '{print $2}')
wekan_pid=$(ps -aux --sort=start_time | grep "node main\.js" | grep -v "grep" | tail -n 1 | awk '{print $2}')
singularity_pid=$(ps -aux --sort=start_time | grep sing | grep -v "grep" | tail -n 1 | awk '{print $2}')
echo $wekan_pid > pids.out
echo $mongo_pid >> pids.out 
echo $singularity_pid >> pids.out
