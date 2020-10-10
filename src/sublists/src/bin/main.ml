
(* CSCI 1103 Computer Science 1 Honors
   Robert Muller

   The essence of recursion: assume that the recursive call on the slightly
   smaller problem returns a complete solution to the smaller problem.
   To finish the function, you just have to figure out how to get from
   there to the answer.

   sublists: 'a list -> ('a list) list

   (sublists [8; 10; 2] ==>
     [[]; [2]; [10]; [8]; [10; 8]; [2; 8]; [10; 2]; [10; 8; 2]]
*)

(* addToAll 'a -> ('a list) list -> ('a list) list *)
let rec addToAll x xxs =
  match xxs with
  | [] -> []
  | xs :: xxs -> (x :: xs) :: (addToAll x xxs)

(* sublists : 'a list -> ('a list) list *)
let rec sublists xs =
  match xs with
  | [] -> [[]]
  | y :: ys ->
    let halfway = sublists ys  (* halfway has all the sublists of ys. *)
    in
    halfway @ (addToAll y halfway)

(* A slightly cleaner version using List.map and an anonymous function.
*)
let rec sublists xs =
  match xs with
  | [] -> [[]]
  | x :: xs ->
    let halfway = sublists xs
    in
    halfway @ (List.map (fun zs -> x :: zs) halfway)
