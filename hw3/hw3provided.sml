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
(* 1 *)
val only_capitals  = List.filter (fn s => Char.isUpper(String.sub(s,0)))

(* 2 *)
val longest_string1 = foldl (fn (x,y) => if String.size x > String.size y then x else y)  ""
						 
(* 3 *)
val longest_string2 = foldl (fn (x,y) => if String.size (x) >= String.size(y) then x else y) ""

(* 4 *)
fun longest_string_helper f xs = foldl (fn (x,y) => if f(String.size x, String.size y) then x else y) "" xs
val longest_string3 = longest_string_helper (fn (x,y) => x > y)
val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

(* 5 *)
val longest_capitalized = longest_string1 o only_capitals
    
(* 6 *)
val rev_string = String.concat o List.map Char.toString o rev o String.explode
				  

    

(*test*)
(*1*)val only_capitals1 = only_capitals ["asd","Abc","abc","Bcd"]
(*2*)val longest1 = longest_string1 ["asd4","Abcd5","abcde6","head####","tail####"]
(*3*)val longest2 = longest_string2 ["asd4","Abcd5","abcde6","head####","tail####"]

(*4*)val longest3 = longest_string3 ["asd4","Abcd5","abcde6","head####","tail####"]
(*4*)val longest4 = longest_string4 ["asd4","Abcd5","abcde6","head####","tail####"]

(*5*)val longest_capitalized1 = longest_capitalized ["asd4","Abcd5","Acde6","Head####","Tail####"]
(*5*)val longest_capitalized2 = longest_capitalized ["asd4","Abcd5","Acde6","Head####","Tail#####"]
(*6*)val olleh = rev_string ("hello")
(*6*)val complex_str = rev_string ("\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")


(*7*)
fun first_answer f xs = 
    case xs of
	[] => raise NoAnswer
     | x::xs' => case f x of
		     SOME v => v
		   | NONE => first_answer f xs'

(* 8 *)
fun all_answers f xs =
    let
	fun helper (acc,ys) =
	    case ys of
		[] => []
	      | (SOME y)::[] => acc@y
	      | (SOME y)::ys' => helper(acc@y,ys')
	val ys = List.map f xs
    in
	if List.exists (fn y => not (isSome y)) ys then NONE else SOME (helper ([],ys))
    end



(* 9 *)
(* a *)
val count_wildcards = g (fn () => 1) (fn s => 0)
(* b *)
val count_wild_and_variable_lengths = g (fn () => 1) (fn s => String.size s)
(* c *)
fun count_some_var (s,p) = g (fn () => 0) (fn s' => if s=s' then 1 else 0) p

(*9*)
val three = count_wildcards (TupleP [Wildcard,Wildcard,TupleP([Wildcard])])
val nine = count_wild_and_variable_lengths (TupleP [Wildcard,Wildcard,Variable "fengvar"])
val two = count_some_var ("feng", TupleP [Variable "feng", Variable "xiao", Variable "feng"])

(* 10 *)
fun check_pat p = 
    let
	fun get_var_strings (p,var_strs) = 
	    case p of 
		Variable x => x::var_strs
	      | TupleP xs => List.foldl (fn (x,xs) => get_var_strings(x,[]) @ xs) var_strs xs
	      | _ => var_strs
	fun has_duplicate str_list = 
	    case str_list of
		[] => false
	      | x::xs' => (List.exists (fn s => s=x) xs') orelse has_duplicate xs'
    in
	not (has_duplicate (get_var_strings (p, [])))
    end

(*10*)
val check_pat_false = check_pat (TupleP [Variable "feng", Variable "xiao", TupleP [Variable "feng", Variable "chun"]])
val check_pat_true = check_pat (TupleP [Variable "feng", Variable "xiao", TupleP [Variable "fei", Variable "chun"]])
val check_pat_false1 = check_pat (TupleP[Variable "x",Variable "x"])
val check_pat_true1 = check_pat (TupleP[Variable "x",ConstructorP ("wild",Wildcard)])
(* 11 *)
fun match (v, p) = 
    case (v,p) of
	(v,ConstP i) => (case v of
			     Const j => if i=j then SOME [] else NONE
			   | _ => NONE)
      | (v, UnitP) => (case v of 
			   Unit => SOME []
			 | _ => NONE)
      | (v, ConstructorP(s',p)) => (case v of  
					Constructor(s,v') => if s=s' then match(v',p) else NONE
				      | _ => NONE)
      | (Const i, Variable v) => SOME [(v,Const i)]
      | (Tuple t, Variable v) => SOME [(v,Tuple t)]
      | (_, Variable v) => NONE
      | (t, TupleP p) => (case t of
			     Tuple t => if List.length(t)=List.length(p) then all_answers (fn (v,p) => match(v,p)) (ListPair.zip (t,p)) else NONE
			   | _ => NONE)
      | (_,Wildcard) => SOME []


(*11*) 
val val_bind1 = match(Const 1, ConstP 1)
val val_bind2 = match(Const 1, ConstP 2)
val val_bind3 = match(Const 1, Variable "var")
val val_bind4 = match(Tuple [Const 1, Unit, Const 2], TupleP [Variable "var1", UnitP, Variable "var2"])
val val_bind5 = match(Tuple [Const 1, Unit, Const 3], TupleP [Variable "var1", UnitP, ConstP 2])
val val_bind6 = match(Tuple [Const 1, Unit, Tuple [Const 2, Const 3]], TupleP [Variable "var1", UnitP, TupleP [Variable "var2", ConstP 3]])
val val_bind7 = match (Unit,Wildcard)
val val_bind8 = match  (Constructor ("egg",Constructor ("egg",Const 4)),ConstructorP ("egg",ConstP 4))(*NONE*)
val val_bind9 = match (Tuple[Const 17,Unit,Const 4,Constructor ("egg",Const 4),Constructor ("egg",Constructor ("egg",Const 4))], 
		       TupleP[Wildcard,Wildcard])(*NONE*)
(* 12 *)
fun first_match v ps =
    SOME ((first_answer (fn p => match(v,p)) ps))  handle NoAnswer => NONE

(*12*)
val first_match1 = first_match (Const 1) [
				  ConstP 2,
				  Variable "var1",
				  Variable "var2"
			      ]
val first_match2 = first_match (Const 1) [
				  ConstP 2
			      ]
