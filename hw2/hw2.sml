(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
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

fun get_substitutions1 (subs : string list list, s : string)=
    case subs of
	[] => []
      | hd :: [] => (case all_except_option (s, hd) of
			       NONE => []
			     | SOME lst => lst)
      | hd :: tl => (case all_except_option (s, hd) of
				 NONE => get_substitutions1 (tl,s)
			       | SOME lst => lst @ get_substitutions1 (tl,s))


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



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove
exception CardNotInList

(* put your solutions for problem 2 here *)

fun card_color (c:card) = 
    case c of
	(Clubs,_) => Black
      | (Spades,_) => Black
      | _  => Red

fun card_value (c:card) = 
    case c of
	(_,Num x) => x
      | (_,Ace) => 11
      | _ => 10

fun remove_card (cs : card list, c : card, e) = 
    let 
	fun rev (cards) = 
	    let 
		fun revaux (rest, acc) = 
		    case rest of
			[] => acc
		      | hd::[] => hd::acc
		      | hd::tl => revaux(tl,hd::acc)
	    in
		revaux(cards,[])
	    end
		
	fun aux(rest, acc)=
	    case rest of
		[] => raise e
	      | hd::[] => if hd=c then acc else raise e
	      | hd::tl => if hd=c then tl @ acc else aux(tl, hd :: acc)
    in 
	rev(aux(cs,[]))
    end

fun all_same_color(cards : card list) = 
    case cards of
	[] => true
      | _::[] => true
      | first::last::[] => (card_color first) = (card_color last)
      | first::(second::rest) => (card_color first) = (card_color second) andalso all_same_color(second::rest)

fun sum_cards (cards : card list) = 
    let
	fun aux(rest, sum_val) = 
	    case rest of
		[] => 0
	      | hd::[] => (card_value hd) + sum_val
	      | hd::tl => aux(tl, (card_value hd) + sum_val)
    in
	aux (cards,0)
    end

fun score(cards : card list, goal : int)=
    let
	val sum = sum_cards cards
	val pre_score = (if sum > goal then 3*(sum-goal) else goal-sum)
    in
	if all_same_color(cards) then pre_score div 2 else pre_score
    end

fun officiate(cards : card list, moves : move list, goal : int) = 
    let
	fun act(rest_cards : card list, held_cards : card list, moves : move list) = 
	    case (rest_cards, held_cards, moves) of
		(*no moves at all -> game ends*)
		(_,_,[]) => score(held_cards, goal)

	      (*no drawable cards left -> game ends *)
	      | ([], _ , Draw::_) => score(held_cards, goal)
				
	      (*discad card and no move afterwards -> game ends*)
	      | (rest_cards, held_cards, Discard c::[]) => score (remove_card(held_cards, c, CardNotInList) handle CardNotInList  => raise IllegalMove, goal)

	      (*draw card and no move afterwards -> game ends*)
	      | (card_on_top::_, held_cards, Draw::[]) => score(card_on_top::held_cards, goal) 
				      
	      (*discard card -> game continues*)
	      | (rest_cards, held_cards, Discard c::moves) => (act(rest_cards, 
								   remove_card(held_cards, c, CardNotInList), moves)  
							       handle  CardNotInList => raise IllegalMove)
	      (*draw card -> game continues*)
	      | (rest_cards, held_cards, Draw::moves)  =>  
		let
		    val card_on_top::_ = rest_cards
		    val pre_score = score(card_on_top::held_cards, goal)
		in
		    if( pre_score>goal) then pre_score else act(remove_card(rest_cards, card_on_top, CardNotInList), 
								card_on_top::held_cards,moves)
		end
    in	
	act(cards, [], moves)
    end
