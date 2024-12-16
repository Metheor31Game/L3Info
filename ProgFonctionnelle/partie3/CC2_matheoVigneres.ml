
(* EXERCICE : STRUCTURE DE DONNEES *)

(*type*)
type tas = Feuille of int | DoubleNoeud of int * tas * tas | SimpleNoeud of int * tas;; 

(*exemples*)
let tas1 = DoubleNoeud(18, Feuille 6, DoubleNoeud(12, Feuille 10, Feuille 9));; 
let tas2 = Feuille 26 ;;
let tas3 = DoubleNoeud(18, DoubleNoeud(9, Feuille 5, Feuille 3), SimpleNoeud(12, Feuille 9));; 
 
(* Question 1 : maxTas *)


let maxTas = function 
  | Feuille f -> f 
  | DoubleNoeud (n,t1,t2) -> n 
  | SimpleNoeud (n,t1) -> n;;

maxTas tas1 ;;
(*	- : int = 18 *)
	
maxTas tas2 ;;
(*	- : int = 26 *)


(* Question 2 : hauteurTas *)

(*Fonction auxiliaire Max*)

let max = function n1,n2 -> if n1 > n2 then n1 else n2;;

max(1,5)
(* - : int = 5 *)
max(12,8)
(* - : int = 12 *)

let rec hauteurTas = function
  | Feuille f -> 0
  | SimpleNoeud (n,t1) -> 1 + hauteurTas(t1)
  | DoubleNoeud (n,t1,t2) -> 1 + max(hauteurTas(t1), hauteurTas(t2));;

hauteurTas tas1 ;;
(*	- : int = 2 *)
	
hauteurTas tas2 ;;
(*	- : int = 0 *)

(* Question 3 : recherche *)

let rec recherche t n =
  match t with
  | Feuille f -> if f = n then 1 else 0
  | SimpleNoeud (k,t1) -> if k = n then 1 + recherche t1 n else recherche t1 n 
  | DoubleNoeud (k, t1, t2) -> if k = n then 1 + (recherche t1 n) + (recherche t2 n) else (recherche t1 n) + (recherche t2 n);;

recherche tas3 9 ;;
(*	- : int = 2 *)
	
recherche tas3 2 ;;
(*	- : int = 0 *)

(* Question 4 : tasVersListe *)

let rec tasVersListe t =
  match t with 
  | Feuille f -> [f] 
  | SimpleNoeud (k, t1) -> k::tasVersListe(t1) 
  | DoubleNoeud (k, t1, t2) -> k::tasVersListe(t1) @ tasVersListe(t2);;

tasVersListe tas1 ;;
(*	- : int list = [18; 6; 12; 10; 9] *)
	
tasVersListe tas3 ;;
(*	- : int list = [18; 9; 5; 3; 12; 9] *)


(* Question 5 : ajoutTas *)

let rec ajoutTas elt t = 
  match t with 
  | Feuille f -> if elt > f then SimpleNoeud (elt, Feuille f) else SimpleNoeud(f , Feuille elt)
  | SimpleNoeud (n, t1) as s -> if elt > n then SimpleNoeud(elt, s) else DoubleNoeud (n, t1, Feuille elt)
  | DoubleNoeud (n, t1, t2) as s -> if elt > n then SimpleNoeud(elt, s) else if maxTas(t1) > maxTas(t2) then DoubleNoeud(n, ajoutTas(elt)(t1), t2) else DoubleNoeud(n, t1, ajoutTas(elt)(t2));;


ajoutTas 1 tas3 ;;
(*	- : tas = DoubleNoeud (18, DoubleNoeud (9, Feuille 5, Feuille 3),	DoubleNoeud (12, Feuille 9, Feuille 1)) *)
	
ajoutTas 1 tas1 ;;
(*	- : tas = DoubleNoeud (18, Feuille 6,	DoubleNoeud (12, SimpleNoeud (10,	 Feuille 1), Feuille 9)) *)

(* Question 6 : listeVersTas *)

exception ListeVide

let rec listeVersTas list =
  match list with 
  | [] -> raise ListeVide
  | [a] -> Feuille a 
  | a::reste -> ajoutTas (a) (listeVersTas (reste));;

listeVersTas [5;3;8;2;1;4;6;7];;
(*	- : tas = DoubleNoeud (8, DoubleNoeud (7, DoubleNoeud (6, Feuille 1, 	SimpleNoeud (5, Feuille 2)), Feuille 4), Feuille 3) *)


(* -------------------------------------------- *)
(* PROBLEME : La NUIT de l'Info *)

(*types*)
type cate = Developpement | Ecologie | MarreDuWeb ;;

type defi = {nom : string ; niveau : int ; categorie : cate} ;;

(* exemple*)
let ges = {nom = "Compteur GES" ; niveau = 4 ; categorie = Ecologie};;
let ooo = {nom = "Ouhorlde Ouaide Ouheb"; niveau = 5 ; categorie = Developpement} ;;
let trash = {nom = "Trash Game" ; niveau = 6 ; categorie = MarreDuWeb} ;;
let ou = {nom = "Où sont mes fichiers"; niveau = 7 ; categorie = Developpement} ;;

(**** PARTIE 1 - Analyse d'un défi ****)

(* Question 1 : niv *)

let niv d = d.niveau;;

niv ges ;;
(*- : int = 4*)

(* Question 2 : augmente *)


let augmente d n = {nom = d.nom ; niveau = d.niveau + n ; categorie = d.categorie};;


augmente ges 4 ;;
(*- : defi = {nom = "Compteur GES"; niveau = 8; categorie = Ecologie}*)

(* Question 3 : plusDur *)


exception ComparaisonImpossible

let plusDur = function d1 -> function d2 -> 
  if d1.categorie != d2.categorie then raise ComparaisonImpossible else d1.niveau > d2.niveau;;

plusDur ou ooo ;; 
(*- : bool = true*)
plusDur trash ou ;;
(*Exception non rattrapée: ComparaisonImpossible*)



(**** PARTIE 2 - La liste des défis ****)

let listeDefi = [ges;ooo;trash;ou];;
(*listeDefi : defi list =
 [{nom = "Compteur GES"; niveau = 4; categorie = Ecologie};
  {nom = "Ouhorlde Ouaide Ouheb"; niveau = 5; categorie = Developpement};
  {nom = "Trash Game"; niveau = 6; categorie = MarreDuWeb};
  {nom = "Où sont mes fichiers"; niveau = 7; categorie = Developpement}]*)

 
 (* Question 1 : appartient *)
 
 
let rec appartient liste name =
  match liste with 
  | [] -> false 
  | a::reste -> a.nom = name || appartient reste name;;
 
appartient listeDefi "1 2 3 soleil" ;;
(*- : bool = false*)
appartient listeDefi "Trash Game" ;;
(*- : bool = true*)

(* Question 2 : extraitCat *)


let rec extraitCat cate liste = 
  match liste with
  | [] -> []
  | a::reste -> if a.categorie = cate then a.nom::extraitCat cate reste else extraitCat cate reste;;


extraitCat Developpement listeDefi ;;
(*- : string list = ["Ouhorlde Ouaide Ouheb"; "Où sont mes fichiers"]*)



(*Question 3 : niveauMoyen *)

let rec longueur liste = 
  match liste with 
  | [] -> 0.
  | a::reste -> 1. +. longueur reste;;

longueur [1;2;3;4;5];;
(* - : float = 5.*)
longueur [];;
(* - : float = 0.*)


let niveauMoyen = function 
  liste -> let rec somme l = 
              match l with
              | [] -> 0.
              | a::reste -> float_of_int(a.niveau) +. somme reste
            in
            somme(liste) /. longueur(liste);;

niveauMoyen listeDefi;;
(*- : float = 5.5*)

(**** PARTIE 3 - Enfin les résultats ****)

(*type*)
type resultat = Vainqueur of defi*string | EnAttente of defi ;;

(*exemple*)
let listeResultat = [EnAttente(trash); EnAttente(ges) ;Vainqueur(ooo, "Passage Python"); EnAttente(ou)];;

(* Question 1 : impatience *)

let rec impatience liste =
  match liste with 
  | [] -> 0 
  | a::reste -> match a with 
                | EnAttente (d) -> 1 + impatience reste 
                | Vainqueur (d,s) -> impatience reste;;


impatience listeResultat ;;
(*- : int = 3*)

(* Question 2 *)

let rec gagnant liste nom =
  match liste with 
  | [] -> false 
  | a::reste -> match a with 
                | Vainqueur (b,s) -> s = nom || gagnant reste nom
                | _ -> gagnant reste nom ;;
 
gagnant listeResultat "Passage Python" ;;
(*- : bool = true*)

gagnant listeResultat "Bonnie & cloud" ;;
(*#- : bool = false*)
    
 