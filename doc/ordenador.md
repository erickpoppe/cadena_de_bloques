# Sistema modular de ordenamiento y creación de bloques

![Sistema modular de ordenamiento de bloques](img/ordenador.png)

El sistema modular ordenamiento puede constar de varios nodos ordenadores como se muestra en la figura (OSN1, OSN2, etc) 

Cada nodo ordenador, se encarga de recibir las propuestas de transacción (broadcast) y una vez ***ordenado***, el bloque se crea y se añade en cada base de datos adyacente a cada miembro participante (peer) de la cadena de bloques.

El sistema ordenador se apoya en el clúster de Apache Kafka y Apache Zookeeper como consenso, tal como se muestra en la figura.

## 1. Crear el archivo docker compose para el stack de servicios del ordenador

Crear el archivo **orderer.yml** según el  [ejemplo](/src/orderer.yml) y editar los valores según las exigencias.


**NOTA** El ejemplo de configuracion incluye el ***peer0.agetic.gob.bo*** . Este representa el par de anclaje de la organización Agetic y es el buscado por los demas pares de su organización para información del canal de la cadena de bloques.

## 2. Arrancar el stack de servicios

```sh
docker stack deploy -c orderer.yml orderer
```
