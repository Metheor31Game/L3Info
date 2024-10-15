import fs from "fs";
import path from "path";
import rawLibrary from "./data/library.json";
import { BadRequestError, NotFoundError } from "./errors";

const library: Record<string, LibraryMovie> = rawLibrary;

type LibraryMovie = {
  movieId: string;
  rating?: number;
};

/**
 * Get all movies added to the library
 *
 */
export async function getLibraryMovies(): Promise<LibraryMovie[]> {
  return Object.entries(library).map(([movieId, movie]) => ({
    ...(movie as LibraryMovie),
    movieId: movieId,
  })) as LibraryMovie[];
}

export async function getLibraryMovieById(
  movieId: string,
): Promise<LibraryMovie> {
  if (!library[movieId]) {
    throw new NotFoundError("Movie not in library");
  }
  return library[movieId];
}

export async function addMovieToLibrary({
  movieId,
  rating,
}: LibraryMovie): Promise<LibraryMovie> {
  if (library[movieId]) {
    throw new BadRequestError("Movie already in library");
  }
  library[movieId] = { movieId: movieId + "", rating: parseInt(rating + "") };
  saveLibrary();
  return { movieId, rating };
}

export async function removeMovieFromLibrary(movieId: string): Promise<void> {
  if (!library[movieId]) {
    throw new NotFoundError("Movie not in library");
  }
  delete library[movieId];
  saveLibrary();
}

export async function modifyLibraryMovie(
  movieId: string,
  { rating }: LibraryMovie,
): Promise<LibraryMovie> {
  library[movieId] = { movieId, rating };
  saveLibrary();

  return { movieId, rating };
}

async function saveLibrary() {
  fs.writeFileSync(
    path.join(__dirname, "data", "library.json"),
    JSON.stringify(library, null, 2),
  );
}
