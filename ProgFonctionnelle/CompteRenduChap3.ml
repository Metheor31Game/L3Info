(*Exercice 4*)

let min = function (x,y) ->
  if x > y then y
  else x;;

let norme = function (x,y,z) ->
  let carre = function(x) -> x*x
in
  carre(x) + carre(y) + carre(z);;

(*Exercice 5*)
let reel = function (x,a,b) ->
  let max = function (a,b) ->
    if a > b then a
    else b
  in 
    let tronc = function(x) -> abs_float(x) -. float_of_int(int_of_float(abs_float(x)))
  in
    float_of_int(max(a,b)) +. tronc(x);;

(*Exercice 6*)
let chiffre = function(n) -> n mod 10;;

let echange = function(n,p) -> 
  let retire = function(x) -> x - x mod 10
in
  retire(n) + chiffre(p);;


(*Exercice 7*)

let q1 = function (a,b,c) -> a = b && b = c;;
let q2 = function (a,b,c) -> a = b && b != c;;
let q3 = function (a,b,c) -> a < b && b < c;;
let q4 = function (a,b,c) -> a = b || b = c || a = c;;


(*Exercice 8*)

let nb_sol = function(a,b,c) -> 
  let delta = function(a,b,c) -> (b*b) - 4*a*c
in
  if delta(a,b,c) > 0 then 2
  else if delta(a,b,c) = 0 then 1
  else 0;;