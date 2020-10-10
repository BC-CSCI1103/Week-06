
(* CSCI 1103 Computer Science 1 Honors
   Robert Muller

   A simple assocation list implementation of dictionaries.
*)

type key = string
type 'a dictionary = (key * 'a) list

(* empty : dictionary *)
let empty = []

(* add : key -> 'a -> 'a dictionary -> 'a dictionary *)
let add key value dictionary = (key, value) :: dictionary

(* find: key -> 'a dictionary -> 'a

   The call (find key dictionary) finds the value of key in
   dictionary if it exists. If the key is not in the dictionary,
   find uses failwith to throw a run-time exception.
*)
let rec find searchKey dictionary =
  match dictionary with
  | [] -> failwith "find: the key is not in the dictionary"
  | (key, value) :: dictionary ->
    (match searchKey = key with
     | true  -> value
     | false -> find searchKey dictionary)

let example = add "Alice" 100 (add "Bob" 200 empty)

(**************************************************)

(* find: key -> 'a dictionary -> 'a option

   The call (find key dictionary) finds the value of key in
   dictionary if it exists. If the key is not in the dictionary,
   find returns the variant None of the 'b option type.
*)
let rec find searchKey dictionary =
  match dictionary with
  | [] -> None
  | (key, value) :: dictionary ->
    (match searchKey = key with
     | true  -> Some value
     | false -> find key dictionary)

(* getValues : key list -> 'a dictionary -> 'a list *)
let rec getValues keys dictionary =
  match keys with
  | [] -> []
  | key :: keys ->
    (match find key dictionary with
     | None       -> getValues keys dictionary
     | Some value -> value :: getValues keys dictionary)
