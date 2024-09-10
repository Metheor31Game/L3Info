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


 if 1<3 then "hello world";;
 (* il faut absolument un else *)

 if "A" < "B" then 1 else 3;;
 (* Resultat est 1 *)

 if 2.0 < 3.5 then 2 else 4;;

 (* vrai donc résultat est 2*);;