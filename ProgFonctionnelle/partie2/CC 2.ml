
(* EXERCICE 1 - SUR LES LISTES *)

(* -------------- Question 1 *)

let rec nbOcc = function
a,[] -> 0 |
a,b::l -> if a = b then 1 + nbOcc(a,l) else nbOcc(a,l);;


(*test*)
let l = [1;5;2;1;3;4];;
let l1 = [1];;
let l2 = [];;
nbOcc(2, [3;4;2;4;2;2]);;

nbOcc(1,l);;
nbOcc(1,l1);;
nbOcc(1,l2);;




(*- : int = 3 *)

(* -------------- Question 2 *)

let rec repeat = function
0,a -> [] |
n,a -> a::repeat(n-1,a);;



	
repeat(7,3) ;;
(*- : int list = [3; 3; 3; 3; 3; 3; 3]*)

(* --------------- Question 3 *)


let rec nPremiers = function
n,[] -> failwith "liste trop courte" |
0,l -> [] |
n,a::l -> a::nbPremiers(n-1,l);; 

nPremiers(4,[2;3;4;5;6;7;8]);;
(*- : int list = [2; 3; 4; 5]*)

(* ---------------- Question 4 *)
let tranche = function
a,b,l -> 
   let rec tranche_bis = function
   a,b,n::l,i -> if i < a then tranche_bis(a,b,l,i+1) else
      if i = a then nPremiers(b-a,l) else failwith "Liste trop courte"
   in tranche_bis(a,b,l,1);;  




tranche(2,4,[1;2;3;4;5;6;7]);;
(*- : int list = [2; 3; 4]*)
tranche(2,6,[1;2;3;4;5;6;7]);;
(*- : int list = [2; 3; 4; 5; 6]*)



(* EXERCICE 2 : Dans la cour de récréation *)

type chifoumi = Pierre | Feuille | Ciseaux ;;


(* ------------- Question 1 *)

let quiGagne = function
Pierre -> Feuille |
Feuille -> Ciseaux |
Ciseaux -> Pierre;;




quiGagne(Pierre);;
(*- : chifoumi = Feuille*)
quiGagne(Feuille) ;;
(*- : chifoumi = Ciseaux*)
quiGagne (Ciseaux);;
(*- : chifoumi = Pierre*)

(* --------------- Question 2 *)


let duel = function
a, b -> if quiGagne(a) = b then b else
   if quiGagne(b) = a then a else
      failwith "Egalite";;


duel (Pierre, Feuille) ;;
(*- : chifoumi = Feuille*)
duel (Feuille, Ciseaux) ;;
(*- : chifoumi = Ciseaux*)
duel (Feuille, Feuille);;
(*#Exception non rattrapée: Failure "Egalite !"*)




(* EXERCICE 3 : Arbre binaire de recherche *)

type arbre_binaire = 
Vide
| Noeud of int * arbre_binaire * arbre_binaire ;;

let abr1 = Noeud( 8,
Noeud (3, Noeud(2,Vide,Vide), Noeud(6,Vide, Vide)),
Noeud (19, Vide, Vide)) ;;
let abr2 = Noeud( 5,
Noeud (3, Noeud(2,Vide,Vide), Noeud(5,Vide, Vide)),
Noeud (7, Vide, Noeud(8,Vide,Vide))) ;;



(* ----------------- Question 1 *)

let rec taille = function
Vide -> 0 |
Noeud(n, arbre1, arbre2) -> 1 + taille(arbre1) + taille(arbre2);;





taille abr1 ;;
(*- : int = 5*)
taille abr2 ;;
(*- : int = 6*)

(* ------------------ Question 2 *)


let rec recherche = function
n, Vide -> false |
n, Noeud(a,arbre1,arbre2) -> n == a || recherche(n,arbre1) || recherche(n,arbre2);;



recherche (6,abr1) ;;
(*- : bool = true*)
recherche (12, abr2) ;;
(*- : bool = false*)

(* ------------- Question 3 *)


let rec insertion = function
n, Vide -> Noeud(n,Vide,Vide) |
n, Noeud(a,arbre1, arbre2) -> if n <= a then Noeud(a,insertion(n,arbre1),arbre2) else Noeud(a,arbre1,insertion(n,arbre2));;



insertion (4, abr1) ;;
(*- : arbre_binaire =
 Noeud
  (8,
   Noeud (3, Noeud (2, Vide, Vide), Noeud (6, Noeud (4, Vide, Vide), Vide)),
   Noeud (19, Vide, Vide)) *)
insertion (3,abr2) ;;
(*- : arbre_binaire =
 Noeud
  (5,
   Noeud (3, Noeud (2, Vide, Noeud (3, Vide, Vide)), Noeud (5, Vide, Vide)),
   Noeud (7, Vide, Noeud (8, Vide, Vide)))
	*)
	
(* -------------------- Question 4 *)	
	

let rec list_to_arbre = function
[] -> Vide |
n::l -> insertion(n,list_to_arbre(l));;
	
	
	
	
list_to_arbre [8;3;2;19;6];;
(*#- : arbre_binaire =
 Noeud
  (6, Noeud (2, Vide, Noeud (3, Vide, Vide)),
   Noeud (19, Noeud (8, Vide, Vide), Vide))*)
   
 (* ---------------- Question 5 *) 
   
let rec parcours_infixe = function
Vide -> [] |
Noeud(n, arbre1, arbre2) -> parcours_infixe(arbre1) @ n::parcours_infixe(arbre2);;
   
   
   
   
parcours_infixe abr1 ;;
(*- : int list = [2; 3; 6; 8; 19]*)

parcours_infixe abr2 ;;
(*- : int list = [2; 3; 5; 5; 7; 8]*)

(* ------------------------ Question 6 *)



let tri = function
[] -> [] |
l -> parcours_infixe(list_to_arbre(l));;



tri [8;3;2;19;6] ;;
(*- : int list = [2; 3; 6; 8; 19]*)


(* ------------------------- Question 7 *)


let a_doublons = function
  | Vide -> false
  | Noeud (a, arbre1, arbre2) as abr -> 
      let rec list_doublon_triee = function
        | [] -> false
        | [a] -> false
        | a :: b :: l -> a = b || list_doublon_triee l
      in
      list_doublon_triee (tri (parcours_infixe(abr)));;




a_doublons abr1 ;; 
(*- : bool = false *)
a_doublons abr2 ;;
(*- : bool = true*)

(* -------------------------- Question 8 *)




let est_trie = function 
Vide -> true |
Noeud (n, arbre1, arbre2) as abr ->
   let rec list_triee = function
      [] -> true |
      [a] -> true |
      a :: b :: l -> a < b && list_triee(l)
   in list_triee(tri(parcours_infixe(abr)));;


est_trie abr1 ;;
(*- : bool = true*)
