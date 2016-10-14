# Seccubus Docker container

Container build for https://www.seccubus.com/

# Usage
```
docker run -dit -p 80:80 -v $SOMEDIR:/var/lib/mysql karlnewell/seccubus
```

entrypoint.sh is reentrant.  Mount /var/lib/mysql from a host directory to preserve database. 
