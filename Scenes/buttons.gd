extends Control
signal dispDown
signal thermoDown

@onready var h_slider: HSlider = $HSlider
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
	if h_slider.value != 100:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(h_slider, "value", 0, 0.2)
	else:
		thermoDown.emit()
