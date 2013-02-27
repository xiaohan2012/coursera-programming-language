(*
a key purpose of abtraction is to allow different implementations to be equivalent, so that:
1, user cannot tell which implementation they are using
2, you can safely replace the implementation with one another later with little worry

Note: it is often easier to get equivalent implementations if more abstract signatures are given.
*)

(*
given two signatures
*)
signature RATIONAL_A = (*this is less abstract*)
sig
    datatype rational = Whole of int | Frac of int *int
    exception DividedByZero
    val add : rational * rational -> rational
    val make_frac : int * int -> rational
    val toString : rational -> string
end

structure Rational1 :> RATIONAL_A = 
struct
    datatype rational = Whole of int | Frac of int *int
    exception DividedByZero
    fun gcd (a,b) = (*assume inputs are non-negative*)
	if a=b
	then a
	else if a<b
	then gcd(a,b-a)
	else gcd(b,a)

    fun reduce r=
	case r of
	    Whole _ => r
	  | Frac (x,y) => if x=0
			  then Whole 0
			  else 
			      let 
				  val d = gcd(abs x,y) (*variant: y is non-negative*)
			      in
				  if d=y
				  then Whole (x div d)
				  else Frac (x div d, y div d)
			      end
    fun make_frac (x,y) = 
	if y=0
	then raise DividedByZero
	else if y<0
	then reduce(Frac (~x,~y))
	else reduce(Frac (x,y))

    fun add (x,y) = 
	case (x,y) of
	    (Whole x, Whole y) => Whole (x+y)
	  | (Whole x, Frac (y1,y2)) => reduce(Frac (x*y2+y1, y2))
	  | (Frac (x1,x2), Whole y) => reduce(Frac (x1+x2*y, x2))
	  | (Frac(x1,x2), Frac(y1,y2)) => reduce(Frac(x1*y2+x2*y1,x2*y2))
    fun toString x = 
	case x of
	    Whole x => Int.toString(x)
	 | Frac (x,y) => Int.toString(x) ^ "/" ^ Int.toString(y)
end


(*
reduce frac only when toString
*)
structure Rational2 :> RATIONAL_A = 
struct
    datatype rational = Whole of int | Frac of int *int
    exception DividedByZero

    fun make_frac (x,y) = 
	if y=0
	then raise DividedByZero
	else if y<0
	then Frac (~x,~y)
	else Frac (x,y)

    fun add (x,y) = 
	case (x,y) of
	    (Whole x, Whole y) => Whole (x+y)
	  | (Whole x, Frac (y1,y2)) => Frac (x*y2+y1, y2)
	  | (Frac (x1,x2), Whole y) => Frac (x1+x2*y, x2)
	  | (Frac(x1,x2), Frac(y1,y2)) => Frac(x1*y2+x2*y1, x2*y2)

    fun toString x = 
	let
	    fun gcd (a,b) = (*assume inputs are non-negative*)
		if a=b
		then a
		else if a<b
		then gcd(a,b-a)
		else gcd(b,a)
			
	    fun reduce r=
		case r of
		    Whole _ => r
		  | Frac (x,y) => if x=0
				  then Whole 0
				  else 
				      let 
					  val d = gcd(abs x,y) (*variant: y is non-negative*)
				      in
					  if d=y
					  then Whole (x div d)
					  else Frac (x div d, y div d)
				      end
	    val x = reduce(x)
	in
	    case x of
		Whole x => Int.toString(x)
	      | Frac (x,y) => Int.toString(x) ^ "/" ^ Int.toString(y)
	end	
end

val s1 = Rational1.toString(Rational1.Frac(2,6))(*2/6*)
val s2 = Rational2.toString(Rational2.Frac(2,6))(*1/3*)

(*
and try using the more abstract signature instead?
*)
(*
Conclusion:
More abstract signature makes structure equivalence more likely
*)

(*
More:

Structures with the same signature define different types.

For example:
    Rational1.toString(Rational2.Frac(3,4))
won't type check

- Rational1.toString;
val it = fn : Rational1.rational -> string
- Rational2.toString;
val it = fn : Rational2.rational -> string

Abstraction is a crucial feature for type system and module properties.

*)
