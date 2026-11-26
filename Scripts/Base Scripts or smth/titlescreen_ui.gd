extends Control

@export var game_scene: PackedScene
const GAME_MANAGER = preload("res://Scenes/game_manager.tscn")
@onready var bScreen: TextureRect = $BlackScreen
@onready var menuBGM: AudioStreamPlayer2D = $MenuBGM
var tween: Tween
var stopped = true

func _ready() -> void:
	
	
	bScreen.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	menuBGM.volume_db = -80.0 
	menuBGM.play()
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(menuBGM, "volume_db", 0, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	tween = create_tween()
	tween.tween_property(bScreen, "self_modulate", Color(1.0, 1.0, 1.0, 0.0) , 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	await tween.finished
	
	stopped = false
	
func _on_quit_button_pressed() -> void:
	if stopped == false:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_parallel(true)
	
		tween.tween_property(menuBGM, "volume_db", -40, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
		tween = create_tween()
		tween.tween_property(bScreen, "self_modulate", Color(1.0, 1.0, 1.0, 1.0) , 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		await tween.finished
	
		get_tree().quit()


func _on_start_button_pressed() -> void:
	if stopped == false:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_parallel(true)
	
		tween.tween_property(menuBGM, "volume_db", -40, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
		tween = create_tween()
		tween.tween_property(bScreen, "self_modulate", Color(1.0, 1.0, 1.0, 1.0) , 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		await tween.finished
	
		get_tree().change_scene_to_packed(GAME_MANAGER)
