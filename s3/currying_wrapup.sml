(*
Several practical issues when using currying function
what to do when tuple function is supposed when given a curried function or vice versa
*)
fun add (x,y) = x+y
(*
what if I want this
val add_one = add 1
*)

fun curry f x y = f (x,y)(*from tuple function to currying function*)
val add_one = curry add 1
val two = add_one 1

(*similarly, from curried function to tuple function*)
fun curry f (x,y) = f x y

(*
when using curried function, what if the argument order is not right?
*)
fun sub x y = x-y

(*
what if I want:
fun sub_by_two = x-2
here is the solution
*)

fun other_curry f x y = f y x

val sub_by_two = other_curry sub 2

val four = sub_by_two 6
