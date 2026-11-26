class_name Sanity extends ProgressBar
var alive = true
@onready var game_manager = get_parent()
@onready var days = game_manager.day
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	game_manager.dayEnd.connect(sanitySet)
	timer.start()

	value = 5
	
func _on_timeout() -> void:
	if alive == true:
		if days in [1,2,3]:
			value -=0.476
		elif days in [4,5]:
			value -=0.333
		else:
			value -= 120 + 180 * pow(2.718281828, -0.033 * days)
	if value <= 0 and alive == true:
		print("Dead")
		alive = false
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	if value == 0:
		print("Dead")
		alive = false

func sanitySet(dayEnd: int):
	days = dayEnd
	if dayEnd == 2:
		value = 100
	elif dayEnd == 3:
		value = 70
	elif dayEnd == 4:
		value = 55
	elif dayEnd == 5:
		value = 40
	else:
		value = 100
		
func change(amount: float):
	value += amount
	if value <= 0 and alive == true:
		print("Dead")
		alive = false
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
