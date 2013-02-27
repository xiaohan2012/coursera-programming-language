fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(goal : string, lst : string list) = 
    case lst of
	[] => NONE
      | hd :: [] => if same_string(goal,hd) then SOME [] else NONE
      | hd :: tl  => case (all_except_option(goal,tl),same_string(hd,goal)) of
			 (NONE,true) => SOME tl
		       | (SOME [],true) => SOME []
		       | (NONE,false) => NONE
		       | (SOME rest,false) => SOME (hd :: rest)



val all_opt_t1 = all_except_option("xiao",["feng","xiao","chun","fei"]) (*SOME ["feng","chun","fei
]*)
val all_opt_t2 = all_except_option("xiao",["feng","chun","xiao"]) (* SOME ["feng","chun"]*)
val all_opt_t3 = all_except_option("feng",[]) (*NONE*)
val all_opt_t4 = all_except_option("feng",["feng"])(*SOME []*)
val all_opt_t5 = all_except_option("feng",["xiao","chun","fei"]) (*NONE*)

fun get_substitutions1 (subs : string list list, s : string)=
    case subs of
	[] => []
      | hd :: [] => (case all_except_option (s, hd) of
			       NONE => []
			     | SOME lst => lst)
      | hd :: tl => (case all_except_option (s, hd) of
				 NONE => get_substitutions1 (tl,s)
			       | SOME lst => lst @ get_substitutions1 (tl,s))

val gsub_t1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") (* ["Fredrick","Freddie","F"] *)
val gsub_t2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") (* ["Jeffrey","Geoff","Jeffrey"] *)



fun get_substitutions2 (subs : string list list, s : string) =
    let
	fun aux (rest, acc) = 
	    case rest of
		[] => acc
	      | hd::[] => (case all_except_option(s, hd) of
				NONE => acc
			      | SOME lst => acc @ lst)
	      | hd::tl => (case all_except_option(s, hd) of
			      NONE => aux(tl, acc)
			   |  SOME lst => aux(tl, acc @ lst))
    in
	aux (subs,[])
    end

val gsub2_t1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") (* ["Fredrick","Freddie","F"] *)
val gsub2_t2 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") (* ["Jeffrey","Geoff","Jeffrey"] *)

fun similar_names (subs : string list list, 
		   full_name : {first:string,middle:string,last:string}) = 
    let 
	val {first = first_name, middle =  middle_name, last = last_name} = full_name
	val first_names = get_substitutions2 (subs, first_name)

	fun cat_names (first_names : string list) = 
	    case first_names of
		[] => []
	      | hd::[] => [{first=hd, middle=middle_name, last=last_name}]
	      | hd::tl => {first=hd, middle=middle_name, last=last_name} :: cat_names (tl)
    in
	full_name :: cat_names (first_names)
    end

val similar_t1 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],{first="Fred", middle="W", last="Smith"})

(* answer: [{first="Fred", last="Smith", middle="W"},
{first="Fredrick", last="Smith", middle="W"},
{first="Freddie", last="Smith", middle="W"},
{first="F", last="Smith", middle="W"}] *)

