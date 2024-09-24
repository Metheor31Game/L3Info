import express from "express";
import { engine } from "express-handlebars";
import path from "path";
import restaurant from "./models/restaurant";
import menus from "./models/menus";

const app = express();

app.get("/ping", (req, res) => {
  res.sendStatus(200);
});

app.engine("handlebars", engine());
app.set("view engine", "handlebars");
app.set("views", "./views");

app.get("/", (req, res) => {
  res.render("home", {
    restaurant,
    title: restaurant.name,
  });
});

app.get("/menus", (req, res) => {
  res.render("menu", {
    menus,
    title: "Menu - " + restaurant.name,
  });
});

app.get("/commander", (req, res) => {
    res.render("commande", menus);
    const menuID = req.query.menu;
    const menuAAfficher = menus.find(elCourant => elCourant.id == menuID);
    res.render() //CONTINUER ICI
});

// app.get("/", (req, res) => {
//   const cheminIndex = path.join(__dirname, "index.html");
//   res.sendFile(cheminIndex);
// });

app.use("/assets", express.static(path.join(__dirname, "assets")));

app.listen("3000", () => {
  console.log("Serveur lancé");
});
