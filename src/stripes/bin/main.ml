(* file: stripes.ml
 * author: Bob Muller
 *
 * CSCI 1103 Computer Science 1 Honors
 *
 * An example using the Universe library with repetition.
   This particular example draws randomly colored stripes.

   Run:
   > cd src
   > dune exec bin/main.exe
 *)
let displayWidth = 800.
let displayHeight = displayWidth

(* Make exactly one empty scene
*)
let empty = Image.empty displayWidth displayHeight

(* stripe0 : unit -> Image.t

 The call (stripe0 ()) returns an image with a randomly colored vertical
 stripe on the right side.
*)
let stripe0 () =
  let x = displayWidth /. 4. in
  let width = displayWidth /. 2. in
  let color = Color.random() in
  let stripe = Image.rectangle width displayHeight color
  in
  Image.placeImage stripe (x, 0.) empty

(* stripe1 : int -> int -> Image.t

 The call (stripe1 x width) returns an image with a randomly colored
 vertical stripe of the given width with upper left corner at the given
 x. NB: stripe1 is obtained from stripe0 by abstracting with respect to
 both x and width.
*)
let stripe1 x width =
  let color  = Color.random() in
  let stripe = Image.rectangle width displayHeight color
  in
  Image.placeImage stripe (x, 0.) empty

(* addStripe : float -> float -> Image.t -> Image.t

 The call (addStripe x width img) returns the image obtained from img
 by dropping a randomly colored vertical stripe of the given width
 with upper left corner at the given x.
 NB: addStripe is obtained from stripe1 by abstracting with respect
 to the image on which the stripe is placed.
 *)
let addStripe x width image =
  let color = Color.random() in
  let stripe = Image.rectangle width displayHeight color
  in
  Image.placeImage stripe (x, 0.) image

(* stripes : int -> Image.t

 The call (stripes n) returns an image with n randomly colored vertical
 stripes.
*)
let stripes n =
  let width = displayWidth /. (float n) in
  let empty = Image.empty displayWidth displayHeight in
  let rec addStripes m image =
    match m = 0 with
    | true  -> image
    | false ->
      let x = float (m - 1) *. width in
	    let newImage = addStripe x width image
	    in
	    addStripes (m - 1) newImage
  in
  addStripes n empty

let finished _ = true     (* draw exactly once *)
let finished _ = false    (* draw ad infinitum *)

(* view : 'a -> Image.t   this version for demo of addStripe
 *)
let view _ =
  let x = displayWidth /. 2. in
  let width = (displayWidth /. 2.) in
  let empty = Image.empty displayWidth displayHeight in
  let firstImage = addStripe x width empty
  in
  addStripe 0. width firstImage

let view = stripe0
(* view : 'a -> Image.t   this version for demo of stripes
*)
let view _ = stripes (1 + Random.int 6)

let _ = Animate.start ()
		       ~name:"Stripe Demo"
		       ~width:displayWidth
		       ~height:displayHeight
           ~stopWhen:finished
		       ~view:view
		       ~viewLast:view
