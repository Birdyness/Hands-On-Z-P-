extends toolBasic

@onready var thermo_lever: HSlider = $"../Buttons/ThermoLever"
@onready var trait_check: Label = $traitCheck
@onready var entity: Entities = $"../entity"
@onready var timer: Timer = $Timer
@onready var thermoScanner: Sprite2D = $ThermoScan

const NO_INDICATOR = preload("res://Assets/ThermoScan/1 - No Indicator.png")
const NORMAL = preload("res://Assets/ThermoScan/2 - Normal.png")
const COLD_BLOODED = preload("res://Assets/ThermoScan/3 - Cold-Blooded.png")
const HOT_BLOODED = preload("res://Assets/ThermoScan/4 - Hot-Blooded.png")

var thermoLV
var moving = false

func _ready() -> void:
	super._ready()
	trait_check.text = ""

func _on_thermo_lever_drag_started() -> void:
	moving = true
	trait_check.text = ""

func _on_thermo_lever_drag_ended(_value_changed: bool) -> void:
	moving = false

func _process(delta: float) -> void:
	super._process(delta)

	if thermo_lever.value != 100:
		global_position = Vector2(270, -190 + (380 * thermo_lever.value / 100))
	
			
func interact() -> void:
	if thermo_lever.value == 100:
		thermo_scan()

func thermo_scan():
	thermoLV = entity.entity_data[entity.entity]["thermo"]
	trait_check.text = "Scanning..."

	timer.start(2)
	await timer.timeout

	if thermoLV == 0:
		thermoScanner.texture = NORMAL
	elif thermoLV == 1:
		thermoScanner.texture = COLD_BLOODED
	else:
		thermoScanner.texture = HOT_BLOODED

		
func _on_scan_area_area_entered(_area: Area2D) -> void:
	thermoLV = entity.entity_data[entity.entity]["thermo"]
	if thermoLV == 0:
		thermoScanner.texture = NORMAL
	elif thermoLV == 1:
		thermoScanner.texture = COLD_BLOODED
	else:
		thermoScanner.texture = HOT_BLOODED



func _on_scan_area_area_exited(area: Area2D) -> void:
	thermoScanner.texture = NO_INDICATOR
