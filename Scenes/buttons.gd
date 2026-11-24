extends Control
signal dispDown

@onready var execute: TextureButton = $Execution

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
