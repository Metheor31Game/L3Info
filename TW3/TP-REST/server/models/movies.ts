import movies from "./data/movies.json";

type Movie = {
  id: string;
  title: string;
  year: number;
  summary: string;
  posterUrl: string;
};

/**
 * Get movies from the database
 *
 * @param searchOptions - Search options to filter movies by title
 * @returns A list of movies
 */
export async function getMovies(searchOptions?: {
  query?: string;
}): Promise<Movie[]> {
  return movies
    .filter((movie) => {
      if (!searchOptions?.query) return true;
      return movie.title
        .toLowerCase()
        .includes(searchOptions.query.toLowerCase());
    })
    .sort((a: Movie, b: Movie) => a.title.localeCompare(b.title));
}
