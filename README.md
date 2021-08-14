#Step1: Deploy multi-host First Network (using Fabric v2.2 and Docker Swarm)

`curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`

#Step2: Generate crypto materials:
`../bin/cryptogen generate --config=./crypto-config.yaml`

`export FABRIC_CFG_PATH=$PWD`

`mkdir channel-artifacts`

`../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block`

`../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel`

`../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP`

`../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP`

#Display container names in required format

`docker ps --format "table{{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.RunningFor}}"`

https://kctheservant.medium.com/multi-host-setup-with-raft-based-ordering-service-29730788b171

https://kctheservant.medium.com/multi-host-deployment-for-first-network-hyperledger-fabric-v2-273b794ff3d

