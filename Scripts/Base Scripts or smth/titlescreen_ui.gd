extends Control

@export var game_scene: PackedScene
const GAME_MANAGER = preload("res://Scenes/game_manager.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME_MANAGER)
