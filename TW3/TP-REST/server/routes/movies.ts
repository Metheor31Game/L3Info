import express from "express";
import { getMovies } from "../models/movies";

const router = express.Router();

export default router;

router.get('/movies', async (req,res) => {
    const query = req.query;
    const movies = await getMovies(query);
    res.json(movies);
});
