fun is_older(pr:int*int*int,pr2:int*int*int)=
    if(#1 pr) > (#1 pr2)
		     then true
    else if(#2 pr)>(#2 pr2)
		        then true
    else if(#3 pr)>(#3 pr2)
		        then true
    else false

fun number_in_month(dates:(int*int*int) list,month: int)=
    if null dates then 0
	else if (#2( hd dates)) = month then 1+number_in_month(tl dates,month)
		else number_in_month(tl dates,month)

				    
fun number_in_months(dates:(int*int*int) list, month: int list)=
    if null dates then 0
    else if null month then 0
	else number_in_month(dates, hd month)+number_in_months(dates,tl month)

fun dates_in_month(dates:(int*int*int) list , month : int ) =
    if null dates then []
	else if ( #2 (hd dates)) = month then hd dates::dates_in_month(tl dates,month)
		else dates_in_month(tl dates,month)

		
fun dates_in_months(dates:(int*int*int) list, months: int list)=
	if null dates then []
		else if null months then []
	else dates_in_month(dates, hd months)::dates_in_months(dates, tl months)

fun get_nth(stList:string list,n:int)= 
 if null stList then "notFound"
	else if n = 1 then hd stList
	   else get_nth(tl stList,n-1)

val x =["January","February", "March", "April",
"May", "June", "July", "August", "September", "October", "November", "December"];

fun date_to_string( date:(int*int*int))=
	if #2 date >12 then "notValid"
		else  ((get_nth(x, #2 date))^" "^(Int.toString(#3 date)^", "^(Int.toString(#1 date))))
val count = 0

fun number_before_reaching_sum(sum:int,myList:int list)=
if null myList then 0
  else if sum < hd myList andalso sum > (hd myList+(hd (tl myList))) then 0
		else (number_before_reaching_sum((sum-hd myList),tl myList)+1)

val y = [31,28,31,30,31,30,31,31,30,31,30,31];

fun what_month(day:int)=
    if day >365 then 0
	else number_before_reaching_sum(day,y)

fun month_range(day1:int , day2:int)=
   if day2 > day1 then []
	else what_month(day1)::month_range(day1+1,day2)
