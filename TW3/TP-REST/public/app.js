import { createMovieCard } from './movie-card.js'
async function main() {
    const input = document.querySelector('[data-search-input]');
    const movies = await getMovies("");
    renderMovies(movies);
    

    input.addEventListener('input', async (event) => {
        const valeur = event.target.value;
        const movies = await getMovies(valeur);
        renderMovies(movies);
    });


}


async function getMovies(query) {
    const response = await fetch(`/movies?query=${query}`);
    const movies = await response.json();
    return movies
}

async function renderMovies(movies) {
    let container = document.querySelector('[data-movies]');
    container.innerHTML = "";
    movies.forEach(element => {
        const carte = createMovieCard({movie:element});
        container.appendChild(carte);
    });
}


main();
