class_name toolBasic extends Area2D

var touching = false
var off = Vector2(0,0)

@export var min_pos = Vector2(192, 66)
@export var max_pos = Vector2(463, 331)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.button_down.connect(_on_button_button_down)
	$Button.button_up.connect(_on_button_button_up)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if touching:
		var mouse_pos = get_global_mouse_position() - off
		global_position = Vector2(
		clamp(mouse_pos.x, min_pos.x, max_pos.x),
		clamp(mouse_pos.y, min_pos.y, max_pos.y)
		)
func _on_button_button_down():
	touching = true
	off = get_global_mouse_position() - global_position

func _on_button_button_up():
	touching = false

#Call this everytime u want to interact 
func interact():
	pass

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E and touching == true:
			interact()
