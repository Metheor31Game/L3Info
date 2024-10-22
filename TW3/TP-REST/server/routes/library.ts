import express from "express";
import {
  getLibraryMovieById,
  addMovieToLibrary,
  removeMovieFromLibrary,
} from "../models/library";

const router = express.Router();

export default router;

router.get("/library/:movieId", async (req, res) => {
  const id = req.params.movieId;

  try {
    const movie = await getLibraryMovieById(id);
    res.json(movie);
  } catch {
    res.status(404).send("Not Found !");
  }
});

router.post("/library", async (req, res) => {
  const libraryMovie = req.body;
  try {
    await addMovieToLibrary(libraryMovie);
    res.json(libraryMovie);
  } catch {
    res.status(400).send();
  }
});

router.delete("/library/:movieId", async (req, res) => {
  const id = req.params.movieId;

  try {
    await removeMovieFromLibrary(id);
    res.end();
  } catch {
    res.status(404).send("Movie not in library");
  }
});
