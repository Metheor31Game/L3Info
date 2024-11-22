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


(*Exercice 2*)

type codeRVB = {rouge : int ; vert : int ; bleu : int };;

type couleur = Rouge | Vert | Bleu |  Melange of couleur*couleur | Code of int*int*int;;

let rgbToCoul = function
code -> Code (code.rouge,code.vert,code.bleu);;

let rec coulToRvb = function
Rouge -> {rouge = 255 ; vert = 0 ; bleu = 0} |
Vert -> {rouge = 0 ; vert = 255 ; bleu = 0} |
Bleu -> {rouge = 0 ; vert = 0 ; bleu = 255} |
Code(a,b,c) -> {rouge = a ; vert = b ; bleu = c} |
Melange(c1,c2) -> 
  let additionMax255 = function
  a,b -> if a + b <= 255 then a + b else 255
in
  let rvb1 = coulToRvb(c1) in
  let rvb2 = coulToRvb(c2) in
  { rouge = additionMax255(rvb1.rouge,rvb2.rouge) ; vert = additionMax255(rvb1.vert,rvb2.vert) ; bleu = additionMax255(rvb1.bleu,rvb2.bleu) } ;;


let c1 = Rouge;;
let c2 = Bleu;;
let c3 = Melange(Rouge,Bleu);;
let c4 = Code(121,54,7);;
let c5 = Melange(Rouge,Code(12,220,14));;

coulToRvb(c1);;
coulToRvb(c2);;
coulToRvb(c3);;
coulToRvb(c4);;
coulToRvb(c5);;

let tripletToRVB = function
a,b,c -> coulToRvb(Code(a,b,c));;

let coulToTriplet = function
code -> code.rouge,code.vert,code.bleu;;


(*Creation de couleur *)

let eclaircir = function
code, k -> 
  let additionMax255 = function
  a,b -> if a + b <= 255 then a + b else 255 
in
  {rouge = additionMax255(code.rouge,k) ; vert = additionMax255(code.vert,k) ; bleu = additionMax255(code.bleu,k)};;

let assombrir = function
code, k -> 
  let soustractionMax255 = function
  a,b -> if a - b > 0 then a - b else 0 
in
  {rouge = soustractionMax255(code.rouge,k) ; vert = soustractionMax255(code.vert,k) ; bleu = soustractionMax255(code.bleu,k)};;

let rec plusClair = function
code -> 
  let verifMax = function
    code -> code.rouge = 255 || code.vert = 255 || code.bleu = 255
in 
  if verifMax(code) then code else plusClair({rouge = code.rouge + 1 ; vert = code.vert + 1 ; bleu = code.bleu + 1});;

plusClair({rouge = 220; vert = 45; bleu = 43});;



let nuanceRouge = function
code -> let rec boucle = function
        code3 -> if code3.rouge = 255 then [] else code3::boucle({rouge = code3.rouge + 1; vert = code3.vert ; bleu = code3.bleu})
in
  let code2 = {rouge = 0; vert = code.vert; bleu = code.bleu} 
in boucle(code2);;


(* Exercice 3 *)


