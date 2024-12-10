
(****************************************************** 
tetec donne l'initiale d'un mot sous forme de caract�re
*******************************************************)
let tetec= function 
""-> failwith "La chaine est vide"
| s-> String.get s 0 ;;

(*val tetec : string -> char = <fun> *)

(* Exemples d'utilisation
tetec "bonjour";;
- : char = 'b'

tetec "b";;
- : char = 'b'

tetec "";;
 Exception : Failure "La chaine est vide" 
 *)

(****************************************************** 
tetes donne l'initiale d'un mot sous forme de chaine
*******************************************************)
let tetes = function s-> String.make 1 (tetec(s));;

(* val tetes : string -> string = <fun> *)

(* Exemples d'utilisation
tetes "bonjour";;
- : string = "b"

tetes "b";;
- : string = "b"

tetes "";;
Exception non rattrap�e: Failure "La chaine est vide" *)


(***************************************
 reste supprime l'initiale d'une chaine
 ***************************************)
let reste = function 
""-> failwith"La chaine est vide"
| s-> String.sub s 1 (String.length s - 1) ;;

(*val reste : string -> string = <fun> *)

(* Exemples d'utilisations

reste "bonjour";;
- : string = "onjour"

reste "b";;
- : string = ""

reste "";;
Exception non rattrap�e: Failure "La chaine est vide"*)

type pile = PileVide | Empile of int * pile;;

exception PileVideErreur;;


let estVide = function
PileVide -> true |
Empile(a,b) -> false;;

let sommet = function 
PileVide -> raise PileVideErreur |
Empile(a,b) -> a;;

let empile a b = Empile(a,b);;

let depile = function
PileVide -> raise PileVideErreur |
Empile(a,b) -> b;;

let rec egalite = function
PileVide, PileVide -> true |
a, PileVide -> false |
PileVide, a -> false |
Empile(a,b), Empile(c,d) -> a = c && egalite(b,d);;


let p1 = Empile(1,Empile(2,Empile(3, PileVide)));;
let p2 = p1;;
let p3 = empile(5,p1);;

egalite(p1,p2);;

let rec auxParentheses exp pile =
  match exp with 

  if a::exp = "(" then auxParentheses(exp,empile(1,pile)) else 
    if ")" then try auxParentheses(exp,depile(pile)) with PileVideErreur -> false else
      auxParentheses(exp,pile);;


(*Exercice 2*)


type file = {debut : int list ; fin : int list};;

exception FileVideErreur;;

let estVide = function
  f -> f.debut = [] && f.fin = [];;

let rec transvase file =
  match file.fin with
  | [] -> {debut = file.debut ; fin = []}
  | a::b -> {debut = file.debut @ transvase(file).debut ; fin = b};;

let rec premier file = 
  match file.debut, file.fin with
  | [], [] -> raise FileVideErreur
  | a::b, c -> a
  | [], c -> premier(transvase(file));;

let enfile a file = {debut = file.debut ; fin = a::file.fin};;

let rec queue file =
  match file.debut, file.fin with
  | [], [] -> raise FileVideErreur
  | a::b, c -> {debut = b ; fin = c}
  | [], c -> queue(transvase(file));;

let egalite f1 f2 = 
  let f1bis = transvase(f1) in
    let f2bis = transvase(f2) in
      f1bis.debut = f2bis.debut;;

let f1 = {debut = [1;3] ; fin = [2;7;4]};;
let f2 = {debut = [] ; fin = [3;2;1]};;
let f3 = transvase(f2);;

(* EXERCICE 3*)

type tas = Feuille of int | Noeud of int * tas * tas;;

let t1 = Noeud(25, Noeud(24, Noeud(13, Feuille(5), Feuille(12)), Noeud(17, Feuille(3), Feuille(9))), Noeud(11, Feuille(5), Feuille(1)));;

let valMax t = 
  match t with
  | Feuille a -> a
  | Noeud (a, t1, t2) -> a;;

let rec verif t =
  match t with
  | Feuille a -> true
  | Noeud (a, t1, t2) -> a > valMax(t1) && a > valMax(t2) && verif(t1) && verif(t2);;


(*EXERCICE 4*)


