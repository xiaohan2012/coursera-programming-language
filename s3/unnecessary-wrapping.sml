fun rev xs = List.rev xs
(*
this is quite unnecessary because you can use List.rev directly
also rev is slightly slower than List.rev because of the extra function call
*)

(*
this is more of a point of style, other cases like:
if x then true else false

or

fun f1 x = f x
*)

(* 
if you want a shortcut if the function name is too long, 
*)
val rev = List.rev
