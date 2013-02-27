val pair = ("one","two");
val record = {1="one", 2="two"};
(* they are the same in essence*)

#1 record;
#1 pair;

(*and accessing elements uses the same way*)

(*tuple is a syntactic sugar of record*)

(*
reasons why design in such a way
1, make the language core/base simpler and smaller
2, by directly using the implmentation of record, this makes the tuple implementation easier
3, make the language model smaller, so that proof will be shorter
*)

(*
tuples and records are no different except tuples can use a different and easier syntax to define and it is printed differently from record prining.
*)

(*
by making the syntax of using tuple same to record, we can use the same semantics for record for tuple, which saves a lot of work for both programmer(because it is easier to understand based on an idea you already know and PL implementation developer(because you can reuse code from on construcst for another.
*)

