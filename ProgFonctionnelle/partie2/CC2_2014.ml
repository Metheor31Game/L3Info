let jeucomplet=[("pique",7) ;("pique",8) ;("pique",9) ;("pique",10) ;("pique",11) ;
("pique",12) ;("pique",13) ;("pique",14) ; ("coeur",7) ;("coeur",8) ;("coeur",9) ;
("coeur",10) ;("coeur",11) ;("coeur",12) ;("coeur",13) ;("coeur",14) ; ("carreau",7) ;
("carreau",8) ;("carreau",9) ;("carreau",10) ;("carreau",11) ;("carreau",12) ;("carreau",13) 
;("carreau",14) ; ("trefle",7) ;("trefle",8) ;("trefle",9) ;("trefle",10) ;("trefle",11) ;
("trefle",12) ;("trefle",13) ;("trefle",14)   ] ;;

let main=[("trefle",8) ;("pique",7)  ;("coeur",11) ;("trefle",11)  ;("coeur",7) ;
("carreau",10);("pique",10) ;("pique",11)    ] ;;


let rec long = function
[] -> 0 |
a::l -> 1 + long(l);;

let rec nbCoul (jeu, couleur) =
  match jeu with
  | [] -> 0
  | (c, _) :: reste -> if c = couleur then 1 + nbCoul (reste, couleur) else nbCoul (reste, couleur)

let rec retourne = function
[] -> [] |
a::liste -> retourne(liste) @ [a];;

let rec distribue = function
[] -> [] |
l ->    