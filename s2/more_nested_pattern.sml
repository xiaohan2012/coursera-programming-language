fun non_dec list = 
    case list of
	[]=>true
     | _ :: [] => true
     | head :: (neck :: rest) => if head <= neck then non_dec (neck :: rest) else false

val is_dec1 = non_dec [1,2,3,4];
val is_dec2 = non_dec [1,2,3,2];


datatype sgn = Z | N | P;(*arithmatic sign, zero, positive and negative*)

fun multiply_sign (x1, x2) = 
    let
	fun sign (x) = 
	    if x = 0 
	    then Z 
	    else if x > 0 
	    then P 
	    else N
    in
	case (sign x1, sign x2) of
	    (Z,_) => Z(* the patterns are checked in order, from top to bottom*)
	 |  (_,Z) => Z
	 |  (P,P) => P
	 | (N,N) => P
	 | _ => N(*otherwise*)
    end
val s1 = multiply_sign(1,~2);
val s2 = multiply_sign(0,1);
val s3 = multiply_sign(~2,~1);

fun listlen list = 
    case list of
	[] => 0
      | _ :: tl => 1 + listlen(tl)(*use _ if you don:t need the variable*)
