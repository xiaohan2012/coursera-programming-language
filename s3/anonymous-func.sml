(*this function can be written in a simpler form*)

fun n_times(f,x,n) =
    if n=0
    then x
    else f (n_times(f,x,n-1))

fun triple_n_times (x,n) = n_times(fn x => 3*x, x,n)

val nine = triple_n_times (3,1)
    
(*
Doing so is actually because using a let in end expression is cumbersome
    let
        fun triple x =  3*x
    in
        triple
    end
and the name triple is not necessary.

So we can use an anonymous function, which is different:
1, it has no name
2, it is not a function binding
*)

(*
In fact, in some way, a function can be seen as the syntactic sugar of the following form

val function_name = fn (x,....) => expression

However, for the sake of recursion, it is not the case, because recursion works by calling the name of the function recursively. Having a name means the function is created by function binding, rather than anonymous function. So recursion won't work for anonymous function
*)
