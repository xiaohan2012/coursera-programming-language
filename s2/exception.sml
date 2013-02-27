datatype person = gaofushuai | diaosi | baifumei

(*
variable,datatype can be binded, so does exception
by binding exception, we create new type of exception just like creating new datatype and variable
*)

exception AreYouGayException of person * person(*exception is like constructor, which can take in a pattern or not*)
exception YouMayNotMakeIt of person
exception IamGayException of person

fun chase (p1,p2) = 
    case (p1,p2) of 
	(gaofushuai,baifumei) => "bless you"
     |  (gaofushuai,_) => raise AreYouGayException (p1,p2)
     |  (diaosi,baifumei) => raise YouMayNotMakeIt(p1)
     |  (diaosi,_) =>  raise AreYouGayException (p1,p2)
     |  (baifumei,_) => "it is your choice!"


(*
use raise to launche an exception and handle to handle it
*)
val xiao = gaofushuai;
val feng = diaosi;
val wujue = baifumei;
chase(xiao,wujue);
chase(feng,wujue) handle YouMayNotMakeIt p => "just try it";
(chase(xiao,feng) handle (AreYouGayException (p1,p2)) => raise (IamGayException p1)) handle IamGayException p => "go ahead";		      

exception NonSenseException
exception SomeSenseException

(*
exception can be passed into function.
exception is of type `exn`
*)
fun passin_exp exp = 
    case exp of(*there is a nonexhaustive warning here*)
	NonSenseException => "it is nonsense"
     | SomeSenseException => "maybe some sense";

passin_exp NonSenseException;
passin_exp SomeSenseException;

exception witharg of int
fun test (a : int list, e : int -> exn) =
	 raise e

val test_val = test ([1,2], witharg)
