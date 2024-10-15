/**
 * Create a movie card element to be appended to the DOM.
 *
 * @param {{
 *  movie: {
 *    id: string,
 *    title: string,
 *    summary: string,
 *    posterUrl: string,
 *    isInLibrary: boolean,
 *    rating: number,
 *  },
 *  onAddToLibrary: (movieId: string) => void,
 *  onRemoveFromLibrary: (movieId: string) => void
 *  onRatingChange: (movieId: string, rating: number) => void
 * }} props
 *
 * @returns {HTMLDivElement}
 */

export function createMovieCard({
  movie,
  onAddToLibrary,
  onRemoveFromLibrary,
  onRatingChange,
}) {
  const movieCard = document.createElement("div");
  let isInLibrary = movie.isInLibrary;
  let rating = movie.rating;
  movieCard.innerHTML = `
    <div
      data-movie-id="${movie.id}"
      class="max-w-sm bg-white border border-2 border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700 flex flex-col transition duration-100 ease-in-out transform "
    >
      <img class="rounded-t-lg" src="${movie.posterUrl}" alt="" aria-hidden />
      <div class="p-5 flex flex-col flex-1 items-start">    
          <h3 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">${movie.title}</h5>

          <p class="mb-3 font-normal text-gray-700 dark:text-gray-400 flex-1">${movie.summary}</p>
          
              
          <div class="flex justify-between w-full" data-button-container>
          <button class="inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 rounded-lg hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" >
          🍿 Ajouter
          </button>
          <div class="text-center py-2 hidden" data-rating>
              <span class="flex flex-row-reverse ">
          
                <svg data-rating="5" class="text-gray-600 cursor-pointer peer peer-hover:text-yellow-400 hover:text-yellow-400 duration-100 " width="23" height="23" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                </svg>
          
                <svg data-rating="4" class="text-gray-600 cursor-pointer peer peer-hover:text-yellow-400 hover:text-yellow-400 duration-100 " width="23" height="23" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                </svg>
          
                <svg data-rating="3" class="text-gray-600 cursor-pointer peer peer-hover:text-yellow-400 hover:text-yellow-400 duration-100 " width="23" height="23" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                </svg>
          
                <svg data-rating="2" class="text-gray-600 cursor-pointer peer peer-hover:text-yellow-400 hover:text-yellow-400 duration-100 " width="23" height="23" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                </svg>
          
                <svg data-rating="1" class="text-gray-600 cursor-pointer peer peer-hover:text-yellow-400 hover:text-yellow-400 duration-100 " width="23" height="23" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                </svg>
                
              </span>
            </div>
            </div>
         
      </div>
</div>

    `;
  if (isInLibrary === undefined) {
    movieCard.querySelector("[data-button-container]").classList.add("hidden");
  }
  const button = movieCard.querySelector("button");
  const movieContainer = movieCard.firstElementChild;
  const ratingSection = movieCard.querySelector("[data-rating]");
  const buttonContainer = movieCard.querySelector("[data-button-container]");
  function toggleInLibrary() {
    ratingSection.classList.toggle("hidden");
    movieContainer.classList.toggle("border-green-500");
    movieContainer.classList.toggle("opacity-90");
    movieContainer.classList.toggle("border-gray-200");
    movieContainer.classList.toggle("dark:border-green-500");
    movieContainer.classList.toggle("dark:border-gray-700");

    button.classList.toggle("bg-blue-700");
    button.classList.toggle("dark:bg-blue-600");
    button.classList.toggle("hover:bg-blue-800");
    button.classList.toggle("dark:hover:bg-blue-700");
    button.classList.toggle("text-white");
    button.classList.toggle("dark:text-white");
    button.classList.toggle("dark:hover:bg-gray-700");
    buttonContainer.classList.toggle("flex-row-reverse");
    button.textContent = isInLibrary ? "❌ Retirer" : "🍿 Ajouter";
  }

  const ratingButtons = movieCard.querySelectorAll("[data-rating] svg");
  function setupRating() {
    ratingButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const newRating = parseInt(button.dataset.rating);
        rating = newRating;
        onRatingChange(movie.id, newRating);
        updateRating();
      });
    });
  }
  function updateRating() {
    ratingButtons.forEach((button) => {
      const buttonRating = button.dataset.rating;
      if (buttonRating <= rating) {
        button.classList.add("text-yellow-400");
      } else {
        button.classList.remove("text-yellow-400");
      }
    });
  }
  setupRating();
  updateRating();

  button.addEventListener("click", () => {
    isInLibrary = !isInLibrary;
    toggleInLibrary();
    if (isInLibrary) {
      onAddToLibrary?.(movie.id);
    } else {
      rating = undefined;
      updateRating();
      onRemoveFromLibrary?.(movie.id);
    }
  });
  if (isInLibrary) {
    toggleInLibrary();
  }
  return movieCard.firstElementChild;
}
