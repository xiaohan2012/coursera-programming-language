(*
First class functions are more than what we have talked about
besides taking one function as an argument to another function, or processing list or number
can pass several functions as argument
put functions in tuple,list...
return function as the result
process  your own data structure
*)

fun double_or_triple x = (* bool -> int -> int *) (*equals to bool -> (int -> int) right hand first*)
    if x
    then fn x => 2*x
    else fn x => 3*x

val double = double_or_triple(true)
val triple = double_or_triple(false)

(* or process  your own data structure like datatype binding*)

(*think it on your own*)
