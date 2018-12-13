# Instalación de Apache Kafka

Para tener un sistema de consenso modular que pueda ser desplegado en producción en Hyperledger Fabric, se utiliza Apache Kafka.


Apache Kafka utiliza como coordinador de clúster a Apache Zookeeper, por este motivo debe ser desplegado también.

La configuración de una imagen de Apache Zookeeper de 3 miembros, para un clúster de Apache Kafka se muestra a continuación:

## 1. Configurar el stack de Zookeeper:

Crear un archivo `zookeeper.yml` con la descripción de los servicios de Zookeeper para Docker según el [ejemplo](src/zookeeper.yml):

## 2. Levantar el stack de Zookeeper:

Se levanta el **stack** de Apache Zookeeper de Docker con la siguiente instrucción, denominando al stack **zookeeper**:

```sh
docker stack deploy -c zookeeper.yml zookeeper
```

## 3. Configurar el stack de Kafka

Crear un archivo `kafka.yml` con la descripción de los servicios de Kafka para Docker según el [ejemplo](src/kafka.yml):

## 4. Levantar el stack de Kafka:


Se levanta el stack de Apache Kafka con la siguiente instrucción.

```sh
docker stack deploy -c kafka.yml kafka
```

## 5. Continuar con la instalación del Orderer de Fabric

* [Instalación del Orderer](doc/ordenador.md)
