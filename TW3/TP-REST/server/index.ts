import { default as e, default as express } from "express";
import libraryRouter from "./routes/library";
import movieRouter from "./routes/movies";

const app = express();

// Serve the folder 'public' as a static folder
app.use(express.static("public"));
// Parse JSON bodies (as sent by API clients)
app.use(express.json());

// Use the router from library.ts
app.use(libraryRouter);
app.use(movieRouter);

app.use((err: Error, req: e.Request, res: e.Response, next: e.NextFunction) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

// Start the server
app.listen(3000, () => {
  console.log("Server started on port 3000");
});
