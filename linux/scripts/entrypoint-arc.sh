#!/bin/bash

set -o nounset

# [SETUP]

# start docker
echo "Starting docker..."
sudo service docker start > /dev/null
sleep 5
if [[ "$(service docker status)" == *"Docker is running"* ]]; then
    echo "Done!"
else
    echo "Docker didn't start, status is:"
    service docker status
    exit 1
fi

# [START]

/home/runner/run.sh
