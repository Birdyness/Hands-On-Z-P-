extends toolBasic

@onready var thermo_lever: HSlider = $"../Buttons/ThermoLever"
@onready var trait_check: Label = $traitCheck
@onready var entity: Entities = $"../entity"
@onready var timer: Timer = $Timer

signal entityDetected(entity)

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
		trait_check.text = "Normal"
	elif thermoLV == 1:
		trait_check.text = "Cold-Blooded"
	else:
		trait_check.text = "Hot-Blooded"

func _on_area_entered(area: Area2D) -> void:
	if area.name == "mColl":
		entityDetected.emit(area.get_parent())
		scanned(area.get_parent())
		
func scanned(entity):
	print("DETECTED ", entity.name)
