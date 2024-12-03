(*Exercice 1*)
let fzz f(a) = (f (a + 1)) = 0;;
(* fzz :  (int -> int) -> int -> bool *)

fzz(3);;
(* f : int -> int  *)

let g = fzz(function n -> 3);;
(* val g : (int -> int) -> fun *)

(*int -> int -> bool*)
let f = function a -> function b -> a+b+1 = 0;;

let f (a) (b) = a + b + 1 = 0;;


(* (int -> int) -> bool *)

let f = function a -> a(5)+1 = 0 && true;;
let fonction2 = function a -> a+1;;

(* int -> bool -> float *)

let f = function a -> function b -> if a+1 = 0 && b then 0. else 1.;;

(* (int -> bool) -> float *)

let f = function a -> if a(5) then 0. else 1.;; 


(* float -> bool -> int *)
let f = function a -> function b -> if a +. 1. = 0. && b then 1 else 2;;

(* (bool -> bool) -> int *)
let f = function a -> if a(true) then 1 else 2;;

(* (float -> bool) -> (int -> int) -> int *)
let f = function a -> function b -> if a(3.) then b(5)+1 else b(5);;

(*Clement a pété un gros crane  (int -> int) -> (float -> float) -> (bool -> bool) -> int*)
let f = function a -> function b -> function c -> if a(1) + 1 = 0 && 1.3 +. b(1.) = 0. && c(true) then 1 else 2;;
let f = function a -> function b -> function c -> if c(b(1.) = 2. && a(1) = 1) then 1 else 2;;



(* Exercice 2 *)

let rec ilexiste p list =
  match list with
  [] -> false |
  a::reste -> p(a) || ilexiste p reste;;

ilexiste (function x -> x = 0) ;;

let rec ilexiste = function p -> function list ->
  match list with
  [] -> false |
  a::reste -> p(a) || ilexiste p reste;;


  let rec ilexiste = function p -> function 
    [] -> false |
    a::reste -> p(a) || ilexiste p reste;;
;;

let rec qqsoit p list =
  match list with
  [] -> false |
  a::reste -> p(a) && ilexiste p reste;; 

qqsoit (function x -> x = 0) [0;0;0;0;0;0];;

let rec estMembre = function p -> function
  [] -> false |
  a::reste -> p = a || estMembre p reste;;

estMembre (5) ([1;2;3;4;5]);;

let estMembre = function x -> function liste -> 
  ilexiste (function a -> a=x)    liste ;; 

let estInclus = function list -> function list2 ->
  qqsoit(function x -> estMembre x (list2)) (list);;


(*Exercice 2*)
type expression = Const of int | Var of char |
  Add of expression*expression |
  Mult of expression*expression |
  Puiss of expression*int;;

let expression1 = Add(Const(1),Mult(Const(2),Puiss(Var('x'),3)));;
let expression2 = Add(Const 1, Puiss(Var 'a', 2));;
  
type liaison = {id: char; valeur: int};;

let envC = [{id = 'a'; valeur = 3}; {id = 'b' ;  valeur = 4} ;{id = 'x'; valeur = 12}];;

let rec evalVar = function 
  a, [] -> failwith "Indentificateur inconnu" |
  a, b::reste -> if a = b.id then b.valeur else evalVar (a,reste);;

evalVar('a', envC);;
evalVar('b', envC);;

let rec puissance = function
  a,0 -> 1 |
  a,b when b < 0 -> failwith "négatif" |
  a,b -> a*puissance(a,b-1) ;;

let rec evalExp = function env -> function
  Const n -> n |
  Var c -> evalVar(c, env) |
  Add (a,b) -> evalExp(env) (a) + evalExp(env) (b)|
  Mult (a,b) -> evalExp(env) (a) * evalExp(env) (b)|
  Puiss (a,b) -> puissance(evalExp(env) (a),b);;


evalExp(envC) (expression1);;

(*Exercice 3*)





























