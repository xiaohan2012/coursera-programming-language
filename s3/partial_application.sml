(*artial application is one feature that is enabled by currying*)
fun fold f acc xs = 
    case xs of 
	[] => acc
      | x::xs' => fold f (f(acc,x)) xs'

(*fold is a currying function*)
val sum = fold (fn (x,y) => x+y) 0
val six = sum [1,2,3]

(*some library function are curried*)
val incr_one = List.map(fn x => x+1)

val non_neg = List.filter(fn x=> x>=0)

val l1 = incr_one [1,2,3]
val l2 = non_neg [~1,2,3]

(* `value restriction` happens when polymorphic types are used*)

(*
val weird1 = List.map (fn x => (x,1))
val l3 = weird1 [1,2,3]
*)
val no_weird1 = fn x => List.map (fn x => (x,1)) x(*put back the actually-necessary wrapping*)
val no_weird2 : int list -> (int*int) list = List.map (fn x => (x,1))(*give the explicit non-polymorphic type*)
val l3 = no_weird1 [1,2,3]
val l4 = no_weird2 [1,2,3]
