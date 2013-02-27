fun swap( pr : int * bool) = 
    (#2 pr , #1 pr)

fun vec_add(pr1 : int * int, pr2 : int * int) = 
    ((#1 pr1) + (#1 pr2),(#2 pr1) + (#2 pr2))

fun sort(pr : int * int)=
    if #1 pr < #2 pr
    then pr
    else (#2 pr, #1 pr)

fun div_mod(pr : int * int) =
    (#1 pr div #2 pr, #1 pr mod #2 pr)
