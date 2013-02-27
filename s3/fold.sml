(*another hall-of-fame higher order function, fold, which iterates through a list of elements and accumulate the result and finally produces one result*)

fun fold(f, acc, xs) = 
    case xs of 
	[] => acc
      | x::xs' => fold(f, f(acc,x), xs')

fun sum(xs) = fold(fn (x,y) => x+y, 0, xs)
val ten = sum([1,2,3,4])

fun all_positive(xs) = fold(fn (x,y) => x andalso y>0, 
			    true, xs)
val is_true = all_positive([1,2,3,4])

(*
both sum and all_positive are passed in closure  that takes no private data
the below are examples that take in private data
*)

fun all_greater_than_x(xs,s) = 
    fold( fn (x,y) => x andalso y>s,
	  true,xs)

val is_false = all_greater_than_x([1,2,3],2)
(*note here, this feature is enabled by lexical scoping and closure*)

(*this kind of function can be generalized into another form
all the elements produce true when passed to anothe basic function
*)
fun more_general(xs,g)=
    fold( fn (x,y) => x andalso g y,
	  true,xs)

fun all_greater_than_one xs = 
    more_general(xs, fn x => x>1)

val is_true = all_greater_than_one([2,3,4])
