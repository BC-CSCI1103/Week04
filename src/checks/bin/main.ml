(* file: checks.ml
 * author: Bob Muller
 *
 * CSCI 1103 Computer Science 1 Honors
 *
 * An example using the Animation library with repetition.
   This particular example draws a checkerboard.

   Run:
   > cd src
   > dune exec bin/main.exe
*)
let displayWidth = 800.
let displayHeight = displayWidth

(* Make exactly one empty scene
*)
let empty = Image.empty displayWidth displayHeight

(* makeCheck : int -> float -> Image.t

 The call (makeCheck n side) returns a square that is black if n is
   even and Color.dodgerBlue if n is odd.
 *)
let makeCheck n side =
  match n mod 2 = 0 with
  | true  -> Image.rectangle side side Color.black
  | false -> Image.rectangle side side Color.dodgerBlue

(* addColumnOfChecks : int -> float -> int -> Image.t -> Image.t

 The call (addColumnOfChecks col side n img) returns the image
 obtained from img by attaching a column of alternately colored
 checks in column col.
*)
let addColumnOfChecks col side n image =
  let x = side *. (float (col - 1)) in
  let emptyColumn = Image.empty side displayHeight in
  let rec addChecks row image =
    match row = 0 with
    | true  -> image
    | false ->
      let y = side *. (float (row - 1)) in
	    let check = makeCheck (row + col) side in
	    let newImage = Image.placeImage check (0., y) image
	    in
	    addChecks (row - 1) newImage in
  let newColumn = addChecks n emptyColumn
  in
  Image.placeImage newColumn (x, 0.) image

(* checks : int -> Image.t

 The call (checks n) returns an n x n checkerboard.
 *)
let checks n =
  let side = displayWidth /. (float n) in
  let rec addColumns col image =
    match col = 0 with
    | true  -> image
    | false ->
      let newImage = addColumnOfChecks col side n image
	    in
	    addColumns (col - 1) newImage
  in
  addColumns n empty

let finished _ = true     (* draw exactly once *)
let finished _ = false    (* draw ad infinitum *)

(* view : 'a -> Image.t   this version for demo of addStripe
 *)
let view _ = checks (1 + Random.int 8)

let _ = Animate.start ()
		       ~name:"Checks Demo"
		       ~width:displayWidth
		       ~height:displayHeight
		       ~stopWhen:finished
		       ~view:view
           ~viewLast:view
