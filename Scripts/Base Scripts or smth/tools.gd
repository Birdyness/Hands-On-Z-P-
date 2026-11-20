class_name toolBasic extends Area2D

var touching = false
var off = Vector2(0,0)
var on_table = true
var on_board = false
signal untouch

@onready var table = $"../Table"


func _ready() -> void:
	$Button.button_down.connect(_on_button_button_down)
	$Button.button_up.connect(_on_button_button_up)
	untouch.connect(table.chains)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if touching:
		position = get_global_mouse_position() - off
	
	if Input.is_action_just_pressed("ui_e"):
		interact()
	
func _on_button_button_down():
	touching = true
	off = get_global_mouse_position() - global_position
	move_to_front()

func _on_button_button_up():
	touching = false
	untouch.emit(self)

func _on_table():
	on_table = true
	
func _off_table():
	on_table = false
	
func _on_board():
	on_board = true
	
func _off_board():
	on_board = false
	
func get_over_here():
	if on_table == false and on_board == false:
		create_tween().tween_property(self, "position", Vector2(597.0, 376.0), 0.5)

#Call this everytime u want to interact 
func interact():
	pass
