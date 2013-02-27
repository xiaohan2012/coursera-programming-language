(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

 datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)


val only_capitals = List.filter (fn x => Char.isUpper (String.sub(x, 0)))

val longest_string1 =
    foldl (fn (x,y) => if String.size y < String.size x then x else y) ""

val longest_string2 =
    foldl (fn (x,y) => if String.size y <= String.size x then x else y) ""

fun longest_string_helper f = foldl (fn (x,y) => if f(x,y) then x else y) ""

val longest_string3 = longest_string_helper (fn (x,y) => String.size y < String.size x)

val longest_string4 = longest_string_helper (fn (x,y) => String.size y <= String.size x)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = implode o rev o explode

fun first_answer f l =
    case List.mapPartial f l of
        [] => raise NoAnswer
      | x::_ => x

(*
fun all_answers f l =
    let fun helper (l, acc) =
            case l of
                [] => acc
             |  NONE::_ => NONE
             |  x::xs => helper (xs, (valOf x) @ acc)
    in
        case helper (map f l, []) of
            NONE => NONE
         | lst => SOME list
    end
*)

val count_wildcards = g (fn () => 1) (fn (_) => 0)

val count_wild_and_variable_lengths = g (fn () => 1) String.size 

fun count_some_var (s,p) = g (fn () => 0) (fn (x) => if s = x then 1 else 0) p

fun check_pat p =
    let fun var_strings (p, acc) =
            case p of
                Wildcard => acc
              | Variable x => x :: acc
              | TupleP ps => List.foldl (fn (p, acc) => var_strings (p,[]) @ acc) [] ps
              | ConstructorP(_,p) => var_strings (p, []) @ acc
              | _ => acc

        fun has_repeats l =
            case l of
                [] => false
              | x::xs => (List.exists (fn(s) => s = x) xs) orelse (has_repeats xs)
    in
       not(has_repeats (var_strings (p, [])))
    end

(*
fun match (v, pat) =
    case (v, pat) of
        (_, Wildcard) => SOME []
      | (v, Variable s) => SOME [(s,v)]
      | (Unit, UnitP) => SOME []
      | (Const x, ConstP y) => if x = y then SOME [] else NONE
      | (Tuple l, TupleP pl) => case all_answers match (ListPair.zip(l,pl)) of

      | (Constructor (s1, v), ConstructorP (s2, p)) => if s1 = s2 then match(v,p) else NONE
      | _ => NONE
*)
