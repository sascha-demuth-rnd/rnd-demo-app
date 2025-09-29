# ---- Build Stage ----
FROM node:22-alpine AS builder
WORKDIR /app

# 1) Nur die Manifeste für Cache nutzen
COPY package.json ./
COPY package-lock.json ./

# 2) Dependencies installieren (reproduzierbar)
RUN npm ci --no-audit --no-fund

# 3) Restlichen Code kopieren und bauen
COPY . .
RUN npm run build

## ---- Runtime Stage ----
FROM nginxinc/nginx-unprivileged:stable-alpine

# eigene SPA-Config rein
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Build-Ergebnis kopieren
COPY --from=builder /app/dist /usr/share/nginx/html

# Exposed Port ist 8080 in diesem Image
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]