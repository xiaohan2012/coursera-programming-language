(*given 1 and 10*)
fun countup (from : int, to : int ) =  (* [1,2,3,4,5,6,7,8,9,10]*)
    if from = to
    then from :: []
    else from :: countup(from + 1, to)

(*in the previous max example, returning 0 is absolutely wrong if a sequence of negative numbers are passed to it*)
(* we may fix this by returning nothing if an empty list is returned and return the value if the list is not empty*)

fun max1(xs : int list)=
    if null xs
    then NONE
    else
	let
	    val max_val = max1 (tl xs)
	in
	    if isSome(max_val) andalso ((hd xs) < valOf max_val)
	    then max_val
	    else SOME (hd xs)
end

(*
try this
- max1(countup(1,1000));
- max1([]);
*)

(*
however, in the max1 function, once a non-empty list is passed to it,
every level of the recursion will pass the isSome test except the last recursive call.

*)


(*
we can eliminate the superfluous process by handling the last recursive call differently in a separate nested function
*)

fun max2(xs : int list) =
    if null xs
    then NONE
    else 
	let
	    fun max_nonempty(lst : int list)=
		if null (tl lst)
		then hd lst(*here we handle it differently*)
		else
		    let(* we must put a let expression here *)
			val max_val = max_nonempty (tl lst)
		    in
			if max_val > (hd lst)
			then
			    max_val
			else
			    hd lst
		    end
	in 
	    SOME (max_nonempty xs)(*not SOME max_nonempty (xs)*)
	end
