# Usa un'immagine di base con Node.js
FROM node:14

# Crea una directory di lavoro
WORKDIR /app

# Copia il file package.json e package-lock.json
COPY package*.json ./

# Installa le dipendenze
RUN npm install

# Copia i file dell'applicazione nell'immagine Docker
COPY . .

# Esponi la porta in cui il server Express.js ascolterà
EXPOSE 8181

# Avvia l'applicazione
CMD ["npm", "start"]

    
