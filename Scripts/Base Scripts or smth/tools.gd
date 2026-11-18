class_name toolBasic extends Area2D

var touching = false
var off = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.button_down.connect(_on_button_button_down)
	$Button.button_up.connect(_on_button_button_up)


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
