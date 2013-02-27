structure FengLib = struct
fun add (i,j) = 
    i + j
fun sub (i,j) = 
    i - j
end

val two = FengLib.add (1,1)
val one = FengLib.sub (2,1)

(*
module system is very helpful for:
1, give hierarchy to names and avoid shadowing
2, allow different modules to reuse the names
3, organize code
*)


(*if you want "direct access" to module contents, use "open"*)
open FengLib
val three = add (1,2)
