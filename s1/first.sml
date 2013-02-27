(* this is a comment, this is our first program*)

val x = 34;(* int *)
(* 34 is an expression, the simplest form of an expression*)
(* the static environment, x : int*)

val y = 4;
(* the static environment, x: int, y : int *)

val z = x + y;
(* the static environtment, x: int, y: int ,z :int *)

val error = if y > 4 then y else x;
(* the type checker will detect a error here because the types of y and 0.1 are not consistent*)



