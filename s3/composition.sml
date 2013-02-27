(*
function can be composed from several other functions
like take in a int, get its absoulte value and calculate its square root
*)
fun sqrt_of_abs1 x = Math.sqrt(Real.fromInt(abs(x)))

(*
in SML, there is a simpler way to do so, the `o` operator which takes in two functions and return the composition
*)
fun sqrt_of_abs2 x = (Math.sqrt o Real.fromInt o abs) x

(*this is actually unnecessary wrapping, so*)
val sqrt_of_abs3 = (Math.sqrt o Real.fromInt o abs)

val r1 = sqrt_of_abs1(~4)
val r2 = sqrt_of_abs2(~4)
val r3 = sqrt_of_abs3(~4)

(*
this is not quite readable because it starts processing from right to left, while human tends to process from left to right
*)
infix !>(*infix is like a declaration of an operator that takes in two arguments, one on each side*)
fun x !> y = y x

fun sqrt_of_abs4 i = (i !> abs !> Real.fromInt !> Math.sqrt)
val r4 = sqrt_of_abs4 ~4

