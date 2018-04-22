export TZ=Asia/Calcutta

hour=$(date +%H)
minute=$(date +%M)

hour=${hour#0}
minute=${minute#0}

scripts="/root/scripts/memebaseApi/deployment_script"
sudo su

while true
do

	logger -t ping "_CONTINUOUS_DEPLOYMENT_RUNNING_"


	if [ -d "/root/scripts" ]; then
		cd /root/scripts/memebaseApi
		bash $scripts/continuous-deployment-git-scripts.sh $1                     2>&1 | logger -t git-merge
	else
		mkdir -p /root/scripts
		cd /root/scripts
		git clone -b master https://github.com/memebasenitw/memebaseApi.git          2>&1 | logger -t git-merge
	fi


	if [ -d "/root/prod" ]; then
        cd /root/prod/memebaseApi
        bash $scripts/continuous-deployment-update-prod.sh                      2>&1 | logger -t update-prod
    else
        mkdir -p /root/prod
        cd /root/prod
        git clone -b master https://github.com/memebasenitw/memebaseApi.git    2>&1 | logger -t update-prod
    fi

	sleep 60

done