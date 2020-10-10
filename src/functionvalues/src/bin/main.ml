(* CSCI 1103 Computer Science 1 Honors
   Robert Muller

   Several functions relating to function values.
*)

(* Example *)
let ns = [0; 1; 2; 3]
let isOdd n = n mod 2 = 1

(* map : ('a -> 'b) -> 'a list -> 'b list *)
let rec map f xs =
  match xs with
  | [] -> []
  | y :: ys -> (f y) :: (map f ys)

(* (map isOdd ns) ==> [false; true; false; true] *)

(* forall : ('a -> bool) -> 'a list -> bool *)
let rec forall test xs =
  match xs with
  | [] -> true
  | x :: xs -> (test x) && (forall test xs)

(* (forall isOdd ns) ==> false *)

(* exists : ('a -> bool) -> 'a list -> bool *)
let rec exists test xs =
  match xs with
  | [] -> false
  | x :: xs -> (test x) || (exists test xs)

(* (exists isOdd ns) ==> true *)

(* filter : ('a -> bool) -> 'a list -> 'a list *)
let rec filter test xs =
  match xs with
  | [] -> []
  | x :: xs ->
    let rest = filter test xs
    in
    (match test x with
     | true -> x :: rest
     | false -> rest)

(* (filter isOdd ns) ==> [1; 3] *)

(* fold : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b *)
let rec fold f xs id =
  match xs with
  | [] -> id
  | x :: xs -> f x (fold f xs id)

(* (fold (+) ns 0) ==> 6 *)


(**** Functions on floating point numbers and their Curves ************)

(* slope : (float -> float) -> (float -> (float -> float)) *)
let slope f dx x =
  let rise = (f (x +. dx)) -. (f x)
  in
  rise /. dx

(* square : float -> float *)
let square n = n ** 2.0

(* square' : float -> float
   square' is an approximation of the derivative of square. *)
let square' = slope square 1e-10

(* val leftRiemann : (float -> float) -> float -> float -> int -> float

   The call (leftRieman f a b n) divides the area between a and b
   into n equal intervals. It returns the sum of the areas of those
   rectangles thereby approximating the area under the curve.

   NB: As n grows larger the rectangles become narrower and the
   approximation is closer to the definite integral of f between
   a and b.
*)
let leftRiemann f a b n =
  let dx = (b -. a) /. (float n) in
  let rec repeat c acc =
    match (Lib.closeEnough c b) with
    | true  -> acc
    | false ->
      let height = f c
      in
      repeat (c +. dx) (acc +. height)
  in
  dx *. (repeat a 0.0)

(************* Anonymous Functions **************)

(* multiply : int -> int -> int *)
let multiply m n = m * n
let multiply = (fun m -> (fun n -> m * n))

(* multiply : int * int -> int *)
let multiply (m, n) = m * n
let multiply = (fun (m, n) -> m * n)
