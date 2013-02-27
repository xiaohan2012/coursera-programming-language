(*every ML function takes in only one argument*)
(*here is another way to look at this, 
for multiple arguments, 
pass in one argument for the first function and returns a new function that takes the second argument that returns the third function that takes the third argument.....
for example:
*)
fun sum1 (x,y,z) = x+y+z
(*is equivalent to*)
fun sum2 x = fn y => fn z => x+y+z

val six1 = sum1 (1,2,3)
val six2 = sum2 1 2 3(*syntatic sugar becomes this takes less typing than the tuple one*)

(*this feature is actuallt built in SML*)
fun sum3 x y z = x+y+z (*this creates a currying, and the function type  fn : int -> int -> int -> int is interesting*)
val six3 = sum3 1 2 3
