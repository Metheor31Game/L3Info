import express from "express";
import { engine } from "express-handlebars";
import path from "path";
import restaurant from "./models/restaurant";

const app = express();

app.get("/ping", (req, res) => {
  res.sendStatus(200);
});

app.engine("handlebars", engine());
app.set("view engine", "handlebars");
app.set("views", "./views");

app.get("/", (req, res) => {
  res.render("home", restaurant);
});

// app.get("/", (req, res) => {
//   const cheminIndex = path.join(__dirname, "index.html");
//   res.sendFile(cheminIndex);
// });

app.use("/assets", express.static(path.join(__dirname, "assets")));

app.listen("3000", () => {
  console.log("Serveur lancé");
});

//test
