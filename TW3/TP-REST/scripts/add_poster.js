const fs = require("fs");
const path = require("path");

const moviePath = path.join(__dirname, "../server/models/data/movies.json");
async function addPoster() {
  const movies = JSON.parse(fs.readFileSync(moviePath));
  console.log(movies);
  const movieWithPoster = await Promise.all(
    movies.map(async (movie) => {
      console.log("Fetching poster for", movie.title);
      const result = await fetch(
        `https://api.themoviedb.org/3/search/movie?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&query=${movie.title}`,
      );
      const data = await result.json();
      const poster_path = data.results[0].poster_path;
      const poster_url = `https://image.tmdb.org/t/p/w500${poster_path}`;
      delete movie.pictureUrl;
      movie.posterUrl = poster_url;
      return movie;
    }),
  );
  fs.writeFileSync(moviePath, JSON.stringify(movieWithPoster, null, 2));
}

addPoster();
