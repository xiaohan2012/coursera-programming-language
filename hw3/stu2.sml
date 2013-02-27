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

(* Solution problem 1 *)
fun only_capitals (xs) =
     List.filter(fn a => Char.isUpper(String.sub(a,0)))  xs
(* Solution problem 2 *)
fun longest_string1 xs =
     foldl (fn (a, b) => if String.size a > String.size b then a else b) "" xs;

(* Solution problem 3 *)
fun longest_string2 xs =
     foldl (fn (a, b) => if String.size a >= String.size b then a else b) "" xs;

(* Solution problem 4 *)
fun longest_string_helper f xs =
        case xs of
          [] => ""
         |y::[]  => y
         |z1::z2::z'  => if (f (String.size z1, String.size z2))
                        then  longest_string_helper f ( z1::z')
                        else  longest_string_helper f ( z2::z');  


val longest_string3 = longest_string_helper (fn (a, b) => a >= b);
val longest_string4 = longest_string_helper (fn (a, b) => a > b);


(* Solution problem 5 *)
fun longest_capitalized x  =(longest_string1 o only_capitals) x;

(* Solution problem 6 *)
fun rev_string x = (implode o rev o explode) x; 


(* Solution problem 7 *)
fun first_answer f xs = 
      case  xs of
        [] => raise NoAnswer
       | x::xs'  => case f x of
                       NONE   => first_answer f xs'
                     | SOME v => v;

(* Solution problem 8 *)
fun all_answers f xs = 
      let fun helper_f (f, xs, acc) =
               case xs of 
                  [] => SOME acc
		| x::xs'  => case f x of
                                NONE   => NONE
			      | SOME v => helper_f(f, xs', (acc @ v))
      in
        helper_f (f, xs, [])
      end;  

(* Solution problem 9 *)
(* 9.a *)

fun count_wildcards p  = g (fn () => 1) (fn y => 0)  p;

(* 9.b *)
fun count_wild_and_variable_lengths p = g (fn () => 1) (fn y => String.size(y)) p;

(* 9.c *)
fun count_some_var (xs, p) = g (fn () => 0) (fn y => if y = xs then 1 else 0) p;

(* not enough time for me this time to finish the rest in time *)

(* Solution problem 10 *)


(* Solution problem 11 *)

(* Solution problem 12 *)

