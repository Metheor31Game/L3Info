(*TDA*)
(*
1) f(0,1) -> 0 car le premier arg est 0
2) f(1,0) -> 5 car le second arg est 0
3) f(1,4) -> 54 car x = 4 et premier arg = 1
4) f(4,1) -> 39 car x = 4 et secong arg = 1
5) f(25,5) -> 3 car ce sont des nombres quelconque

*)

(*Exercice 1*)

let et = function
   (false,_) -> false
  |(_,false) -> false
  | _ -> true;;

let ou = function
   (false,false) -> false
  |_ -> true;;

let xor = function
   (true,true) -> false
  |(false,false) -> false
  |_ -> true;;


(*Exercice 2*)

let entier = function 
  0 -> "zero"
  |1 -> "un"
  |x -> if x mod 2 = 0 then "pair" else "impair";;
  
(*Exercice 3*)

let point = function
  (0.,0.) -> "Origine" |
  (0.,_) -> "Axe des ordonnées" |
  (_,0.) -> "Axe des abscisses" |
  (x,y) -> if x > 0 then "point du demi plan x>0" else "point du demi plan x<0";;

(*Exercice 4*)

let operation = function
  (x,y,'+') -> x + y |
  (x,y,'-') -> x - y |
  (x,y,'*') -> x * y |
  (x,0,'/') -> failwith "ERREUR tu vas mourir" |
  (x,y,'/') -> x / y |
  (x,y,_) -> failwith "ERREUR tu pourrais mourir";;


(*Exercice 5*)

let prixttc = function (prix, tva) -> prix +. prix*.tva;;

let prix = function 
  ("pain") -> prixttc(1.05) 

  CONTINUER !!!!!!!!!!!!!!!!!!!!

