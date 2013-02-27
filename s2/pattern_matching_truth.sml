(*
so far, we are using pattern matching for one-of type.
In fact, pattern matching can be used for each-of type.

For example,
the pattern (x1,x2,x3) matches the value (v1,v2,v3)
or the pattern {f1:x1,f2:x2) matches the value {f1:v1,f2:v2}

So far, the only way to use patterns is using the case expression
*)

(*using one-branch case expression is quite ugly*)
fun sum_triple1 triple = 
    case triple of
	(x1,x2,x3) => x1 + x2 + x3;

fun cat_name1 names = 
    case names of
	{first = x, middle = y, last = z} => x ^ " " ^ y ^ " " ^ z

(*
sum_triple1 (1,2,3);
cat_name1 {first = "Von", middle = "chaoliang", last = "Neuman"};
*)

(*
actually, value binding can use a pattern matching
val p = e
val (x1,x2,x3) = (1,2,3);
*)



(* 
following this idea, we can modify the sum_triple1 into
*)

fun sum_triple2 triple =
    let 
	val (x, y, z) = triple
    in
	x + y + z
    end

fun cat_names2 names = 
    let 
	val{first = x, middle  = y, last = z} = names
    in 
	x ^ " " ^ y ^ " " ^ z
    end

(*
sum_triple2 (1,2,3);
cat_names2 {first = "Von", middle = "chaoliang", last = "Neuman"};
*)


(*
actually, functions in SML takes only one argument. Mutiple arguments effect is achieved by pattern matching
*)

(*
So a even better aproach in which value binding is performed when argument is passed into the function
*)


fun sum_triple3 (x,y,z) = 
    x+y+z

fun cat_names3 {first = x, middle  = y, last = z} = 
	      x ^ " " ^ y ^ " " ^ z
(*
sum_triple3 (1,2,3);
cat_names3 {first = "Von", middle = "chaoliang", last = "Neuman"};
*)

(*

By using pattern matching in function argument passing,
we are expanding the language while making it smaller

Magic, right?

*)
