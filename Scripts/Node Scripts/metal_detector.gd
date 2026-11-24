extends Node2D
@export var entity: Entities

const unpressed = preload("res://Assets/Execution Panel/Unpressed Button.png")
const pressed = preload("res://Assets/Execution Panel/Pressed Button.png")

var press = false
@onready var texture_button: TextureButton = $TextureButton

func _ready() -> void:
	set_process(false)

func _on_texture_button_button_down() -> void:
	if press == false:
		texture_button.texture_normal = pressed
		press = true
		print(entity.entity_data[entity.entity]["metalLV"])
		if entity.entity_data[entity.entity]["metalLV"] == 0:
			print("Nothing There...")
		elif entity.entity_data[entity.entity]["metalLV"] == 1:
			$SlowBeep.play()
		elif entity.entity_data[entity.entity]["metalLV"] == 2:
			$MediumBeep.play()
		elif entity.entity_data[entity.entity]["metalLV"] == 3:
			$FastBeep.play()
		else:
			var spin = randi_range(1, 3)
			if spin == 1:
				$SlowBeep.play()
			elif spin == 2:
				$MediumBeep.play()
			elif spin == 3:
				$FastBeep.play()
	else:
		texture_button.texture_normal = unpressed
		press = false
		$SlowBeep.stop()
		$MediumBeep.stop()
		$FastBeep.stop()
