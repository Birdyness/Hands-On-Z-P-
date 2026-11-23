extends Node2D
var seq = []
signal toak


func threeOfAKind():
	if seq.size() == 3:
		toak.emit()

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
