## Deploy multi-host Hyperledger Fabric Network (using Fabric v2.2 and Docker Swarm)

`curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`

`docker run -itd --name mybusybox --network first-network busybox`

`docker start $(docker ps -aq)`

## Display container names in required format

`docker ps --format "table{{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.RunningFor}}"`

## Installation
[Step 1](https://kctheservant.medium.com/multi-host-setup-with-raft-based-ordering-service-29730788b171) 

[Step 2](https://kctheservant.medium.com/multi-host-deployment-for-first-network-hyperledger-fabric-v2-273b794ff3d)

## License
MIT

