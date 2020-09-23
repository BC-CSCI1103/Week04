(* file: stripes.ml
 * author: Bob Muller
 *
 * CSCI 1103 Computer Science 1 Honors
 *
 * An example using the Animate library with repetition.
   This particular example draws randomly colored rings.

   Run:
   > cd src
   > dune exec bin/main.exe
 *)
let displayWidth = 800.
let displayHeight = displayWidth
let half = displayWidth /. 2.0

(* A fresh set of random numbers each time
*)
let () = Random.self_init ()

(* Make an empty image
*)
let empty = Image.empty displayWidth displayHeight

type model = int * Image.t
let initialModel = (100, empty)

(* ring : unit -> Image.t *)
let ring () =
  let radius = Random.float half in
  let width = Random.float radius in
  let color = Color.random () in
  let outer = Image.circle radius color in
  let inner = Image.circle (radius -. width) Color.white
  in
  Image.placeImage inner (width, width) outer

(* rings : int -> Image.t -> Image.t *)
let rec rings n background =
  match n = 0 with
  | true  -> background
  | false ->
    let x = (Random.float displayWidth) -. half in
    let y = (Random.float displayWidth) -. half
    in
    rings (n - 1) (Image.placeImage (ring ()) (x, y) background)

(* finished : model -> bool *)
let finished (n, _) = n = 0

(* view : model -> Image.t *)
let view (n, image) = image

(* view : model -> model *)
let update (n, image) = (n - 1, rings 1 image)

let _ = Animate.start initialModel
		       ~name:   "Ring Demo2"
		       ~width:  displayWidth
           ~height: displayHeight
           ~onTick: update
		       ~view:   view
           ~rate:   0.1
           ~stopWhen: finished
		       ~viewLast: view
