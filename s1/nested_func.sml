(*
in the following example, 
we define a helper function outside of the function it helps
*)

fun count_worst(from : int, to : int)=
    if from = to
    then from :: []
    else from :: count_worst(from +1, to)

fun count_from1_worst(to : int) =
    count_worst(1,to)

(*
in the following example, 
we define a helper function inside of the function it helps
*)

fun count_from1_better(x : int)=
    let
        (*
	count_better is a better one than the previous one only if the parent function needs it
        because it encapsulates everything
	*)	
	(* 
        but note here argument `to` is extra
        and we can replace `to` use `x`
	*)
	fun count_better(from : int, to : int)=
	    if from = to
	    then from :: []
	    else from :: count_better(from +1, to)
    in 
	count_better(1,x)
    end

fun count_from1_best(x : int)=
    let 
	fun count_best(from : int) = 
	    if from = x(*SML will find  `x` in the current environment*)
	    then from :: []
	    else from :: count_best(from+1)
    in
	count_best(1)
    end
(*
Nested function is actually a kind of programing style

And put the helper function inside of the being-helped function if
1. it is not used elsewhere
2. it is likely to be misused, so that other function will not have access to this error-prone code
3. it is likely to be changed, so that the affect will propagate outwards.
*)

(*
a fundamental trade-off in code design
more reusable code which saves time and avoid bugs, but meanwhile harder to be changed.
*)
