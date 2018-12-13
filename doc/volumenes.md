# Manejo de volumenes en Docker

## Extraer una sub carpeta desde un volumen y copiarla a otro volumen

Primero crear el volumen de destino:

```sh
docker volume create destino
```

Despues levantar un contenedor efimero montando el volumen de destino y el volumen de origen y copiar el contenido:

```sh
docker run --rm -v origen:/origen -v destino:/destino alpine:3.8 cp -r /origen/algun-path/* /destino
```

Para verificar el resultado puedes levantar otro contenedor efimero montando el volumen de destino:

```sh
docker run --rm -v destino:/destino alpine:3.8 ls -la /destino
```

## Mas informaciones

```
docker run --rm -v crypto-config:/crypto-config -v $(pwd):/backup alpine:3.8 tar -C /crypto-config/peerOrganizations/agetic.gob.bo/peers/ -cvf /backup/peer0.agetic.gob.bo.tar peer0.agetic.gob.bo
```

```
docker run --rm -v crypto-peer1:/crypto -v $(pwd):/backup alpine:3.8 tar -C /crypto -xvf /backup/peer1.agetic.gob.bo.tar --strip 
```

[Documentacion oficial de Docker](https://docs.docker.com/storage/volumes/)
