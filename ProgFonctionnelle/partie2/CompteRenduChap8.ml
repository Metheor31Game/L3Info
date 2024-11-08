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


