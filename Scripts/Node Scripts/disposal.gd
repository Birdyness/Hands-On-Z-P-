extends Node2D
var seq = []
signal toak(disSeq)
var displayed = false
func _ready() -> void:
		get_parent().get_node("Buttons").dispDown.connect(display)
		self.hide()
		get_parent().move_child(self, 0)
		
func display():
	if displayed == false:
		displayed = true
		self.show()
		move_to_front()
	else:
		displayed = false
		self.hide()
		get_parent().move_child(self, 0)
			
func threeOfAKind():
	if seq.size() == 3:
		toak.emit(seq)
		seq.clear()

func _on_hanging_pressed() -> void:
	seq.append("Hanging")
	threeOfAKind()

func _on_radiation_pressed() -> void:
	seq.append("Radiation")
	threeOfAKind()

func _on_compression_pressed() -> void:
	seq.append("Compression")
	threeOfAKind()

func _on_flood_pressed() -> void:
	seq.append("Flood")
	threeOfAKind()
