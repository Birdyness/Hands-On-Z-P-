class_name toolBasic extends Area2D

var touching = false
var off = Vector2(0,0)
var on_table = true

@onready var table = $"../Table"


func _ready() -> void:
	$Button.button_down.connect(_on_button_button_down)
	$Button.button_up.connect(_on_button_button_up)
	table.object_fell.connect(get_over_here)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if touching:
		position = get_global_mouse_position() - off

func _on_button_button_down():
	touching = true
	off = get_global_mouse_position() - global_position
	move_to_front()

func _on_button_button_up():
	touching = false
	
func _on_table():
	on_table = true
	
func _off_table():
	on_table = false

func get_over_here():
	if on_table == false and touching == false:
		create_tween().tween_property(self, "position", Vector2(597.0, 446.0), 1)
