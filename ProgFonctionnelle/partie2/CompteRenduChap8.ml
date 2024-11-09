type couleur = Blanc | Noir | Rouge | Vert | Bleu | Jaune | Cyan | Magenta;;

let c1 = Bleu;;


let est_colore = function
Blanc -> false |
Noir -> false |
_ -> true;;


let complementaire = function
Blanc -> Noir |
Noir -> Blanc |
Rouge -> Cyan |
Vert -> Magenta |
Bleu -> Jaune |
Cyan -> Rouge |
Magenta -> Vert |
Jaune -> Bleu;;

(* Exercice 2 *)

type complexe = C1 of float * float;;

type solution = S1 of float | S2 of float * float | S3 of complexe * complexe;;


(* Exercice 3 *)

type nombreNR = N of int | R of float;;

let somme = function
N n , N k ->N (n + k) |
R r , R x ->R (r +. x) |
R r , N k ->R (r +. float_of_int(k)) |
N n , R x ->R (float_of_int(n) +. x);;

let prod = function
N n , N k ->N (n * k) |
R r , R x ->R (r *. x) |
R r , N k ->R (r *. float_of_int(k)) |
N n , R x ->R (float_of_int(n) *. x);;

type nombreRC = R of float | C of float * float;;


(* Exercice 7 *)

type objet = Chat | Clown | Mouton;;

type mobile = Feuille of objet | Noeud of (int*int*mobile*mobile);;

let poids = function
Chat -> 1 |
Clown -> 3 |
Mouton -> 2;;

let rec fait_mob_simple = function
a, objet -> Noeud (a,a,Feuille objet, Feuille objet);;

let rec poidsM = function
Feuille f -> poids(f) |
Noeud (a,b,m1,m2) -> poidsM(m1) + poidsM(m2);;

let m = Noeud (4,8, Noeud (2,2,Noeud (4,2,Feuille Chat,Feuille Clown), Noeud(1,2,Feuille Chat,Feuille Mouton)) , Noeud(4,1,Feuille Clown, Feuille Clown));; 

let rec agrandir = function
Feuille f -> Feuille f |
Noeud (a,b,m1,m2) -> Noeud (a*2,b*2,agrandir(m1),agrandir(m2));;


let rec echanger = function

