datatype exp = 	 
	 Constant of int
       | Negate of exp
       | Add  of exp * exp
       | Multiply  of  exp * exp

fun min_constant( e : exp) = 
    case e of
	Constant e => e
     | Negate e  => min_constant e
     | Add (e1,e2) => Int.min( min_constant e1, min_constant e2)
     | Multiply (e1,e2) => Int.min(min_constant e1, min_constant e2);

val exp = Multiply (Add (Constant 1, Constant 2) , Negate (Constant 3))
val one = min_constant(exp)

(*
Acutally, there is a long way before finally reaching to this point
*)
