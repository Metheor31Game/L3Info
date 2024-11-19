type point = {abs : float ; ord : float} ;;

let p1 = {abs = 0.0 ; ord = 0.0} and
p2 = {abs = 2.0 ; ord = 0.0} and 
p3 = {abs = 1.0 ; ord = 2.0} and 
p4 = {abs = 0.0 ; ord = 1.0};;

type forme = Cercle of point*float | Polygone of point list;;

let p = Polygone[p1;p2;p3;p4;p1];;

let distance = function
p1, p2 -> sqrt(((p2.abs -. p1.abs)**2.) +. (p2.ord -. p1.ord)**2.);;

let rec longueur = function 
[] -> 0. |
p1::p2::[] -> distance(p1,p2) |
p1::p2::list -> distance(p1,p2) +. longueur(p2::list);;

let rec bonpoly = function
p1::p2::p3::p4::list -> 
  let rec dernier = function
    a::[] -> a |
    a::l -> dernier(l)
  in
  p1 = dernier(list) |
  _ -> false;;

let pi = 3.14;;

let perimetre = function
Cercle(p,r) -> 2.*.pi*.r |
Polygone(p) -> if bonpoly(p) then longueur(p) else failwith "pas un poly";;
