(*
Polymorphism is a programming language feature that allows values of different data types to be handled using a uniform interface.
*)

(*
list and option are not types, it is int list or int option that are types.

list and option are type constructors that takes in type parameter and create types

In other words, list and option are polymorphic datatype bindings

*)

(*this is how `option` in SML is defined*)
datatype 'a option = NONE | SOME of 'a;

datatype 'a list =  EMPTY 
		  | Cons of 'a * 'a list;

datatype ('a,'b) tree = Leaf of 'b
		      | Node of 'a * ('a,'b) tree * ('a,'b) tree;

(*the following are several polymorphic functions*)

(*type checking bases on how data passed in are used and try to figure out the types of the arguments and return value*) 
(*and make sure types are used consitentlt, like you cannot mix types in a list*)

(*fn : ('a,int) tree -> int*)
fun sum_leaves(t) = 
    case t of 
	Leaf x=> x
      | Node (value, lft, rgt) =>  sum_leaves (lft) + sum_leaves (rgt)

(*fn : (int,'a) tree -> int*)
fun sum_nodes(t) = 
    case t of
	Leaf x => 0
      | Node(value,lft,rgt) => value + sum_nodes(lft) + sum_nodes (rgt)

(*fn : ('a,'b) tree -> int*)
fun num_nodes(t) = 
    case t of
	Leaf x => 0
     | Node(value, lft, rgt) => 1 + num_nodes(lft) + num_nodes (rgt)
