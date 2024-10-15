(* 1.1 Expression simples *)

89.65 -. 72.63;;

(* 1.2 expression elementaires *)

(3.0 +. 2.2) *. (sqrt 3.);;


(* 
	1+2 = 2+1 && 4>5 ; ;
	3 = 2+1 && 4>5;;
	3 = 3 && 4>5;;
	true && 4>5;;
	true && false;;
	false;;

	1+2 = 2+1 || 4>5 ; ;
	3 = 2+1 || 4>5;;
	3 = 3 || 4>5;;
	true || 4>5;;
	true || false;;
	true;;

	1+2 = 2+1 > 4 > 5;;
	3 = 2+1 > 4 > 5;;
	3 = 3 > 4 > 5;;
	true > 4 > 5;;
	Erreur

	1+2 = 2+1 > (4>5);;
	3 = 2+1 > (4>5);;
	3 = 3 > (4>5);;
	true > (4>5);;
	true > false;;
	true;



	
	(1+2 = 2+1) && 4>5;;
	(3 = 2+1) && 4>5;;
	(3 = 3) && 4>5;;
	true && 4>5;;
	true && false;;
	false;;


	true || false = (1=1) && (4<5);;
	true || false = (true) && (4<5);;	
	true || false && (4<5);;
	true || false = true && true;;
	true || false;;
	true;;

	4 + 1 < 6 && ('a'<'h' || "debut" = "fin");;
	5 < 6 && ('a'<'h' || "debut" = "fin");;
	true && ('a'<'h' || "debut" = "fin");;
	true && (true || "debut" = "fin"));;
	true && (true || false);;
	true && (true);;
	true;;
	

*)

(* Exo difficile *)

not true < false ;;
(* not en 1er 
false < false ->  false 

< en 1er 
not false -> true *)


not false && false;;
(* 1er cas :  not en 1er
	true && false;;
	false;;

	2eme cas && en premier
	not false;;
	true
 *)


not false || true;;
(* 
	cas not en premier : 
	true || true;;
	true;;

	cas || en premier : 
	not true;;
	false;;

 *)


true || false && false;;

(* 
	cas 1 : || prioritaire:
	true && false;;
	false;;

	cas 2 : && prio:

	true || false;;
	true;;

 *)


 (* 2.2 les conditions *)


 if 1<3 then "hello world" else "nope";;
 (* il faut absolument un else *)

 if "A" < "B" then 1 else 3;;
 (* Resultat est 1 *)

 if 2.0 < 3.5 then 2 else 4;;

 (* vrai donc résultat est 2*);;
 let a = true;;
 let b = false;;

 if a then true else false;;

 (* A *)
 if a then true else b;;

 (* A || B*)

 if a then false else b;;

 (* not(A) && B *)

 if a then b else true;;

 (* B || not(A) *)

 if a then b else true;;
 
 (* A && B *)


 (* 3.3 Environnement *)

 let annee = 2020;; (* 2020 *)
 annee;; (* 2020 *)
 annee + 2 ;; (* 2022 *)
 let futur = 2021;; (* 2021 *)
 futur = annee + 1;; (* true *)
 (*annee_future;;*) (* erreur *)
 let annee_future = annee + 1;; (* 2021 *)
 let annee = 2000;; (* 2000 *)
 annee_future;; (* 2021 *)

 (* Environnement 
		[(annee,2020)]
		[(futur,2021),(annee,2020)]
		[(futur,2021),(futur,2021),(annee,2020)]
		[(annee_future,2021),(futur,2021),(annee,2020)]
		[(annee,2000),(annee_future,2021),(futur,2021),(annee,2020)]
 *)

 let va = 8;;
 let double = va * 2 and triple = va*3;;
 (*let moitie = va/2 and quart = moitie/2;;
 moitie;;*)

 (* Environnement 
	[(va,8)]
	[(triple,va*3),(double,va*2),(va,8)]
 
 *)

 





