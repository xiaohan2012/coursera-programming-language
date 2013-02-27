(*
callbacks are functions that are called when certain events arrive, such as data arrival, key pressed, mouse clicked
*)

val cbs : (int -> unit) list ref = ref []
fun register_callback f = 
    cbs := f::(!cbs)

fun on_event i = 
    let
	fun loop fs =
	    case fs of
		[] => ()
	      | f::fs' => (f i;loop fs')
    in
	loop (!cbs)
    end


val pressed_n = ref 0

val _ = register_callback (fn _ => pressed_n := (!pressed_n)+1)

fun i_pressed i =
    register_callback (fn j => 
			  if i=j 
			  then print (Int.toString i ^ " pressed\n" )
			  else ())


val _ = i_pressed 1
val _ = i_pressed 2
val _ = i_pressed 4
