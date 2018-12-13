## __**Red "Overlay" para contenedores en Docker Swarm**__
#### 1. La red overlay requiere crear un Docker Swarm que se crea mediante:
```  
docker swarm init
```
#### Después se mostrará la forma en que un ***worker*** se une al swarm.
```  
docker swarm join --token <AQUI VIENE EL TOKEN>   <DIRECCION IP DE INTERFAZ>:2377
```  
#### Para unir un ***manager***  (representa otro host) al swarm se debe ejecutar en el host que creo el swarm:
```  
docker swarm join-token manager 
```  
#### Produce el mismo resultado de token que en el caso del ***worker***, que debe escribirse en el host que desea unirse al swarm como ***manager***.
#### 2. Se crea la red ***overlay*** sobre el swarm: 
```  
docker network create --attachable --driver overlay --subnet=10.200.1.0/24 NOMBRE_DE_LA_RED
```  
#### La dirección subnet se elije en el segmente 10.0.0.0/24 a 10.255.255.255/24
#### [Volver atrás](Uso.md)
