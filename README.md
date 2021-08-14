#Deploy multi-host First Network (using Fabric v2.2 and Docker Swarm)

`curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`

`docker network create --attachable --driver overlay first-network`

#Display container names in required format

`docker ps --format "table{{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.RunningFor}}"`

https://kctheservant.medium.com/multi-host-setup-with-raft-based-ordering-service-29730788b171

https://kctheservant.medium.com/multi-host-deployment-for-first-network-hyperledger-fabric-v2-273b794ff3d

