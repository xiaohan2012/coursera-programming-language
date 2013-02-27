(*expression in record definition will be evaluated*)

val feng = {name="feng", age=24 - 1, from = "henan" ^ " zhoukou"};
#name feng;

(*record are quite similar to tuple except record elements are accessed by name, while tuple by position.

This leads to one issue of programming language design, pass/get function parameter by name or by position.

C, Java and many other PL uses a hybird approach.

The function calling passes parameter by index while the callee uses the parameters by name
*)


