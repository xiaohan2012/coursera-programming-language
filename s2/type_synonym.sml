
datatype suit = Spade | Heart | Clubs | Diamond;
datatype rank = Jack | Queen | King | Ace | Num of int;

(* by using 
type synonym_type = exsited_type, we create another name for the exsited_type.

synonym_type and existed_type are the same, except their names
*)
type card = suit * rank;

type student = {
    id : int option,
    first_name : string,
    middle_name : string option,
    last_name : string
};

fun is_Diamond_Jack( c : card) = (*(c) or (c : suit*rank) is both ok*)
    (#1 c) = Diamond andalso (#2 c) = Jack

val c1 = (Diamond, Queen);
is_Diamond_Jack(c1);
val c2 : card = (Spade, Jack);
is_Diamond_Jack(c2);
val c3 : suit * rank = (Diamond, Jack);
is_Diamond_Jack(c3);

