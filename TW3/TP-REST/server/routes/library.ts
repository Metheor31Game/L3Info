import express from "express";
import { getLibraryMovieById } from "../models/library";

const router = express.Router();

export default router;


router.get("/library/:movieId", async (req,res) => {
    const id = req.params.movieId;

    try {
        const movie = await getLibraryMovieById(id);
        res.json(movie);
    } catch {
        res.status(404).send("Not Found !");
    }

});
