// Importation des modules nécessaires : Express et fs

const express = require('express');
const fs = require('fs');

// Créez une application Express
const app = express();

// Définissez un port pour votre serveur
const PORT = 3000;

//route principale qui renvoie un message de bienvenue

app.get('/', callback);

function callback(req, res) {
    res.send('Bienvenue à toi jeune padawan');
}

// Route qui lit le contenu du fichier data.txt et l'affiche (à compléter)
app.get('/readfile', (req, res) => {
    //utiliser fs pour lire le fichier data.txt
    fs.readFile('data.txt', 'utf8', (err, data) => {
        if (err) {
            res.status(500).send('Erreur lors de la lecture du fichier');
        } else {
            //Envoyer le contenu du fichier en réponse
            res.send(data);
        }
    } );
});

// Démarrez le serveur pour qu'il écoute sur le port défini (à compléter)
app.listen(PORT, () => { // Complétez avec le port sur lequel votre serveur va écouter
    console.log(`Serveur démarré sur le port ${PORT}`);
});