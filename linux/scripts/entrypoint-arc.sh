#!/bin/bash

set -o nounset

# [SETUP]

# Set the inner (DinD) docker bridge MTU to the pod's egress MTU before dockerd starts,
# so build containers never emit packets larger than the pod egress path allows
# Falls back to 1450 (flannel MTU) if detection fails
IFACE=$(awk '$2=="00000000"{print $1; exit}' /proc/net/route)
MTU=$(cat "/sys/devices/virtual/net/${IFACE}/mtu" 2>/dev/null)
if [[ -z "${MTU}" ]]; then
    MTU=1450
fi
echo "pod egress iface=${IFACE} mtu=${MTU}"
sudo mkdir -p /etc/docker
if echo "{\"mtu\": ${MTU}}" | sudo tee /etc/docker/daemon.json > /dev/null; then
    echo "set inner docker bridge MTU to ${MTU}"
fi

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
