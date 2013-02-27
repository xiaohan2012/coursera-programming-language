(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color (c:card) = 
    case c of
	(Clubs,_) => Black
      | (Spades,_) => Black
      | _  => Red

val color1 = card_color (Clubs,Jack) (*Black*)
val color2 = card_color (Diamonds, Queen) (*Red*)

fun card_value (c:card) = 
    case c of
	(_,Num x) => x
      | (_,Ace) => 11
      | _ => 10

val card_val1 = card_value (Clubs, Num 2) (*2*)
val card_val2 = card_value (Clubs, Ace) (*11*)
val card_val3 = card_value (Clubs, King) (*10*)



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
		[] => raise (e c)
	      | hd::[] => if hd=c then acc else raise (e c)
	      | hd::tl => if hd=c then tl @ acc else aux(tl, hd :: acc)
    in 
	rev(aux(cs,[]))
    end

exception CardNotInList of card
val cards1 = [(Clubs,Num 2), (Clubs, Ace), (Clubs, King)]
val cards2 = [(Clubs,Num 2), (Spades, King), (Clubs, Ace), (Clubs, Ace)]
val cards3 = [(Clubs, Ace)]
val cards4 = [(Clubs, Jack)]
val card = (Clubs, Ace)

(*anwser:[(Clubs,Num 2), (Clubs, King)]*)
val removed_cardlist1 = remove_card(cards1, card, CardNotInList)

(*answer: [(Clubs,Num 2), (Spades, King), (Clubs, Ace)]*)
val removed_cardlist2 = remove_card(cards2, card, CardNotInList)

(*answer: []*)
val removed_cardlist3 = remove_card(cards3, card, CardNotInList)

(*answer: []*)
val removed4 = remove_card(cards4, card, CardNotInList) handle CardNotInList c => []

fun all_same_color(cards : card list) = 
    case cards of
	[] => true
      | _::[] => true
      | first::last::[] => (card_color first) = (card_color last)
      | first::(second::rest) => (card_color first) = (card_color second) andalso all_same_color(second::rest)

val cards1 = [(Clubs,Num 2)]
val cards2 = [(Clubs,Num 2), (Clubs, Ace), (Clubs, King)]
val cards3 = [(Clubs,Num 2), (Spades, King), (Clubs, Ace)]
val cards4 = [(Clubs,Num 2), (Spades, King), (Diamonds, Ace)]

val same1 = all_same_color(cards1)(*true*)
val same2 = all_same_color(cards2)(*true*)
val same3 = all_same_color(cards3)(*true*)
val same4 = all_same_color(cards4)(*false*)

	     
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

val cards1 = [(Clubs,Num 2)]
val cards2 = [(Clubs,Num 2), (Clubs, Num 3), (Clubs, King)]
val cards3 = [(Clubs,Num 2), (Spades,Num 3), (Clubs, Ace)]

val sum1 = sum_cards(cards1)(*2*)
val sum2 = sum_cards(cards2)(*15*)
val sum3 = sum_cards(cards3)(*16*)

fun score(cards : card list, goal : int)=
    let
	val sum = sum_cards cards
	val pre_score = (if sum > goal then 3*(sum-goal) else goal-sum)
    in
	if all_same_color(cards) then pre_score div 2 else pre_score
    end

(*
val goal = 16
val cards1 = [(Clubs,Num 2), (Spades,Num 6), (Clubs, Ace)](*same color, sum 19*)
val cards2 = [(Clubs,Num 2), (Spades,Num 3), (Clubs, Jack)](*same color, sum 15*)
val cards3 = [(Clubs,Num 2), (Spades,Num 6), (Diamonds, Ace)](*different color, sum 19*)
val cards4 = [(Clubs,Num 2), (Spades,Num 3), (Diamonds, Jack)](*different color, sum 15*)

val score1 = score(cards1, goal)(*4*)
val score2 = score(cards2, goal)(*1*)
val score3 = score(cards3, goal)(*9*)
val score4 = score(cards4, goal)(*1*)
*)

fun officiate(cards : card list, moves : move list, goal : int) = 
    let
	fun act(rest_cards : card list, held_cards : card list, moves : move list) = 
	    case (rest_cards, held_cards, moves) of
		(*no moves at all -> game ends*)
		(_,_,[]) => score(held_cards, goal)

	      (*no drawable cards left -> game ends *)
	      | ([], _ , Draw::_) => score(held_cards, goal)
				
	      (*discad card and no move afterwards -> game ends*)
	      | (rest_cards, held_cards, Discard c::[]) => score (remove_card(held_cards, c, CardNotInList) handle CardNotInList c => raise IllegalMove, goal)

	      (*draw card and no move afterwards -> game ends*)
	      | (card_on_top::_, held_cards, Draw::[]) => score(card_on_top::held_cards, goal) 
				      
	      (*discard card -> game continues*)
	      | (rest_cards, held_cards, Discard c::moves) => (act(rest_cards, 
								   remove_card(held_cards, c, CardNotInList), moves)  
							       handle  CardNotInList c => raise IllegalMove)
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

val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
val moves = [Draw,Draw,Draw,Draw,Draw](*insufficient cards *)
val score1 = officiate(cards,moves,42)(*should be 3*)

val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Clubs,Num 1)]
val moves = [Draw,Draw,Draw,Draw](*there are cards left + same color*)
val score2 = officiate(cards,moves,42)(*should be 4*)

val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace),(Diamonds,Num 1)]
val moves = [Draw,Draw,Draw,Draw](*there are cards left + different colors*)
val score3 = officiate(cards,moves,42)(*should be 8*)
