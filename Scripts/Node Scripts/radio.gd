extends Node2D

var lightOff: Color = Color("#b2b2b2")
var lightRed: Color = Color(1.445, 0.0, 0.0)
var lightBlue: Color = Color(0.0, 0.492, 1.39)
var lightYellow: Color = Color(1.834, 1.174, 0.0)
@onready var radio_lights: Sprite2D = $RadioLights
@onready var radio_slider: HSlider = $RadioSlider
@onready var entity: Entities = $"../entity"
@onready var inter_freq: AudioStreamPlayer2D = $InterFreq
@onready var high_freq: AudioStreamPlayer2D = $HighFreq
@onready var mid_freq: AudioStreamPlayer2D = $MidFreq
@onready var low_freq: AudioStreamPlayer2D = $LowFreq
var freqBand: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radio_lights.self_modulate = lightOff
	radio_slider.value = 0
	set_process(false)
func _on_radio_slider_drag_started() -> void:
	set_process(true)
func _on_radio_slider_drag_ended(_value_changed: bool) -> void:
	set_process(false)
	
func redLight():
	radio_lights.self_modulate = lightRed

func blueLight():
	radio_lights.self_modulate = lightBlue

func yellowLight():
	radio_lights.self_modulate = lightYellow
	
func stopTheMusic():
	inter_freq.stop()
	low_freq.stop()
	mid_freq.stop()
	high_freq.stop()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var newFreq: int
	if radio_slider.value == 0:
		newFreq = 0
	elif radio_slider.value <= 33:
		newFreq = 1
	elif radio_slider.value <= 66:
		newFreq = 2
	else:
		newFreq = 3

	if newFreq == 0:
		radio_lights.self_modulate = lightOff
		stopTheMusic()
	elif newFreq == 1:
		redLight()
	elif newFreq == 2:
		blueLight()
	else:
		yellowLight()

	if newFreq != freqBand:
		freqBand = newFreq
		stopTheMusic()
		
		if newFreq != 0 and (entity.entity_data[entity.entity]["freq"] == newFreq or entity.entity_data[entity.entity]["freq"] == 4):
			inter_freq.play()
		else:
			if newFreq == 1:
				low_freq.play()
			elif newFreq == 2:
				mid_freq.play()
			else:
				high_freq.play()
