fun sum_list(lst : int list) = 
    if null lst
    then 0
    else hd lst + sum_list(tl lst)

fun prod_list(lst : int list) = 
    if null lst
    then 1
    else hd lst * prod_list(tl lst)

(* given x : 5*)
fun countdown (x : int ) =  (* [5,4,3,2,1]*)
    if x = 1
    then [1]
    else x :: countdown(x-1)

(* int list * int list -> int * list*)
(* xs : [1,2,3] ys : [4,5,6] *)
fun append(xs : int list, ys : int list) =  (* [1,2,3,4,5,6]*)
    if null xs
    then ys
    else hd xs :: (append(tl xs, ys))

(*
we can only append the element in xs one by one into ys, because cons operator 
acts this way. --||
*)


fun sum_pair_list(xs : (int * int) list)=
    if null xs
    then 0
    else (#1 (hd xs)) + (#2 (hd xs)) + sum_pair_list(tl xs)

(* [(1,2),(3,4)]*)
fun firsts ( xs : (int * int) list) = (*[1,2]*)
    if null xs
    then []
    else (#1 (hd xs)) :: (firsts(tl xs))
(* [(1,2),(3,4)]*)
fun seconds ( xs : (int * int) list) = (*[2,4]*)
    if null xs
    then []
    else (#2 (hd xs)) :: (seconds(tl xs))

(* another way to write sum int pair list*)
fun sum_pair_list2(xs : (int * int) list)=
    sum_list(firsts(xs)) + sum_list(seconds(xs))

(* given x : 5*)
fun factorial( x : int) =  (*returns the factorial 120 *)
    prod_list(countdown(x))

(* functions over list are often recursive
You need to think about
1, what if the list is empty,what would you do?
2, what if the list if not empty, what would you do?
*)
