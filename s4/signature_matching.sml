(*
structure st -> sig
signature matching rule:
1, every non-abstract data type in sig is provided in st
2, every abstract data type in sig is provided in st in some way, like datatype and type synonym
3, every val binding in sig is provided in st in some way,like function binding and value binding.
function binding with less general arguments(like string -> string) in sig should be matched with one with more general type in st(like 'a -> 'a)
4, exception
*)
