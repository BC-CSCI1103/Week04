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
let half = displayWidth /. 2.0

(* A fresh set of rings each time
*)
let () = Random.self_init ()

type model = unit
let initialModel = ()

(* Make the background
*)
let empty = Image.empty displayWidth displayHeight

(* ring : unit -> Image.t *)
let ring () =
  let radius = Random.float half in
  let width = Random.float radius in
  let color = Color.random () in
  let outer = Image.circle radius color in
  let inner = Image.circle (radius -. width) Color.white
  in
  Image.placeImage inner (width, width) outer

(* addRings : int -> Image.t -> Image.t *)
let rec addRings n background =
  match n = 0 with
  | true  -> background
  | false ->
    let x = (Random.float displayWidth) -. half in
    let y = (Random.float displayWidth) -. half
    in
    addRings (n - 1) (Image.placeImage (ring ()) (x, y) background)

(* finished : model -> bool *)
let finished () = true     (* draw exactly once *)

(* view : model -> Image.t *)
let view () = addRings 100 empty

let _ = Animate.start initialModel
		       ~name:"Static Ring Demo"
		       ~width:displayWidth
           ~height:displayHeight
           ~stopWhen:finished
		       ~viewLast:view
