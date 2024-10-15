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