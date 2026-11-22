extends Node3D

@export var entity: Node3D 
@export var camera: Camera3D
@export var magnitudeX: float
@export var magnitudeY: float

func _ready() -> void:
	var initialYpos = entity.position.y
	entity.position.y = 0
	entity.look_at(camera.global_position)
	entity.position.y = initialYpos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	var mouse_pos = viewport.get_mouse_position()
	var relative_mouse_pos = mouse_pos / viewport_size
	var clamped_rel = relative_mouse_pos.clamp(Vector2(0,0), Vector2(1,1))
	
	camera.rotation_degrees = Vector3(-magnitudeY * (clamped_rel.y - 0.5), -magnitudeX * (clamped_rel.x - 0.5), 0)
