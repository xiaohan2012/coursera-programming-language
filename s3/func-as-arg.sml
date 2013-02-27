fun incr_n_times(x,n) = 
    if n = 0
    then x
    else 1 + incr_n_times(x,n-1)
    
fun double_n_times(x,n) = 
    if n = 0
    then x
    else 2 * double_n_times(x,n-1)

fun tail_n_times(xs,n) = 
    if n = 0
    then xs
    else tl (tail_n_times (xs,n-1))
    
(*
using first order function directly
the above three are quite ugly and not reusable
*)

(*
take a little time on them, we can find they actually have some common parts, like the if n=1 then x else part,
Let's try use another function to factor out the common parts and pass in different functions as arguments to capture the different parts
*)

fun n_times(f,x,n) = 
    if n=0
    then x
    else f (n_times(f,x,n-1))

(*the different parts*)
fun incr x = 1+x
fun double x = 2*x

fun addition (x,n) = n_times(incr,x,n)
fun double_n_times(x,n) = n_times(double,x,n)
fun tl_n_times(x,n) = n_times(tl, x, n)

val four = addition(1,3)
val twelve = double_n_times(3,2)
val two = tl_n_times([5,4,3,2],3)

(*
by using higher order function
this becomes extensble because we can plugin other functions later
*)

(*
Note: being higher order function does not necessarily mean having polymorphic types
For example:
*)
fun silly1 x = (*'a list -> 'a list*)
    tl x

fun silly2 (x,f) = (*int * (int -> int) -> int*)
    f (x+1)+ 1
