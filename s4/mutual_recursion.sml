(*
mutual recursion is commonly seen in CS, for example for finite state machine
here is an example that is a fnite state machine that is implemented by using mutual recursion.

The match fuctions takes in a int list and determines if it is of alternating 1,2 pattern such as [1,2,1,2,1,2}
*)

(*
In ML, mutual recursion is used by useing
fun x1 = e1
and x2 = e2
...
and xn = en

*)
fun match xs = 
    let
	fun need_one xs =
	    case xs of
		[] => true
	      | 1::xs' => need_two xs'
	      | _ => false
	and need_two xs= 
	    case xs of
		[] => false
	      | 2::xs' => need_one xs'
	      | _ => false
    in
	need_one xs
    end
	    

val test1_true = match [1,2,1,2]
val test2_false = match [1,2,1,2,1]
val test3_false = match [1,2,3]

datatype t1 = Foo of int | Bar of t2
and t2 = Baz of string | Ooz of t1

fun non_zero_and_nonempty_t1 v = 
    case v of
	Foo x => x <> 0
      | Bar x => non_zero_and_nonempty_t2 x
and non_zero_and_nonempty_t2 v =
    case v of
	Baz x => (String.size x) > 0 
      | Ooz x => non_zero_and_nonempty_t1 x

val test1_true = non_zero_and_nonempty_t1 (Bar (Baz "123"))
val test2_false  =non_zero_and_nonempty_t2 (Ooz (Foo 0))

(*
a workaround using higher order function

*)
fun f1 (f,v) = 
    case v of
	Foo x => x <> 0
      | Bar x => f x
fun f2 v =
    case v of
	Baz x => (String.size x) > 0 
      | Ooz x => f1 (f2, x)
val test1_true = f1 (f2 ,Bar (Baz "123"))
val test2_false  = f2 (Ooz (Foo 0))

(*
what is the general rule when the function dependency graph becomes complex?
*)
