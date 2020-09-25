(* file: main.ml of stopNgo app
   author: Bob Muller

   CSCI 1103 Computer Science 1 Honors

   A basic animation function stopping a ball when the touchpad is released.
*)

let displayHeight = 800.
let displayWidth = displayHeight
let delta = 2.
let radius = 100.
let circle = Image.circle radius Color.red
let courseName = Image.text "CSCI 1103" ~size:38. Color.white
let circle = Image.placeImage courseName (3., 85.) circle
let y = displayHeight /. 2. -. radius

let backGround =
  Image.rectangle displayWidth displayHeight Color.dodgerBlue

type state = Stop | Go

(* toggle : state -> state *)
let toggle state =
  match state with
  | Stop -> Go
  | Go -> Stop

type model = { state : state
             ; x : float
             }

let initialModel = { state = Go
                   ; x = -. radius
                   }

(* view : model -> Image.t *)
let view model =
  Image.placeImage circle (model.x, y) backGround

(* update : model -> model *)
let update model =
  match model.state with
  | Go -> { model with x = mod_float (model.x +. delta) displayWidth }
  | Stop -> model

(* handleMouse : model -> float -> float -> string -> model *)
let handleMouse model x y event =
  match event = "button_up" with
  | true  -> { model with state = toggle model.state }
  | false -> model

let go () =
  Animate.start initialModel
    ~name: "stopNgo"
    ~width: displayWidth
    ~height: displayHeight
    ~rate: 0.01
    ~view: view
    ~onTick: update
    ~onMouse: handleMouse

let s = go ()
