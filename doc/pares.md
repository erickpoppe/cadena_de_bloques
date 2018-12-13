# Manual de instalacion de los Peers

Los pares que participan de la cadena pueden tomar el rol de ***endorsadores*** para las transacciones nuevas.

Normalmente se despliegan los pares dentro de contenedores, que comparten el volumen del host /var/run para poder conectar el socket Unix al contenedor. Esto permite la creación de nuevos contenedores desde el contenedor par, lo que se utiliza para instanciar el ***chaincode*** o código interno de cadena de bloques.

El contenedor de cada Peer necesita una ***bases de datos*** tipo couchDB. Esta base de datos representa el ***estado actual*** del libro mayor de cuentas de la cadena de bloques.

## 1. Crear el archivo de configuración

Crear el archivo de configuración `peers.yml` según el [ejemplo](/src/peers.yml).

## 2. Contar con certificados y llaves creados previamente

Se debe tener los certificados y llaves creados previamente al crear el orderer y el peer0 en la carpeta actual. Solamente es necesaria la carpeta del peer que se quiere levantar. Por ejemplo, para el peer1 solo es necesaria la siguiente carpeta: */crypto-config/peerOrganizations/agetic.gob.bo/peers/peer1.agetic.gob.bo* 

## 3. Desplegar el stack de servicios de los peers

```sh
docker stack deploy -c peers.yml peers
```  

## 4. Modificar archivo /etc/hosts del contenedor del peer:
```sh 
docker exec -it NOMBRE-DEL-CONTENEDOR-DEL-PEER bash
```  
Luego dentro de este contenedor, se debe editar el archivo /etc/hosts para identificar el IP con el nombre del peer al cual se debe conectar. Por ejemplo:
```sh 
X.X.X.X    orderer0.gob.bo
X.X.X.X    orderer1.gob.bo
X.X.X.X    peer0.agetic.gob.bo
```  
En este caso, X.X.X.X representa la IP donde se encuentran los servicios del orderer y el peer0.

