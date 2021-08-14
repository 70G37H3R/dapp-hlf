# 4host-swarm
Deploy multi-host First Network (using Fabric v2.2)
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9

generate the required material.
../bin/cryptogen generate --config=./crypto-config.yaml

export FABRIC_CFG_PATH=$PWD

mkdir channel-artifacts

../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block

../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP


docker ps --format "table{{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.RunningFor}}"

