(* 1 *)  val x = 1

(* 2 *)  fun f y = x + y (*increment y, here, a closure which contains two parts,1, the code 2, the exvironment in which x maps to 1, is saved*)

(* 3 *)  val x = 2(*shadows x to 2*)

(* 4 *)  val y = 4

(* 5 *)  val z = f (x+y) (* call the function at 2 with 5*)

(* a function is evaluated in the environment where it is defined
and the environment be extended with the argument when the function is called*)

(*
basic definition 
lexical scope: use environment where function is *defined*
dynamic scope: use environment where function is *called*
*)

(*advantages of lexcical scope over dynamic scope*)
(*
less eggache for variable name confliction, for example
*)
fun f1 y = 
    let 
	val x = 1
    in
	fn z => x+y+z
    end

val x = 2(*in dynamic scope, x=2 will affect the f2 function and the result will be 4. This is not the way modularity is supposed to work*)
val f2 = f1 1
val three = f2 1

(*in lexical scope, it is often reasonble to *delete* part of the code to have a better idea on the code*)

	
fun f2 g = 
    let
	val x = 1
    in
	g 3
    end
val x = 2(* in dynamic scoping, this mapping will overwrite the x=1*)
val g = f1 1
val five = f2 g

(*
functions can carry the data they need(combining the data and function body, it forms closure, so we can say pass in a closure into a function instead of saying passing in a function into a function)
