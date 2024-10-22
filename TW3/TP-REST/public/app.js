import { createMovieCard } from "./movie-card.js";
async function main() {
  const input = document.querySelector("[data-search-input]");
  const movies = await getMovies("");
  renderMovies(movies);

  input.addEventListener("input", async (event) => {
    const valeur = event.target.value;
    const movies = await getMovies(valeur);
    renderMovies(movies);
  });
}

async function getMovies(query) {
  const response = await fetch(`/movies?query=${query}`);
  const movies = await response.json();

  for (const movie of movies) {
    const libraryMovie = await getLibraryMovie(movie.id);
    console.log(libraryMovie);
    if (libraryMovie) {
      movie.isInLibrary = true;
      movie.rating = libraryMovie.rating;
    } else {
      movie.isInLibrary = false;
    }
  }
  console.table(movies);

  return movies;
}

async function renderMovies(movies) {
  let container = document.querySelector("[data-movies]");
  container.innerHTML = "";
  movies.forEach((element) => {
    const carte = createMovieCard({ movie: element });
    container.appendChild(carte);
  });
}

async function getLibraryMovie(id) {
  const reponse = await fetch(`/library/${id}`);
  if (reponse.status != 404) {
    const movie = await reponse.json();
    return movie;
  } else {
    return false;
  }
}

async function addMovieToLibrary(id) {
  const reponse = await fetch({
    url: `/library/${id}`,
    method: "POST",
    headers: { "Content-Type": "application/json"},
    body: JSON.stringify({
      id:movieId,
    })

  })
}

main();
