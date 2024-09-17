// Complétez les fonctions et préciser le type de leurs arguments et du retour

/**********************
 * Question 1
 * *******************/

/**
 * Appelle la fonction callback n fois, en passant le
 * numéro de l'appel en paramètre (en commençant par 1)
 */
function count(n : number, callback : (nombre: number) => void) {
  for (let i = 1; i <= n; i++) {
    callback(i);
  }
}
// test
count(4, console.log);
// @ts-expect-error
count("12", (a) => a.includes("a"));

/**********************
 * Question 2
 * *******************/

/**
 * Multiplie par 2 chaque élément d'un tableau
 */
export function multiplyBy2(arr : Array<number>) {
  return arr.map((item) => item * 2);
}
// test
multiplyBy2([1, 2, 3]);
// @ts-expect-error
multiplyBy2([1, "2", 3]);

/**********************
 * Question 3
 * *******************/

/**
 * Compte le nombre d'éléments pairs dans un tableau
 */
export function countEvenNumbers(arr : Array<number>) {
  return arr.filter((item) => item % 2 === 0).length;
}
// test
countEvenNumbers([1, 2, 3, 4, 5, 6]); // 3

/**********************
 * Question 4
 * *******************/

type Counter = {
  increment : () => void;
  get : () => number;
};

// à compléter
/**
 * Retourne un compteur
 * Un compteur est un objet qui possède deux fonctions:
 * - increment: incrémente la valeur du compteur de 1
 * - get: retourne la valeur du compteur
 */
export function createCounter(): Counter {
  let count = 0;
  return {
    increment: function () {
      count++;
    },
    get: function () {
      return count;
    },
  };
}
// test
createCounter().increment();
const a = createCounter().get() + 1;
