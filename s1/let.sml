(*
here we introduce the notion of local variable by using `let` expression
*)

fun let1(x : int) = 
    let
	(* here we put value bindings*)
	(* variable bindings will be only effective in this environment*)
	val y = x + 1
    in
	(*the evaluation result of the let expression will be the evaluation result of the result between `in` and `end`*)
	y
    end	

fun let2() = 
    let 
	val x = 1
    in
	(* let expression can be nested*)
	(*the inner x will not be affected by the outer x
	 because the outer x is shadowed.
	and it only affect the let expression
	 *)
	(let val x = 2 in x+2 end) + (let in x + 2 end) 
    end

(*
here we learn the concept of scope.
A binding's scope is where the binding exists in the environtment

Only in later binds and the body of the let expression, it is accessible.

Unless it is shadowed.

And nothing new here actually, we are doing the variable binding, typecheck ... in a local environment.
*)
