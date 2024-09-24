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