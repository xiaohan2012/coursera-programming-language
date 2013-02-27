(*
data type can be used to:
1, enumerations
like poker suit and rank
*)
datatype suit = Spade | Heart | Clubs | Diamond;
datatype rank = Jack | Queen | King | Ace | Num of int;

(*
and also real datatypes in real world.
Like user on the website, who may have registered or not.
*)

datatype user = userid of int (*registered*)
	      | userinfo of string * (*name*)
			    string * (*email*)
			    (string option); (*website address,option*)

(*
Languages which make one-of type inconvenient to use often leads to the misuse of each-of each where one-of is the right thing to use
For example,
A website user, who may have registered or not, will have either a userid OR a bunch of related information.
Here, we should use one-of type
{
user_id : int,
name : string,
email : string,
website_add : string option
}
bad style, because not straight forward
*)

(*
Of course, in cases where each-of is the right thing to do.

Like a website user, who may have a userid(or not) as well as a bunch of related information, then make userid an option.

{
user_id : string option,
name : string,
email : string,
website_add : string option
}
*)

(*
Here comes the exciting part, expression tree
few things to notice:
1, there is self-reference here, because an expression can contain other expression.
2, every expression(including Constant) is a conceptual tree
3, leaves are always constants and internal nodes are the other three cases
4, You can write expression in this way, 
   like for (1 + 2) * (-3)
   Multuply (Add (Constant 1, Constant 2) , Negate (Constant -3))
*)

datatype exp = 	 
	 Constant of int
       | Negate of exp
       | Add  of exp * exp
       | Multiply  of  exp * exp
				 
fun eval (x : exp) = (* exp -> int*)
    case x of
	Constant e => e
      | Negate e => ~(eval e)
      | Add (e1,e2) => (eval e1) + (eval e2)
      | Multiply (e1,e2) => (eval e1) * (eval e2);
(*
recursive/self-referencing datatypes usually result in recursive function on that datatype
*)
val example_exp = Multiply (Add (Constant 1, Constant 2) , Negate (Constant 3));
val example_result = eval example_exp;
