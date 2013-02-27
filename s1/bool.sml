(*
andalso and orelse are operators
but `not` is a function

- not;
val it = fn : bool -> bool
*) 

(* 
as a matter of fact, the andalso, orelse and not are not necessary in a programming language,
because they can be subsitute equally using  if...then...else
for example, andalso can be expressed using
if e1
then e2
else false

or orelse

if e1
then true
else e2

or not
if e1
then false
else false
*)


(*
Comparison operator
*)

(*
=  <> < > <= >=

< > <= and >= can be used on almost every types, including real
but the two operands on both sides of the operators should be of the same type.

Like, we cannot compare an int with an real, like 2.3 < 3

Also, = and <> cannot be used with real, because float point number subject to round-off error and we may once say the difference between two float numbers are within a certain range.
*)
