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

let ilexiste = function v






























