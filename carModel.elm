type CustomHubCap = Topaz | Magenta | White
type CustomBrakeLight = Gray | Red
type CustomHeadLight = Off | On
type CustomHeadLight1 = Off1 | On1

customHubCapInElm : CustomHubCap -> Color
customHubCapInElm colourName = case colourName of
Topaz -> rgb 255 200 124
Magenta -> rgb 255 0 255
White -> rgb 255 255 255

cycleHubCapColour : CustomHubCap -> CustomHubCap
cycleHubCapColour currentColour = case currentColour of
Topaz -> Magenta
Magenta -> White
White -> Topaz

customBrakeLightInElm : CustomBrakeLight -> Color
customBrakeLightInElm brakeLightName = case brakeLightName of
Gray -> rgb 128 128 128
Red -> rgb 255 0 0

changeBrakeLight : CustomBrakeLight -> CustomBrakeLight
changeBrakeLight currentLight = case currentLight of
Gray -> Red
Red -> Red

customHeadLightInElm : CustomHeadLight -> Color
customHeadLightInElm stateName = case stateName of
Off -> rgb 128 128 128
On -> rgb 255 255 0

changeHeadLightState currentState = case currentState of
Off -> On
On -> Off

customHeadLightInElm1 : CustomHeadLight1 -> Color
customHeadLightInElm1 stateName1 = case stateName1 of
Off1 -> rgb 0 0 0
On1 -> rgb 255 255 0

changeHeadLightState1 currentState1 = case currentState1 of
Off1 -> On1
On1 -> Off1
myShapes model =
[
sky,

road,

triangle 10
|> filled (customHeadLightInElm1 model.headLightState1)
|> scaleX 2
|> move (-78,-13)
|> move (3 * sin model.time, 3 * sin (10 * model.time)),

car
|> move (3 * sin model.time, 3 * sin (10 * model.time)),

rect 5 15
|> filled (customBrakeLightInElm model.brakeLightColour)
|> notifyTap ClickBrakeLight
|> move (83,-19)
|> move (3 * sin model.time, 3 * sin (10 * model.time)),

rect 4 13
|> filled (customHeadLightInElm model.headLightState)
|> notifyTap ClickHeadLight
|> move (-73,-13)
|> move (3 * sin model.time, 3 * sin (10 * model.time)),

ngon 5 10
|> filled (customHubCapInElm model.hubCapColour)
|> move (-33,-34)
|> notifyTap ClickHubCap
|> transform
(ident
|> rotateAboutT (-33,-34) (degrees -90 - (8 * model.time)))
|> move (3 * sin model.time, 3 * sin (10 * model.time)),

ngon 5 10
|> filled (customHubCapInElm model.hubCapColour)
|> move (48,-34)
|> notifyTap ClickHubCap
|> transform
(ident
|> rotateAboutT (48,-34) (degrees -90 - (8 * model.time)))
|> move (3 * sin model.time, 3 * sin (10 * model.time))

]

type Msg = Tick Float GetKeyState | ClickHubCap | ClickBrakeLight | ClickHeadLight
update msg model = case msg of
Tick t _ -> {model | time = t }
ClickHubCap -> {model | hubCapColour = cycleHubCapColour model.hubCapColour }
ClickBrakeLight -> {model | brakeLightColour = changeBrakeLight model.brakeLightColour }
ClickHeadLight -> {model | headLightState = changeHeadLightState model.headLightState, headLightState1 = changeHeadLightState1 model.headLightState1}

init = { time = 0, hubCapColour = White, brakeLightColour = Gray, headLightState = Off, headLightState1 = Off1 }


car = group [ frame, window, doors, wheel, wheel1]

sky = rect 250 150
|> filled (black)
|> move (20,50)

road = rect 250 50
|> filled (gray)
|> move (-20,-50)

frame = group [
polygon [(0,24),(0,0),(40,0)]
|> filled (rgb 230 125 50)
|> scaleX 2,

polygon [(0,24),(0,0),(-30,0)]
|> filled (rgb 230 125 50)
|> scaleX 2,

rect 140 30
|> filled (rgb 230 125 50)
|> move (11,-15),

polygon [(0,6),(-12,0),(-12,-14),(0,-24)]
|> filled (rgb 230 125 50)
|> move (-59,-6),

polygon [(0,0),(0,21),(20,20)]
|> filled (rgb 230 125 50)
|> move (71,-19)
]

window = group [
polygon [(1,20),(1,1),(34,1)]
|> filled (blue)
|> scaleX 2,

polygon [(-1,20),(-1,1),(-26,1)]
|> filled (blue)
|> scaleX 2
]

doors = group [
rect 0.1 30
|> filled (black)
|> move (0,-15),

rect 0.1 30
|> filled (black)
|> move (71,-15),

rect 0.1 30
|> filled (black)
|> move (-59,-15),

rect 10 3
|> filled (darkOrange)
|> move (-18,-8),

rect 10 3
|> filled (darkOrange)
|> move (49,-8)
]

wheel =
circle 15
|> filled (black)
|> move (-33,-34)

wheel1 =
circle 15
|> filled (black)
|> move (48,-34)