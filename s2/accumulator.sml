fun factorial n = 
    let
	fun aux (n,acc) =
	    if n=0
	    then acc
	    else aux (n-1, n*acc)
    in
	aux(n,1)
    end


(*
in this example, because the caller will not need to further evaluate the result or use the callee's result and make some other computation, 

In functional programming language like SML, compiler is smart enought to figure this out this tail calls and replace the caller the stack space with the callee's. In such way, we eliminate the stacked call space.

This is called tail-call optimization.
*)
