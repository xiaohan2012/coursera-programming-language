(*given 10 and 1*)
fun countdown (from : int, to : int ) =  (* [10,9,8,7,6,5,4,3,2,1]*)
    if from = to
    then from :: []
    else from :: countdown(from-1, to)

(*given 1 and 10*)
fun countup (from : int, to : int ) =  (* [1,2,3,4,5,6,7,8,9,10]*)
    if from = to
    then from :: []
    else from :: countup(from + 1, to)

fun bad_max(xs : int list)=
    if null xs
    then 0(*ugly even incorect though*)
    else if null (tl xs)
    then hd xs
    else if (hd xs) > bad_max(tl xs)
    then hd xs
    else bad_max(tl xs)
(* 
try this
bad_max(countdown(10,1));
#val it = 10 : int

bad_max(countdown(100000,1));
#val it = 100000 : int

bad_max(countup(1,10));
#val it = 10 : int

bad_max(countup(1,30));
compute you to death

because
In the 1:30 example, bad_max is computed `twice` in `each` level of the recursion, thus
the computing time for 30:1 is exponentially larger than the 1:30 sequence
*)

(* how about save the value of max so that we only need to compute it once*)
fun good_max(xs : int list)=
    if null xs
    then 0(*ugly even incorect though*)
    else if null (tl xs)
    then hd xs
    else
	let
	    val max_val = good_max(tl xs)
	in
	    if (hd xs) > max_val
	    then
		hd xs
	    else
		max_val
	end

(*
try this.
Much faster.

- good_max(countup(1,30));
val it = 30 : int
- good_max(countup(1,10000));
val it = 10000 : int
*)
