(*
1, needless and better not to use # to extract data from tuple or record
2, don't need to specify the data type for argument

because typechecker will do that for you

*)

fun sum_triple (x,y,z) = 
    x+y+z

fun cat_strings {one = x, two = y, three = z} = 
    x ^ y ^ z

(*
sometimes, unexpected polymorphism happens
*)
(*int * 'a * int -> int*)

fun partial_sum (x,y,z) = 
    x+z

(*but it is ok, because  int * 'a * int -> int is more general/less constraint than  int * int * int -> int*)

