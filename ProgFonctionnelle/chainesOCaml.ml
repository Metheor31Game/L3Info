(* Biblotheque pour les chaines de caracteres 
On la charge avec la commande include du menu file de caml
*)

(****************************************************** 
tetec donne l'initiale d'un mot sous forme de caract�re
*******************************************************)
let tetec= function 
""-> failwith "La chaine est vide"
| s-> String.get s 0 ;;

(*val tetec : string -> char = <fun> *)

(* Exemples d'utilisation
tetec "bonjour";;
- : char = 'b'

tetec "b";;
- : char = 'b'

tetec "";;
 Exception : Failure "La chaine est vide" 
 *)

(****************************************************** 
tetes donne l'initiale d'un mot sous forme de chaine
*******************************************************)
let tetes = function s-> String.make 1 (tetec(s));;

(* val tetes : string -> string = <fun> *)

(* Exemples d'utilisation
tetes "bonjour";;
- : string = "b"

tetes "b";;
- : string = "b"

tetes "";;
Exception non rattrap�e: Failure "La chaine est vide" *)


(***************************************
 reste supprime l'initiale d'une chaine
 ***************************************)
let reste = function 
""-> failwith"La chaine est vide"
| s-> String.sub s 1 (String.length s - 1) ;;

(*val reste : string -> string = <fun> *)

(* Exemples d'utilisations

reste "bonjour";;
- : string = "onjour"

reste "b";;
- : string = ""

reste "";;
Exception non rattrap�e: Failure "La chaine est vide"*)







