#!/usr/bin/env sh

www.foo.moo:2222

set -e

echo creando canal micanal ...

docker run --rm \
    --hostname cli \
    --add-host orderer0.gob.bo:192.168.21.33 \
    --add-host peer0.agetic.gob.bo:192.168.21.33 \
    --workdir /opt/gopath/src/github.com/hyperledger/fabric/peer \
    -v /var/run/docker.sock:/host/var/run/docker.sock \
    -v crypto-config:/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ \
    -v channel-artifacts:/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/ \
    -e GOPATH=/opt/gopath \
    -e CORE_PEER_ID=cli \
    -e CORE_LOGGING_LEVEL=DEBUG \
    -e CORE_PEER_ADDRESS=peer0.agetic.gob.bo:7051 \
    -e CORE_PEER_LOCALMSPID=AgeticMSP \
    -e CORE_PEER_TLS_ENABLED=true \
    -e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/agetic.gob.bo/peers/peer0.agetic.gob.bo/tls/server.crt \
    -e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/agetic.gob.bo/peers/peer0.agetic.gob.bo/tls/server.key \
    -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/agetic.gob.bo/peers/peer0.agetic.gob.bo/tls/ca.crt \
    -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/agetic.gob.bo/users/Admin@agetic.gob.bo/msp \
    -e ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/gob.bo/orderers/orderer0.gob.bo/msp/tlscacerts/tlsca.gob.bo-cert.pem \
    hyperledger/fabric-tools:1.3.0 \
        peer channel create \
            -o orderer0.gob.bo:7050 \
            -c micanal \
            -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channel.tx \
            --tls true \
            --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/gob.bo/orderers/orderer0.gob.bo/msp/tlscacerts/tlsca.gob.bo-cert.pem

