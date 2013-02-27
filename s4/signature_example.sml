(*invariant:
1, all denominators > 0
2, rational kept in reduced form
*)

structure Rational = 
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
end

val f1 = Rational.make_frac(~1,~3)
val f2 = Rational.make_frac(2,6)
val f3 = Rational.add(f1,f2)

(*val invalid_f = Rational.make_frac(1,0)*)

(*The above approach is quite unsafe because the implementation has several assumptions on how its functions should be used, like:
1, the denominator is converted to non-negative number
2, the denominator should not be zero
3, the fraction number is reduced when being involved in addition

However, user will not necessarily follow this rule
*)
(*
val invalid_f1 = Rational.Frac(1,0)
val invalid_f2 = Rational.reduce(Rational.Frac(1,~2))(*should cause overflow*)
*)
(*
so we need to hide something from the user, like the function gcd and rational 
*)

signature rational_sig = 
sig
    type rational(*abstract datatype, this is necessary for 1,it notifies the data type 2, without any further information of how this datatype is implemented*)
    val Whole: int -> rational(*exposing Whole is not dangerous*)
    exception DividedByZero
    val add : rational * rational -> rational
    val make_frac : int * int -> rational
end
