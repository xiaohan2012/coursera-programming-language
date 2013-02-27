(*
Function equivalence is an important concept in Software Engineering

when writing equivalent functions, put a mind on:
1, backward compatability
2, speed
3, code maintenance: is the code simplified
4, abstraction: can the user tell the difference

Tips on being equivalent:
1, fewer arguments
2, avoid side effects(mutation, IO and exception)

*)

fun foo f x y z = 
    if x >= y
    then (f z)
    else foo f y x (tl z)

(*
foo : t1 * t2 * t3 * t4 -> t5
f : t6 list -> t5
x : t2
y : t2
z : t6 list
(t6 list -> t5) * t2 * t2 * (t6 list) -> t5


('a list -> 'b) * 'c * 'c * ('a list) -> 'b


*)
