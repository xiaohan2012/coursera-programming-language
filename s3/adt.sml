(*abstract data type can be implemented in SML*)
(*it is like OOP*)
datatype set = S of {
		 insert : int -> set,
		 member : int -> bool,
		 size : unit -> int				     
}

(*library side*)
val empty_set  = 
    let
	fun makeset xs =
	    let
		fun contains x = List.exists (fn y => x=y) xs
	    in
		S {
		    insert = (fn x  => if contains x 
				     then makeset xs
				     else makeset (x::xs)),
		    member =  contains,
		    size = fn () => length xs
		}
	    end
    in
	makeset []
    end

val S s1 = empty_set
val S s1 = (#insert s1) 24
val S s1 = (#insert s1) 24
val S s1 = (#insert s1) 34
val is_member1 = (#member s1) 34
val is_member2 = (#member s1) 33
val size = (#size s1)()
