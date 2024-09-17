(* Exercice A *)
(*
  1 ) let f1 = function x -> x +. 1.
  float
  
  2 ) let f2 = function x -> x = true
  boolean

  3 ) let f3 = function x -> x ^ "Hello world" 
  String

  4 ) let f4 = function x -> 3
  int

  5 ) let f5 = function x -> x && (x + 1 = 3)
  boolean
  *)


(* Exercice 1 *)

let estPair = function x -> x mod(2) = 0;;

let minus = function c -> int_of_char(c) < 122 && int_of_char(c) > 97

let troncature = function x -> int_of_float(x);;

let decimale = function x -> abs_float(x) -. float_of_int(troncature(abs_float(x)));;

let plus_proche_entier = function x -> 
  if decimale(x) >= 0.5 then troncature(x) + 1
  else troncature(x);;

  (* Exercice 3 *)

  let heures = function x -> troncature(x);;

  let minutes = function x -> plus_proche_entier(decimale(x) *. 100.);;
  
  let quelle = function x -> let heure = heures(x) and let minute = minutes(x)
    in 
  let phrase = "Il est " in
    if heure = 12 then let phrase = phrase ^ "midi "  
    else if heure = 0 then let phrase = phrase ^ "minuit " 
    else let phrase = phrase ^ string_of_int(heure) ^ " heures "      
    in       
  if minute = 0 then let phrase = phrase ^ "pile" 
                else if minute = 15 then let phrase = phrase ^ "et quart" 
                else if minute = 30 then let phrase = phrase ^ "et demi"
                else let phrase = phrase ^ string_of_int(minute);;

