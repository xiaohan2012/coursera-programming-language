signature FENGLIB =
sig
val add : int*int -> int
val sub : int*int -> int
end

structure FengLib :> FENGLIB = 
struct
fun add (i,j) = 
    i + j
fun sub (i,j) = 
    i - j

fun mul (i,j) = (*this function is not accessible*)
    i * j
end


val three = FengLib.add (1,2)
(*
val four = FengLib.mul (2,2)
this raises error
*)

(*
signature had two important functions.
1, separate interface with implementation(one interface can have multiple implementations
2, hide what is unnecessary to the users
*)
