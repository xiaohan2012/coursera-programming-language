(*
type inference basic procedures.
1, collect all the facts, like data binding types
2, use these facts to contrain the function type
*)
val x = 42(*x is an integer*)

fun f (y,z,w)=
    if y(*y is a bool*)
    then z+x(*because x is an int, the only thing that can be added to an int is an int, so z is an int*)
    else 0(*checks if the else branch matches with the then branch, Yes, it does.*)

(*
as w is not used in the function, its type is arbitrary
funtion f type is bool*int*a' -> int
*)

(*
type inference and type variables(polymorphism) are two different concepts.
A language can have ti without tv
Conversely, a language can have tv without ti(like you need to write down the types in Java meanwhile benifiting polymorphisim.
*)


(*
when there is less constraints, polymorphic types may appear.
*)
(*
length: T1 -> T2
xs: T1

x : T3
xs' : T3 list

T2 : int #because length might return an int

that's it. No more clues.

conclude:
length : T3 list -> int
*)
fun length xs=
    case xs of
	[] => 0
      | x::xs' => 1 + (length xs')



(*
compose: t1 * t2 -> t3
x : t4

anonymous function body: t3 = (t4 -> t5)

as g takes in x
g: t4 -> t6
as f takes in the result of g with x
f: t6 -> t7 (t7=t5)

(t6 -> t5) * (t4 -> t6) -> (t4 -> t5)

('a -> 'b) * ('c -> 'a) -> 'c -> 'b
*)


fun compose1 (f,g) = fn x => f (g x)

fun compose2 (f,g) = fn x => f g x
(*
compose: t1 * t2 -> t3
f: t1
g: t2

x: t4

f: t1 = t2 -> t5

f g: t5 = t4 -> t6

t3 = t4 -> t6


(t2 -> t4 -> t6) * t2 -> t4 -> t6
('a -> 'b -> 'c) * 'a -> 'b -> 'c

*)

