extends Node2D
@onready var thermo_lever: HSlider = $"../Buttons/ThermoLever"
@onready var trait_check: Label = $traitCheck
@onready var entity: Entities = $"../entity"
@onready var timer: Timer = $Timer
var thermoLV 

func _ready() -> void:
	set_process(false)
	thermoLV = entity.entity_data[entity.entity]["thermo"]
	trait_check.text = ""
	
func _on_thermo_lever_drag_started() -> void:
	set_process(true)
	trait_check.text = ""
	
func _on_thermo_lever_drag_ended(_value_changed: bool) -> void:
	if thermo_lever.value == 100:
		set_process(false)
		trait_check.text = "Scanning..."
	
func _process(_delta: float) -> void:
	global_position = Vector2(270, -190 +(380 * thermo_lever.value/100))
	timer.start(2)
	await timer.timeout
	if thermoLV == 0:
		trait_check.text = "Normal"
	elif thermoLV == 1:
		trait_check.text = "Cold-Blooded"
	else:
		trait_check.text = "Hot-Blooded"
