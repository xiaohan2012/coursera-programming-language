
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

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

fun only_capitals strings = 
    List.filter(fn s => Char.isUpper (String.sub (s, 0))) strings

fun longest_string1 strs =
    foldl (fn (s,t)=> if  String.size s > String.size t then s else t) "" strs

fun longest_string2 strs =
    foldl (fn (s,t)=> if  String.size s >= String.size t then s else t) "" strs

fun longest_string_helper f strs = foldl (fn (s,t)=>if f( String.size s, String.size t) then s else t) "" strs

val longest_string3 = longest_string_helper (fn (x,y)=> x>y) 

val longest_string4 = longest_string_helper (fn (x,y)=> x>=y) 

val longest_capitalised = longest_string3 o only_capitals 

val rev_string = String.implode o rev o String.explode 

fun first_answer f lst = 
    case lst of
	[] => raise NoAnswer
      | l::ls => case f l of
		     SOME v => v 
		   | NONE => first_answer f ls  

fun all_answers f alst =
    let fun h (x, acc) =	    
	    case x of
		[] => acc
	      | l::ls => case f l of
			     NONE => raise NoAnswer
			   | SOME lst => h (ls, lst @ acc)
    in
	SOME (h(alst,[]))
	handle NoAnswer => NONE
    end


val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size x)

fun count_some_var (s,p) =
    g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p =
	let fun all_strings p =
		case p of
		    Variable x        => x::[]
		  | TupleP ps         => foldl (fn (p,acc) => (all_strings p) @ acc) [] ps
		  | ConstructorP(_,p) => all_strings p
		  | _                 => []
	    val l = all_strings p
	    fun h l =
		case l of
		    [] => false
		   |y::ys => List.exists (fn z => y=z ) ys orelse h ys
	in
	   not (h l)  
	end

fun match (v,p) =
    case (v,p) of
	(_,Wildcard) => SOME []
      | (v,Variable s) => SOME [(s,v)]
      | (Unit,UnitP) => SOME []
      | (Const i1,ConstP i2) => if i1=i2 then SOME[] else NONE
      | (Tuple vs,TupleP ps) => if length vs = length ps 
				then let val vp = ListPair.zip (vs,ps)
				     in 
					 all_answers (fn (m,n) => match(m,n)) vp 	     	
				     end
				else NONE
      | (Constructor(s2,v),ConstructorP(s1,p)) => if s1=s2 then match(v,p) else NONE
      | _ => NONE


fun first_match v ps = 
    let fun new_match q w = match (q,w)
    in
	SOME (first_answer (new_match v) ps)  
	handle NoAnswer => NONE
    end







