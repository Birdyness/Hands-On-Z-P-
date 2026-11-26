extends Node2D
@export var entity: Entities
@export var sanity: Sanity

const unpressed = preload("res://Assets/Execution Panel/Unpressed Button.png")
const pressed = preload("res://Assets/Execution Panel/Pressed Button.png")
@onready var game_manager: Node2D = $".."

var broken = false
signal brokenChanged(is_broken: bool)
var press = false
@onready var texture_button: TextureButton = $TextureButton
signal state(is_on: bool)
func _ready() -> void:
	set_process(false)
	game_manager.dayEnd.connect(rollBroken)
	rollBroken(game_manager.day)
	nonotouchy(game_manager.day)
	game_manager.dayEnd.connect(nonotouchy)
	
func _on_texture_button_button_down() -> void:
	if press == false:
		state.emit(true)
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
		state.emit(false)
		texture_button.texture_normal = unpressed
		press = false
		$SlowBeep.stop()
		$MediumBeep.stop()
		$FastBeep.stop()
		
func brokenChance(dayi: int) -> float:
	if dayi < 4:
		return 0
	if dayi == 4:
		return 100
	return 90.0 - 85.0 * exp(-0.015 * max(dayi - 6, 0))
	
func rollBroken(dayi: int):
	broken = randf() * 100.0 < brokenChance(dayi)
	texture_button.disabled = broken
	brokenChanged.emit(broken)
	
func fix():
	if broken and sanity.value > 10:
		broken = false
		texture_button.disabled = false
		sanity.change(-10)
		brokenChanged.emit(false)
		
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_B:
			broken = true
			texture_button.disabled = true
			brokenChanged.emit(true)

func nonotouchy(dayi: int):
	if dayi <= 3:
		self.position = Vector2(1271.0, 283.0)
	else:
		self.position = Vector2(849, 269)   
