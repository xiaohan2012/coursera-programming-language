fun filter(f,xs) = 
    case xs of
	[] => []
      | x::xs' => if f(x) then x::filter(f,xs') else filter(f,xs')

fun shorterThanX1(xs,s) =
    filter(fn x => String.size x < (print "!\n";String.size s), xs)

fun shorterThanX2(xs,s) = 
    let 
	val _ =	print "!\n"
	val size = String.size s(*prevent recomputing*)
    in
	filter(fn x => String.size x < size, xs)
    end

(* ; is an operator that, for example, exp1 ; exp2, evaluates exp1, discard it than evaluate exp2*)

val s = "~~~~~";
val xs = ["1212","asdf","13","qweeqwqe"]

val _ = print "shorterThanX1\n"
val xs' = shorterThanX1(xs, s)

val _ = print "shorerThanX2\n"
val xs' = shorterThanX2(xs, s)
    
