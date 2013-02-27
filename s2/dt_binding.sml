(*
so far we have two types of binding.
1, variable binding using `val`
2, function binding using `fun`

we can actually datatype binding.

By using the datatype binding in SM, we can achieve the one-of datatypes

*)

datatype fengtype = TwoBools of bool * bool
       | Int of int
       | Anything;
(*
three constructors are added to the environment
so we can use TwoBools, Int and anything.
*)
val two_bools = TwoBools(true,false);
val one_int = Int(51);
val anything = Anything;(*BTW, what is that?*)

(*Constructors are essentially functions. *)
val two_bools_fun = TwoBools;
val one_int_fun = Int;


(*since now we know how to build datatypes, we need to know how to access them
for example, for list and option, we have two types of access operations.
1, check if it's null, null for list and isSome for option
2, get element, hd and tl for list and valOf for option.
*)
