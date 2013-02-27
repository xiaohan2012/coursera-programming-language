(*
list and options are actually datatype bindings
for option, `SOME` and `NONE` are actually constructors
So are `::` and `[]` for list
*)

(*
we can use these constructors as pattens in case expressions
*)

fun inc_int_option( int_opt ) = 
    case int_opt of
	NONE => 0
      | SOME x =>  x + 1;

val int_opt1 = SOME 1;
inc_int_option(int_opt1);
val int_opt2 = NONE;
inc_int_option(int_opt2);


fun append_list (xs,ys) = (*pattern matching [] and ::*)
    case xs of
	[] => ys
      | x::xs' => x :: append_list(xs',ys)(*x::xs' strange pattern*)

val xs = [1,2,3];
val ys = [4,5,6];
append_list(xs,ys);


(*
Use case expression to deal with list/option operations
because we can cover all variants and no exception for wrong variant
like hd[]

even though, null, hd, tl, isSome and valOf have their reasons to exist..
*)

(* 
Because option and list are essentially datatype bindings, we are actually building list and option on top of the notion datatype bindings, which indeed makes SML even smaller.
*)
