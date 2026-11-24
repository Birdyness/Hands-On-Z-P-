extends Node2D
var seq = []
signal toak(disSeq)
var notDisplayed = true
var tween: Tween
func _ready() -> void:
		get_parent().get_node("Buttons").dispDown.connect(display)
		self.show()
		global_position = Vector2(-259, 515)
		
func display():
	if notDisplayed == false:
		notDisplayed = true
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "position", Vector2(-259, 515), 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	else:
		notDisplayed = false
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "position", Vector2(257, 515), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			
func threeOfAKind():
	if seq.size() == 3:
		toak.emit(seq)
		seq.clear()

func _on_hanging_button_down() -> void:
	seq.append("Hanging")
	threeOfAKind()
	

func _on_radiation_button_down() -> void:
	seq.append("Radiation")
	threeOfAKind()

func _on_compression_button_down() -> void:
	seq.append("Compression")
	threeOfAKind()

func _on_flood_button_down() -> void:
	seq.append("Flood")
	threeOfAKind()
