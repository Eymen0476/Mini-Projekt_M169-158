# =====================================================
# Mini-Projekt – Eigenes NGINX Webserver-Image
# Erstellt von: Eymen Sarikaya
# Modul: 169/158 – Container / Cloud
# =====================================================

# Basis-Image: offizielles NGINX auf Alpine Linux (klein & sicher)
FROM nginx:alpine

# Metadaten
LABEL maintainer="Eymen Sarikaya"
LABEL description="Mini-Projekt Webserver – Modul 169/159"

# Website-Dateien ins NGINX-Webroot kopieren
COPY website/ /usr/share/nginx/html/

# Port 80 freigeben (wird beim Start auf 8080 gemappt)
EXPOSE 80

# NGINX im Vordergrund starten (Docker-Best-Practice)
CMD ["nginx", "-g", "daemon off;"]
