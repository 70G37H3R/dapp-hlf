#docker images dev-*
# for org1
docker exec cli peer lifecycle chaincode approveformyorg --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --channelID mychannel --name mycc --version 1 --sequence 1 --waitForEvent --package-id mycc_1:2f6ebf4c5869abd9bd95669b9568ef04cc35fb92d35ef95486586371fc5546f9
sleep 5
# for org2
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:9051 -e CORE_PEER_LOCALMSPID="Org2MSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt cli peer lifecycle chaincode approveformyorg --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --channelID mychannel --name mycc --version 1 --sequence 1 --waitForEvent --package-id mycc_1:2f6ebf4c5869abd9bd95669b9568ef04cc35fb92d35ef95486586371fc5546f9
sleep 5
# check approval status
docker exec cli peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name mycc --version 1 --sequence 1
