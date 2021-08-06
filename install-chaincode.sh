pushd ../chaincode/fabcar/go
go mod vendor
popd

# packaging
docker exec cli peer lifecycle chaincode package fabcar.tar.gz --path github.com/chaincode/fabcar/go --label fabcar_1
# peer0.org1
docker exec cli peer lifecycle chaincode install fabcar.tar.gz
# peer1.org1
docker exec -e CORE_PEER_ADDRESS=peer1.org1.example.com:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt cli peer lifecycle chaincode install fabcar.tar.gz
# peer0.org2
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:9051 -e CORE_PEER_LOCALMSPID="Org2MSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt cli peer lifecycle chaincode install fabcar.tar.gz
# peer1.org2
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer1.org2.example.com:10051 -e CORE_PEER_LOCALMSPID="Org2MSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt cli peer lifecycle chaincode install fabcar.tar.gz
