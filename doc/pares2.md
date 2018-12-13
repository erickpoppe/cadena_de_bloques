## Despliegue de par participante adicional a la cadena de bloques de Hyperledger Fabric
#### Se puede desplegar un par adicional con su base de datos adjunta como servicio en el Docker Swarm 
#### Para eso se crea el archivo de configuración del servicio de par adicional con su base de datos adjunta:
```  
version: "3"
networks:
   hyperledger-ov:
      external:
         name: hyperledger-ov

services:
   couchdb2:
      hostname: couchdb2.gob.bo
      image: hyperledger/fabric-couchdb:0.4.10
      environment:
         - COUCHDB_USER=
         - COUCHDB_PASSWORD=
         - CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=hyperledger-ov
      ports:
         - "7984:5984"
      deploy:
         replicas: 1
         restart_policy:
            condition: on-failure         
      networks:
         hyperledger-ov:
            aliases:
               - couchdb2
      volumes:
         - couchdb2.gob.bo:/opt/couchdb/data      
   peer2agetic:
      hostname: peer2.agetic.gob.bo
      image: hyperledger/fabric-peer:1.2.0 
      environment:
         - CORE_LEDGER_STATE_STATEDATABASE=CouchDB
         - CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=couchdb2:5984
         - CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=
         - CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=
         - CORE_PEER_ADDRESS=peer2.agetic.gob.bo:7051
         - CORE_PEER_LOCALMSPID=AgeticMSP
#         - CORE_PEER_ADDRESSAUTODETECT=true         
         - CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
         - CORE_LOGGING_LEVEL=DEBUG 
#         - CORE_PEER_NETWORKID=peer1agetic
#         - CORE_NEXT=true
#         - CORE_PEER_ENDORSER_ENABLED=true
         - CORE_PEER_ID=peer2.agetic.gob.bo
         - CORE_PEER_PROFILE_ENABLED=true
         - CORE_PEER_GOSSIP_USELEADERELECTION=true
         - CORE_PEER_GOSSIP_ORGLEADER=false
#         - CORE_PEER_COMMITTER_LEDGER_ORDERER=orderer0.gob.bo:7050 
#         - CORE_PEER_GOSSIP_IGNORESECURITY=true
         - CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=hyperledger-ov
         - CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer2.agetic.gob.bo:7051
         - CORE_PEER_GOSSIP_BOOTSTRAP=peer1.agetic.gob.bo:7051
         # TLS enabled
         - CORE_PEER_TLS_ENABLED=true
         - CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/fabric/tls/server.crt
         - CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/fabric/tls/server.key
         - CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt
      volumes:
         - /var/run/:/host/var/run/
         - /home/erick/crypto-config/peerOrganizations/agetic.gob.bo/peers/peer2.agetic.gob.bo/msp/:/etc/hyperledger/fabric/msp
         - /home/erick/crypto-config/peerOrganizations/agetic.gob.bo/peers/peer2.agetic.gob.bo/tls/:/etc/hyperledger/fabric/tls
         - peer2.agetic.gob.bo:/var/hyperledger/production
      working_dir: /opt/gopath/src/github.com/hyperledger/fabric/peer
      command: peer node start   
      deploy:
         replicas: 1
         restart_policy:
            condition: on-failure   
      ports:
         - "9051:7051"
         - "9053:7053"
      networks:
         hyperledger-ov:
            aliases:
               - peer2.agetic.gob.bo
volumes:
   couchdb2.gob.bo:
   peer2.agetic.gob.bo: 
```  
#### Luego se despliega el servicio con el comando:
```  
docker stack deploy -c hyperledger-peer2.yml hyperledger-peer2
```  
#### [Volver atrás](Uso.md)