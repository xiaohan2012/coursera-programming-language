fun pow(x : int, y : int) = 
    if y = 0
    then 1
    else x * pow(x,y-1)

fun cube(x : int) = 
    pow(x,3)

val eight = cube(2)
val eight = cube 2

val eight = pow(2,3)

val xy = (2,3)
val eight = pow xy
