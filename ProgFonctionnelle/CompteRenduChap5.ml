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
n -> 


