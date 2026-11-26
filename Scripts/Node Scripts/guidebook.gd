extends Node2D
var tween: Tween
signal book_open
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(726, 484)



func _on_button_mouse_entered() -> void:
	if tween:
			tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(726, 495), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

func _on_button_mouse_exited() -> void:
	if tween:
			tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(726, 484), 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)

func _on_button_pressed() -> void:
	if tween:
			tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", Vector2(726, 1000), 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	book_open.emit()
