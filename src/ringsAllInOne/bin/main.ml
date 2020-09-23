(* file: main.ml
 * author: Bob Muller
 *
 * CSCI 1103 Computer Science 1 Honors
 *
 * An example using the Animate library with repetition.
   This particular example draws random rings.
   Run:
   > cd src
   > dune exec bin/main.exe
 *)
let displayWidth = 800.
let displayHeight = displayWidth

let () = Random.self_init ()

(* Make exactly one empty scene
*)
let empty = Image.empty displayWidth displayHeight

let ring () =
  let radius = Random.float (displayWidth /. 2.0) in
  let width = Random.float radius in
  let color = Color.random () in
  let outer = Image.circle radius color in
  let inner = Image.circle (radius -. width) Color.white
  in
  Image.placeImage inner (width, width) outer

let rec addRings n background =
  match n = 0 with
  | true  -> background
  | false ->
    let x = (Random.float displayWidth) -. displayWidth /. 2.0 in
    let y = (Random.float displayWidth) -. displayWidth /. 2.0
    in
    addRings (n - 1) (Image.placeImage (ring ()) (x, y) background)

let finished _ = true     (* draw exactly once *)

(* view : 'a -> Image.t   this version for demo of addStripe
 *)
let view () = addRings 100 empty

let _ = Animate.start ()
		       ~name:"Static Ring Demo"
		       ~width:displayWidth
           ~height:displayHeight
           ~stopWhen:finished
		       ~viewLast:view
