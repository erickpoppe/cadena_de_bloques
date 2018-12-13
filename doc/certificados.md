# Creación de los Certificados

## 1. Clonar el proyecto a utilizar
```sh 
git clone git@gitlab.geo.gob.bo:agetic/cadena_de_bloques.git 
cd cadena_de_bloques 
```  
## 2. Configurar los particiapantes iniciales de la red

Es necesario crear el archivo **crypto-config.yaml** para inicializar la estructura de participantes de la cadena de bloques.

En el [ejemplo](src/crypto-config.yaml) se muestra el contenido del archivo crypto-config.yaml para seis miembros participantes, tres en cada organización Org1 y Org2, que representan a la Agetic y Adsib, mas dos nodos del sistema ordenador.

## 3. Crear una carpeta para la generación de certificados:

```sh
mkdir crypto-config
```

## 3. Ejecutar `cryptogen` mediante la imagen `fabric-tools` de Docker:

Este paso genera los certificados, las llaves privadas y públicas para todos los participantes: peers, ordenadores, autoridad de certificación raíz.

```sh
./cryptogen generate --config=/etc/crypto-config.yaml
```

De acuerdo al ejemplo, la respuesta que se espera es la siguiente en caso exitoso:

```sh
agetic.gob.bo
adsib.gob.bo
```

Todas las llaves y certificados se crearán dentro del volumen Docker llamado *crypto-config* en un archivo denominado *crypto-config*.  Esta estructurado en sub directorios para ordenadores y peers.

## 4. Crear los archivos de configuración del canal que se compartirá entre los participantes autorizados de la cadena de bloques.

Se debe crear el archivo *configtx.yaml* que se utiliza para configurar configtxgen.

El [ejemplo](src/configtx.yaml) representa la configuración con dos entidades: AGETIC y ADSIB.

## 5. Definir el nombre del canal y ejecutar el *configtxgen* mediante la imagen fabric-tools de Docker

```sh
mkdir channel-artifacts
export FABRIC_CFG_PATH=$PWD
export CHANNEL_NAME=micanal
```


```sh
./configtxgen -profile TwoOrgsOrdererGenesis -outputBlock /channel-artifacts/genesis.block
```

Esto crea el bloque inicial de configuración de canal que se guardará en el volumen denominado *channel-artifacts*

## 6. Configurar el canal inicial

```sh
./configtxgen -profile TwoOrgsChannel -channelID $CHANNEL_NAME -outputCreateChannelTx /channel-artifacts/channel.tx
```

## 7. Definir los pares (peers) de anclaje para cada organización que participa de la cadena de bloques:

Por ejemplo, para definir el peer de anclaje de Adsib:

```sh
./configtxgen -profile TwoOrgsChannel -channelID micanal -outputAnchorPeersUpdate /channel-artifacts/AdsibMSPanchors.tx -asOrg AdsibMSP
```

Y para el peer de anclaje de Agetic:

```sh
./configtxgen -profile TwoOrgsChannel -channelID micanal -outputAnchorPeersUpdate /channel-artifacts/AgeticMSPanchors.tx -asOrg AgeticMSP
```

El resultado de estos comandos se encuentra en el volumen denominado **channel-artifacts**

## 8. Siguientes pasos

Una vez generados los certificados e inicializado el canal inicial se puede proceder con los siguientes pasos:

* [Levantar el Orderer y Peer0](doc/ordenador.md)
* [Leventar uno o mas Peers](doc/pares.md)
* (OPCIONAL) [Levantar una Autoridad Certificadora](doc/ca.md)
