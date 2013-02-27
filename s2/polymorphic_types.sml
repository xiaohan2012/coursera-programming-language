
(*
fn : 'a list * 'a list -> 'a list
*)

fun append (xs, ys)=
    case xs of
	[] => ys
     | x :: xs' => x :: append(xs',ys);

(*
Note the 'a in the function signature.

It is ok for `append` function to take in argument of type

int list * int list -> int list
or
string list * string list -> string list
or similar to bool.

Actually, you can replace the type variable, 'a with any concrete type you like

*)

(*
we say the type:
fn : 'a list * 'a list -> 'a list

is more general than the type:
string list * string list -> string list
or any type replacing 'a with int or bool or..

But it is not more general than 
int list * string list -> string list

*)


(*
Formal definition of `more general`:
we sal type t1 is more general than type t2 if we can take t1 and replace its type variables consistantly and get t2.

*)

(* 
The more general rule also works for record and type synonym.

*)

type foo = int * int;
fun general {k1 : 'a, k2 : 'b , k3 : 'a} = 
    1

fun less_general {k2 : foo, k1 : int, k3 : int} =
    1

fun equivalent_type {k3 : int , k2 : int * int, k1 :  int} = 
    1

(*
equality type
*)

(*
''a * ''a -> string
*)
fun is_same (x1,x2) = 
    if x1 = x2 then "yes" else "no"

(* 
here we see an extra ', this means ''a can only be replaced with types that can use =, for examle, int ,stirng and bool.

Exceptions include real, because we can only say two real numbers are about the equal, not precisely the equal.
*)

(*
in this case, because on the right side of the equality operator is an int, so the type of x is inferred as int.
*)
fun integer_as_1 (x) = 
    if x = 1 then "yes" else "no"

