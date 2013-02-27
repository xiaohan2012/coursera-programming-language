(*1*)
fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 < #1 d2
    then true
    else if #1 d1 > #1 d2
	     then false
	     else  if #2 d1 < #2 d2
               then true
               else if #2 d1 > #2 d2
   	                then false
	                else #3 d1 < #3 d2	  
(*2*)
fun number_in_month (xs :(int * int * int) list, x : int) =
    if null xs
    then 0
    else if #2 (hd xs) = x
         then 1 + number_in_month (tl xs, x)
         else number_in_month (tl xs, x)

(*3*)
fun number_in_months (xs :(int * int * int) list, ys : int list) =
    if null xs orelse null ys
    then 0
    else number_in_month (xs, hd ys) + number_in_months (xs, tl ys)

(*4*)
fun dates_in_month (xs :(int * int * int) list, x : int) =
    if null xs
    then []
    else if #2 (hd xs) = x
         then (hd xs) :: dates_in_month (tl xs, x)
         else dates_in_month (tl xs, x)

(*5*)
fun dates_in_months (xs :(int * int * int) list, ys : int list) =
    if null xs orelse null ys
    then []
    else dates_in_month (xs, hd ys) @ dates_in_months( xs, tl ys)

(*6*)
fun get_nth (xs : string list, x : int) =
    if null xs orelse x = 1
    then hd xs
    else get_nth (tl xs, x - 1)
(*7*)    		
fun date_to_string (d : int * int * int) =
   get_nth (["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], #2 d) ^ " " ^ Int.toString(#3 d) ^", "  ^ Int.toString(#1 d)

(*8*)
fun number_before_reaching_sum (x : int, xs : int list) =
    if x - hd xs <= 0
    then 0
    else 1 + number_before_reaching_sum (x - hd xs, tl xs)

(*9*)
fun what_month (x : int) =
    number_before_reaching_sum (x, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) + 1

(*10*)
fun month_range (x : int, y : int) =
	if x > y
        then []
        else if x = y 
             then what_month (y) :: []
	         else what_month (x) :: month_range (x + 1, y)


(*11*)
fun oldest (xs : (int * int * int) list) =
    if null xs
    then NONE
    else let
        fun oldest_nonempty (xs : (int * int * int) list) =
            if null (tl xs)
            then hd xs
            else let val tmp = oldest_nonempty (tl xs)
                in
                if is_older (hd xs, tmp) 
                then hd xs
                else tmp
                end
    in
        SOME (oldest_nonempty xs)
    end
