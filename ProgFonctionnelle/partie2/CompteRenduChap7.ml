
(* Exercice 1 *)
let min = function
[] -> failwith "La liste est vide" |
[a] -> a |
a::l -> let rec min2 = function 
        a,[] -> a |
        a,b::l -> if a < b then min2(a,l) else min2(b,l)
in min2(a,l);;

let rec enleve = function
a,[] -> [] |
a,b::l -> if a = b then l else b::(enleve(a,l));;

let rec naif = function
[] -> [] |
l -> min(l)::naif(enleve(min(l),l));;

(* Exercice 2 *)

let rec insertion = function
a,[] -> [a] |
a,b::l -> if a < b then a::b::l else b::insertion(a,l);;

let rec tri_insertion = function
[] -> [] |
a::l -> insertion(a, tri_insertion(l));;


(* Exercice 3 *)

