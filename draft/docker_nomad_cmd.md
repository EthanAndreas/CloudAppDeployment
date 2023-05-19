# Creation des Dockerfile
## Dockerfile du frontend
Le Dockerfile du frontend est dans le dossier web
```bash
cd web
docker build -t frontend . 
```
> On peux tester l'image avec la commande `docker run -p 3000:3000 frontend:latest`

L'image est a present disponible dans le registry local, on peut la voir avec la commande `docker images`. Dans notre cas, on utilisera le registry de Github pour stocker nos images car Nomad peut y acceder.
```bash
docker tag frontend ghcr.io/loskeeper/frontend:v1.0.0
docker push ghcr.io/loskeeper/frontend:v1.0.0
```

## Dockerfile du backend/worker
Le Dockerfile du backend est dans le dossier api
```bash
cd api
docker build -t worker . 
```
> On peux tester l'image avec la commande `docker run -p 8080:8080 worker:latest`

L'image est a present disponible dans le registry local, on peut la voir avec la commande `docker images`. Dans notre cas, on utilisera le registry de Github pour stocker nos images car Nomad peut y acceder.
```bash
docker tag worker ghcr.io/loskeeper/worker:v1.0.0
docker push ghcr.io/loskeeper/worker:v1.0.0
```

# Creation des tasks Nomad
Le fichier de configuration des tasks est dans le dossier nomad
```bash
cd nomad
nomad job run conf_nomad.hcl
```
Le fichier est composé de 3 groupes de taches:
- Le groupe frontend qui contient une seule tache qui est le frontend
- Le groupe worker qui contient une seule tache qui est le worker
- Le groupe haproxy qui contient une seule tache qui est le haproxy qui est lancé sur toutes les machines du cluster