extends Control
signal dispDown
signal thermoDown

@onready var thermoLever: HSlider = $ThermoLever
@onready var execute: TextureButton = $Execution
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	execute.position = Vector2(-968.0, -313.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_execution_button_down() -> void:
	dispDown.emit()
	execute.position = Vector2(-968.0, -310.0)
	

func _on_execution_button_up() -> void:
	execute.position = Vector2(-968.0, -313.0)


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if thermoLever.value != 100:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(thermoLever, "value", 0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	else:
		thermoDown.emit()
