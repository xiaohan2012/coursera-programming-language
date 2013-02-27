fun double  x = 2*x
fun incr x = x+1

val a_tuple = (double, incr, incr (double 2))

(*
functions that be passed around like values(int,string,bool...) or inside a tuple, list, record, function argument, function result..
are called first class function(because they are quite elementary.

Other functions that uses functions as arguments or results are called higher order function.

Using this kind of paradigm is useful to factor out common functionality.

facto out: find the common part among a series of XX and then take the common part away
*)
