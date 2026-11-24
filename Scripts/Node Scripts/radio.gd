extends Node2D

var lightOff: Color = Color("#b2b2b2")
var lightRed: Color = Color(1.445, 0.0, 0.0)
var lightBlue: Color = Color(0.0, 0.492, 1.39)
var lightYellow: Color = Color(1.834, 1.174, 0.0)
@onready var radio_lights: Sprite2D = $RadioLights
@onready var radio_slider: HSlider = $RadioSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radio_lights.self_modulate = lightRed
	radio_slider.value = 0
	set_process(false)
	
func _on_radio_slider_drag_started() -> void:
	set_process(true)

func _on_radio_slider_drag_ended(value_changed: bool) -> void:
	set_process(false)
	
func redLight():
	radio_lights.self_modulate = lightRed

func blueLight():
	radio_lights.self_modulate = lightBlue

func yellowLight():
	radio_lights.self_modulate = lightYellow
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if radio_slider.value <= 33:
		redLight()
	elif radio_slider.value <= 66:
		blueLight()
	else:
		yellowLight()
