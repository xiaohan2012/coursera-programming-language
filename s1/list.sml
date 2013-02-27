val x = [1,2,3]

val x = 4::x

val y = 5

(*
the :: (pronounced `cons`) operator adds the first operand to the second operand.
for e1::e2, if e2 is type `t list`, then e1 must be type `t` to typecheck
val int_list = [1,2,3]
val bool_val = true
val mixed_list = bool_val::int_list 
it will not pass type check
*)
val x = y::x

(* 
[5]::[1,2,3]
what does this mean? int list * int list list
because after seeting the [5], sml is expecting a int list * int list list appears, got it?
*)

(*we can use 
1. null to check if a list is empty, note `null` is a function
2. hd to get the first element of the list, if empty, error is thrown
3. tl to get the remaining elements of the list, except the first one
*)

val int_list = [1,2,3,4]
val first_element = hd int_list
val remainig_element = tl int_list

(*
For any type t, the type t list, describes a list of elements which all 
have type t
*)
val int_list = [1,2,3]

val bool_list = [true,false]

val int_bool_tuple_list = [(1,true),(0,false)]

val int_list_list = [[1,2],[3,4]]
(*
See? any type you want!
*)

(*
empty list is a special thing, it is of type `alpha list`
*)
val empty_to_int_list = 1::[]

val empty_to_bool_list = true::[]

(*
null, hd and tl functions takes argument of type 'a list
then what is type 'a?
if it takes in int list, it will return int
or bool list, return bool

hd [1,2,3]
val it = 1 : int

- hd
val it = fn : 'a list -> 'a
*)
