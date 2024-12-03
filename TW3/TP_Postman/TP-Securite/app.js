const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const path = require('path');
const sanitizeHtml = require('sanitize-html');
const rateLimit = require('express-rate-limit');
 
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/login",express.static(path.join(__dirname,'/')));
 
 
const loginLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 5, // Limite à 5 tentatives
    message: 'Trop de tentatives de connexion. Réessayez plus tard.',
});
 
app.post('/login', loginLimiter, (req, res) => {
    const { username, password } = req.body;
    if (username === 'admin' && password === 'password123') {
        res.send('Connexion réussie');
    } else {
        res.status(401).send('Nom d’utilisateur ou mot de passe incorrect');
    }
});

app.use((req, res, next) => {
    res.setHeader(
        'Content-Security-Policy',
        "default-src 'self'; script-src 'self'; style-src 'self';"
    );
    next();
});


 
app.listen(3000, () => {
    console.log('Serveur en cours d’exécution sur http://localhost:3000');
});