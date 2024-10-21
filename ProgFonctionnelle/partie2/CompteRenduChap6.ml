let deuxieme = function 
[] -> failwith "liste vide" |
[a] -> failwith "un seul element" |
a::b::q -> b ;;

let auMoinsTrois = function
[] -> false |
[a] -> false |
[a;b] -> false |
a::b::c::q -> true;;


let somme = function l -> if auMoinsTrois(l) then List.hd(l)+ List.hd(List.tl(l)) + List.hd(List.tl((List.tl(l)))) else failwith "au moins 3";;


let troisEstPair = function 
a::b::c::q -> c mod(2) = 0 |
_ -> failwith "pas le bon nombre d'éléments" ;;


let ajoutDeuxFois = function 
a,q -> a::a::q;;


let permute = function 
a::b::q -> b::a::q;;

(*  EXERCICE 2 *)

let rec construitListe = function 
0 -> [0] |
n -> n::construitListe(n-1);;


let rec longueur = function 
[] -> 0 |
a::q -> 1 + longueur(q);;

let rec dernier = function 
a::q -> if q = [] then a else dernier(q);;

let rec somme = function 
[] -> 0 |
a::q -> a + somme(q);;

let rec taillePaire = function
[] -> true |
a::q -> not(taillePaire(q));;

let rec rangImpairFAUX = function
[] -> [] |
a::q -> if a mod 2 = 0 then rangImpair(q) else a::rangImpair(q);;

let rec rangImpair = function
[] -> [] |
[a] -> [] |
a::b::q -> b::rangImpair(q);;

(* EXERCICE 3 *)

let rec appartient = function
a,[] -> false |
a,b::q -> a = b || appartient(a,q);;

let rec maximum = function
[a] ->  a |
[a;b] -> if a > b then a else b |
a::b::q -> if a > b then max(a::q) else max(b::q);;

let rec occurence = function 
a, [] -> 0 |
a, b::q -> if a = b then 1 + occurence (a,q) else occurence (a,q);;


(* J'ai oublié de push mais je me suis arrêté a l'exercice 6*)

let rec estCroissante = function
[] -> false |
[a] -> true |
[a;b] -> a < b |
a::b::q -> a < b && estCroissante(b::q);;

let rec fusion = function 
[],q -> q |
l,[] -> l |
a::l,b::q -> if a < b then a::fusion(l,b::q) else b::fusion(a::l,q);;


(* Exercice 7 *)

let rec generer = function
2 -> [2] |
n -> generer(n-1) @ [n];;

let rec eliminer = function
a,[] -> [] |
a,b::q -> if b mod a = 0 then eliminer(a,q) else b::eliminer(a,q);;

let rec eratos n =
  let rec f2 = function
     [] -> [] | 
    p::q -> p :: f2 (eliminer(p, q))
  in
  f2 (generer n);;


let rec jumeaux = function 
[] -> [] |
[a] -> [] |
a::b::q -> if a - b = 2 then (a;b)::jumeaux(b::q) else jumeaux(b::q);;