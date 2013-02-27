(*
there is mutable data type in SML called reference
it is like one-field mutable object
*)

(*create a reference(like pointer)*)
val x = ref 42(*x refers to the 42 reference object*)
val y = ref 43 (*another 42*)
val z = x(*z refers to what x refers to*)
val _ = x := 1(*changes the content in reference*)
val w = !z + !y

