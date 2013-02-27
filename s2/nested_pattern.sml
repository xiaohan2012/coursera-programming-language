exception ListLengthMismatch (*more on this later*)
(*patterns can be nested*)
(*
([1,2,3],[4,5,6],[7,8,9]) -> [(1,4,7), (2,5,8), (3,6,9)]
*)
fun zip3 three_lists = 
    case three_lists of
	([],[],[]) => []
      | (hd1::tl1, hd2::tl2, hd3::tl3)  =>  (hd1,hd2,hd3) :: zip3 (tl1,tl2,tl3)
      | _ => raise ListLengthMismatch

val triple_list = zip3 ([1,2,3],[4,5,6],[7,8,9]);

(*
[(1,4,7), (2,5,8), (3,6,9)] -> ([1,2,3] , [4,5,6] , [7,8,9])
*)
fun unzip3 triple_list = 
    case triple_list of
	[] => ([],[],[])
      | (hd1,hd2,hd3) :: tl => 
	let
	    val (tl1,tl2,tl3) = unzip3(tl);
	in
	    (hd1 :: tl1, hd2 :: tl2, hd3 :: tl3)
	end
(*      
| _  => raise ListLengthMismatch 
 (*this should fail *)
*)

val lists = unzip3 [(1,4,7), (3,5,8), (3,6,9)];

