extends Node2D

const unpressed = preload("res://Assets/Execution Panel/Unpressed Button.png")
const pressed = preload("res://Assets/Execution Panel/Pressed Button.png")

var press = false
@onready var texture_button: TextureButton = $TextureButton



func _on_texture_button_button_down() -> void:
	if press == false:
		texture_button.texture_normal = pressed
		press = true
	else:
		texture_button.texture_normal = unpressed
		press = false
