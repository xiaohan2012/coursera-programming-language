(*
map and filte, two important functions in the hall-of-fame function list.
It is not only commonly used, but also being capable of communicating what you are trying to do

*)

fun map(f,xs)=
    case xs of
	[] => []
      | x::xs' => f(x) :: map(f,xs')

fun filter(f,xs)=
    case xs of
	[] => []
      | x::xs' => if f(x) then x::filter(f,xs') else filter(f,xs')

val xs = [1,2,3]
val xs_mul_by_two = map((fn x => x*2), xs)
val all_greater_than_one = filter((fn x => x>1), xs)

