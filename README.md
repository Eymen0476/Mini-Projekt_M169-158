# Mini-Projekt_M169-158

# Mini-Projekt – Container / Cloud

## Aufgabe 1 – Eigener Webserver mit Docker & NGINX

Als erstes wurde eine EC2-Instanz auf AWS erstellt (Ubuntu 26.04, t3.micro). Danach wurde Docker auf der Instanz installiert und ein eigenes Docker-Image gebaut, das einen NGINX-Webserver mit einer einfachen HTML-Webseite beinhaltet. Die Webseite zeigt den Namen Eymen Sarikaya und ist über Port 8080 erreichbar. Logdateien werden lokal in einem Volume gespeichert, damit sie auch nach einem Neustart des Containers noch verfügbar sind.

Das Dockerfile definiert dabei wie das Image aufgebaut wird: Es nimmt NGINX als Basis, kopiert die Webseite rein und startet den Server automatisch beim Hochfahren des Containers.

### Vorgehen

Docker wurde folgendermassen installiert:
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker ubuntu
newgrp docker
```

Danach wurde die Projektstruktur erstellt:
```bash
mkdir -p mini-projekt/website
```

Das Image wurde gebaut und der Container gestartet:
```bash
docker build -t es-webserver .
docker run -d -p 8080:80 -v $(pwd)/logs:/var/log/nginx --name es-webserver es-webserver
```

Mit folgendem Befehl kann überprüft werden ob der Container läuft:
```bash
docker ps
```

Die Webseite ist danach erreichbar unter "http://<AWS-IP>:8080".

---

## Aufgabe 2 – WordPress mit Docker Compose

Im zweiten Teil wurde WordPress mittels Docker Compose in der AWS Cloud in Betrieb genommen. Docker Compose erlaubt es, mehrere Container gleichzeitig zu definieren und zu starten. In diesem Fall laufen zwei Container: einer für WordPress und einer für die MySQL-Datenbank. Die beiden Container kommunizieren über ein internes Bridge-Netzwerk miteinander, sodass die Datenbank nicht von aussen erreichbar ist. WordPress-Daten und Datenbankdaten werden in Volumes gespeichert, damit sie bei einem Neustart erhalten bleiben.

Nach dem Start wurde der WordPress-Installationsdialog im Browser durchgeklickt und eine eigene WordPress-Seite mit dem Namen Eymen Sarikaya erstellt.

### Vorgehen

Projektordner erstellen:
```bash
mkdir wordpress-projekt && cd wordpress-projekt
```

Die `docker-compose.yml` wurde erstellt und danach alle Container gestartet:
```bash
docker compose up -d
```

Status der Container prüfen:
```bash
docker compose ps
```

Logs der Datenbank anzeigen (zur Fehlersuche):
```bash
docker compose logs db
```

Container stoppen:
```bash
docker compose down
```

WordPress ist erreichbar unter "http://<AWS-IP>:8081".

---

## AWS-Konfiguration

Auf AWS wurde eine EC2-Instanz mit folgenden Einstellungen erstellt:

- **Instanz-Typ:** t3.micro (Free Tier)
- **Betriebssystem:** Ubuntu 26.04 LTS
- **Security Group – offene Ports:**
  - Port 22 → SSH-Zugang
  - Port 80 → HTTP
  - Port 8080 → NGINX Webserver
  - Port 8081 → WordPress
