# Despliegue de herramientas de configuración de la cadena de bloques de Hyperledger Fabric (CLI) mediante un servicio en Docker

Es necesario contar con volumenes donde se encuentren los certificados para el peer0: ./crypto-config/peerOrganizations/agetic.gob.bo/peers/peer0.agetic.gob.bo/. También se necesitan los archivos de configuración del canal creados (channel-artifacts) y el chaincode que se desea instalar (chaincode) en la carpeta donde se levanta el contenedor.   

Esta herramienta de configuración debe arrancarse desde el mismo **host**, donde se encuentra el peer0 que está adherido al orderer0 de la cadena de bloques. Los certificados que maneja, pertenecen al peer0.
## 1. Configurar el CLI

Crear el archivo de configuración según el [ejemplo](/src/cli.yml).

## 2. Se procede a levantar mediante:

```sh
docker stack deploy -c cli.yaml cli
```

## 3. Conifgurar el archivo /etc/hosts
```sh  
docker exec -it cli.NOMBRE-DEL-CONTENEDOR-CLI bash  
```  
Dentro del contenedor, se debe editar el archivo /etc/hosts para referenciar el IP usado de los otros peers que deben tener conexión a esta herramienta de configuración de la cadena de bloques.

## 4. Dentro el contenedor, editar el archivo /etc/hosts:
```sh
X.X:X.X    peer1.agetic.gob.bo
Y.Y.Y.Y    peer2.agetic.gob.bo
```
En este caso X.X.X.X e Y.Y.Y.Y representan las direcciones IP donde se encuentran los peer1 y peer2 respectivamente.
## 5. También dentro el contenedor agregar las variables de entorno:

```sh
export CHANNEL_NAME=micanal
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/gob.bo/orderers/orderer0.gob.bo/msp/tlscacerts/tlsca.gob.bo-cert.pem
```

## 6. Arrancar el canal

```sh
peer channel create -o orderer0.gob.bo:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
```

El paso anterior creará el archivo *micanal.block* en el directorio actual

Ahora se debe unir cada participante al canal:

```sh
peer channel join -b micanal.block
```

Se debe realizar la misma instrucción con todos los participantes (peers) que forman parte del canal (micanal) cambiando la variable de entorno:

```sh
export CORE_PEER_ADDRESS=peerX.agetic.gob.bo:7051
```

Donde se reemplaza X, por el peer que desea unir al canal (0,1,2,etc.). Se debe tener en cuenta que el puerto del participante puede ser diferente a 7051. (8051, 9051, etc.)

## 7. Ahora se debe actualizar el canal:

```sh
peer channel update -o orderer0.gob.bo:7050 -c $CHANNEL_NAME -f ./channel-artifacts/AgeticMSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
```

## 8. Una vez actualizado se puede instalar el código de cadena para trabajar en el canal.

```sh
CC_SRC_PATH="github.com/chaincode/chaincode_example02/"
```
En este ejemplo el chaincode esta localizado en la carpeta "github.com/chaincode/chaincode_example02/" de acuerdo a como se configuró el archivo cli.yml
Se debe colocar CC_SRC_PATH con el directorio donde se levanta el código de cadena (chaincode) de acuerdo al archivo cli.yml

Instalando el código de cadena:

```sh
peer chaincode install -n nombre_del_código_de_cadena -v versión -p ${CC_SRC_PATH}
```

## 9. Instalado el código, se debe instanciar el código de cadena:

```sh
peer chaincode instantiate -o orderer0.gob.bo:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n nombre_del_código_de_cadena -v versión -c '{"Args":[""]}'
```

Esto instancia un contenedor sin ningún argumento de entrada
Demora algunos segundos en iniciar el contenedor.
#### Se debe repetir el mismo proceso de instalación e instanciación en los diferente participantes (peers) que se encuentren en redes locales diferentes con IPs diferentes.

## 10. Finalmente se puede invocar cualquier función de las tres de un código de cadena: QUERY,INVOKE,INIT con sus respectivos argumentos.

```sh
peer chaincode invoke -o orderer0.gob.bo:7050 -C $CHANNEL_NAME --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -n nombre_del_código_de_cadena -c '{"function":"invoke","Args":["Aqui vienen los argumentos"]}'
```

## 11. El manejo posterior puede realizarse mediante el SDK en NodeJS para el manejo de la cadena de bloques de Hyperledger Fabric. [Ejemplo de manejo del SDK](https://gitlab.geo.gob.bo/agetic/sdk_blockchain)
