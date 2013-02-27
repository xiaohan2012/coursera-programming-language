datatype mytype = TwoInts of int*int
       |Str of string
       |Pizza

(*mytype -> string*)
fun f(x : mytype)=
    case x of(*1, pattern matching*)
	Pizza => "It is Pizza"
     | Str s => s
     | TwoInts (x1,x2)(*2, local` variable` binding introduced here*) => Int.toString(x1) ^ " + " ^ Int.toString(x2)(*3,evaluate this expression*)
     (*| Pizza  => "another Pizza"; (*redundant matching*)*)

(*fun f1(x : mytype) = case x of Pizza => "only Pizza"; (*inexhaustive pattern matching*)*)


f (Str "feng");
f (TwoInts(1,2));
f Pizza;

(*
Workflow:
1, mutli-branching conditions to match the branch based on variant.
by match, ML uses pattern-matching(built from the same constructor) here

2, extract the data and binds to variables local to that branch(like `let` expression)

3,type-checking: all expressions on the right side of => must have the same type, in the above case, it is string

4,evaluate the right side expression on the matched branch and the result becomes the evaluated result of the case of expression.

*)

(*
General form of `case` expression

case e of 
  p1  => e1
| p2 => e1
| p3 => e3
....

pn on the left side of the => is not expression,though similar, they are pattern

Pattern is a constructor name followed by the right number of variable names

Patterns are not to be evaluated, it is used for pattern matching
*)

(*
now comes to the question of writing testing and data-extraction functions like null,hd and tl

Use case expression is much more elegant and convenient, because first,
1, I don't known how to do pattern matching outside of case expression
2, case expression does it for me

And actually, it does much more:
1, check exhaustiveness(inexhaustive pattern matching `warning`),cover all the possibilities.
2, check duplicates(a typechecking error).
3, Pattern matching is more than that.
*)
