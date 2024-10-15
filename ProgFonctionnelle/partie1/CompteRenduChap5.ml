(*Exercice 1*)

let rec somme = function 
1 -> 1 |
(n) -> n + somme(n-1);;

(*Exercice 2*)

let rec puissance = function
n,0 -> 1 |
n,1 -> n|
0,b -> 0 |
n,b -> n * puissance(n,b-1);;

(*Exercice 3*)

let rec repeat = function
n,0 -> failwith "ne peut pas etre egal a 0" |
n,1 -> n |
n,b -> n*(puissance(10,b-1)) + repeat(n,b-1);;

(*
  On a un élément b qui décroit, b-1, b-2, b-3... et doit s'atteter en 1
  (donc on a un minimum), ce qui signifie que la fonction se termine.   

*)


let rec unChiffre = function 
0,c -> true | 
n,c ->  n mod(10) = c && unChiffre(n/10, c);;

let rec pgd = function
n,0 -> failwith "Peut pas diviser par 0" |
n,1 -> 1 |
0,d -> d |
n,d -> if n mod d = 0 then d
        else pgd(n,d-1);;


let rec nbPairChif = function 
0 -> true |
n -> if n/10 > 0 then nbPairChif(n/100)
else false;;

(*Exercice 4*)

let rec mult = function
0,p -> 0 |
n,p -> if n mod 2 > 0 then mult(n-1,p) +p
else mult(n/2,p+p);;


(*Exercice 5*)

let rec schif = function
0 -> 0 |
n -> n mod 10 + schif(n/10);;


let rec sumchif = function
n -> if n < 10 then n
else sumchif(schif(n));;


(*Exercice 6*)
let majuscule = function c -> c <= 'Z' && c >= 'A';;

let minuscule = function c -> c > 'Z';;

let lettre = function c -> c >= 'A' && c <= 'z';;

let rec appartient = function
"",c -> false |
s,c -> String.get s 0 = c || appartient(String.sub s 1 (String.length s -1),c);;


let rec debut = function
"",s2 -> failwith "chaine vide" |
s1,"" -> failwith "chaine vide" |

