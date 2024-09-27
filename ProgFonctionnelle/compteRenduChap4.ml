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
  ("pain") -> prixttc(1.05,5.5) |
  ("conserve") -> prixttc(3.5,7.0) |
  ("disque") -> prixttc(12.30,18.6) |
  ("bijou") -> prixttc(356.,33.) |
  (_) -> failwith "je connais pas";;

let troncature = function x -> int_of_float(x);;

let decimale = function x -> abs_float(x) -. float_of_int(troncature(abs_float(x)));;


let plus_proche_entier = function x -> 
if decimale(x) >= 0.5 then troncature(x) + 1
else troncature(x);;

let sommeAPayer = function (element, nombre) -> plus_proche_entier(prix(element) *. float_of_int(nombre));;

(*Exercice 6*)

let formule = function (j,m,p,s) -> j + (48*m - 1)/5 + p/4 + p + s/4 -2*s;;

let decoupe = function (annee) -> annee/100 , annee mod 100;;

let deuxMoisAvant = function 
  (2,annee) -> 12, annee - 1 |
  (1,annee) -> 11, annee -1 |
  (mois,annee) -> mois - 2, annee;;

  let jour = function 
   0 -> "Dimanche"
  | 1 -> "Lundi"
  | 2 -> "Mardi"
  | 3 -> "Mercredi"
  | 4 -> "Jeudi"
  | 5 -> "Vendredi"
  | 6 -> "Samedi"
  | _ -> failwith "Invalid day";;

let modulo7 = function (nombre) -> if nombre >= 0 then  nombre mod 7 else (nombre mod 7) + 7;;

let quelJour = function (j,mois,annee) -> 
  let m,a = deuxMoisAvant(mois,annee) in
  let s,p = decoupe(a) in
  let k = formule(j,m,p,s) in
  let modulo7dek = modulo7(k) in
  jour(modulo7dek);;

quelJour(14,7,1789);;