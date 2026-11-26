extends Node2D

#@export var ui_scene: Node
@export var background: Sprite2D
@export var magnitudeX: float
@export var magnitudeY: float

#func  _ready() -> void:
	#ui_scene.position

func _process(delta: float) -> void:
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	var mouse_pos = viewport.get_mouse_position()
	var relative_mouse_pos = mouse_pos / viewport_size
	var clamped_rel = relative_mouse_pos.clamp(Vector2(0,0), Vector2(1,1))
	
	background.position = Vector2(-magnitudeX * (clamped_rel.x - 0.5), -magnitudeY * (clamped_rel.y - 0.5))
