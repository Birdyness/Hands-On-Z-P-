extends Node2D

@onready var metal_detector: Node2D = $"../metalDetector"
@onready var interactive: Sprite2D = $"MetalDetector(interactive)"
var tween: Tween

func _ready() -> void:
	metal_detector.state.connect(start_animation_loop)	
	
func start_animation_loop(is_on: bool) -> void:
	if tween:
		tween.kill()
	if is_on:
		tween = create_tween().set_loops()
		tween.tween_property(interactive, "position:y", 157, 1)
		tween.tween_property(interactive, "position:y", -160, 1)


func _on_fix_pressed() -> void:
	metal_detector.fix()
