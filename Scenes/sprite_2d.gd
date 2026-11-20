extends Sprite2D

var entView: Vector2 = Vector2(577,-326)
var workSpace: Vector2 = Vector2(576, 324)
var toolSpace: Vector2 = Vector2(1730, 326)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(576, 324)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_w"):
		if global_position == workSpace:
			global_position = entView
	if Input.is_action_just_pressed("ui_a"):
		global_position = workSpace
	if Input.is_action_just_pressed("ui_s"):
		if global_position == entView:
			global_position = workSpace
	if Input.is_action_just_pressed("ui_d"):
		global_position = toolSpace
