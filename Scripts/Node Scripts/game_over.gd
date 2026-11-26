extends Node2D

@onready var pointer: Sprite2D = $PointRectangle
@onready var game_over: Sprite2D = $Text1GameOver
@onready var retry: Sprite2D = $Text2Retry
@onready var back_to_menu: Sprite2D = $Text3BackToMenu
@onready var black_screen: Sprite2D = $BlackScreen
@onready var click_stopper: Button = $ClickStopper
@onready var retryB: Button = $Retry
@onready var backB: Button = $Back
@onready var bgm: AudioStreamPlayer2D = $DeadBGM
var tween: Tween

func _ready() -> void:
	black_screen.self_modulate = Color(1.0, 1.0, 1.0)
	pointer.self_modulate = Color(1.0, 1.0, 1.0, 0)
	game_over.self_modulate = Color(1.0, 1.0, 1.0, 0)
	retry.self_modulate = Color(1.0, 1.0, 1.0, 0)
	back_to_menu.self_modulate = Color(1.0, 1.0, 1.0, 0)
	
	await waits(2)
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(black_screen, "self_modulate", Color(1.0, 1.0, 1.0, 0), 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(bgm, "volume_db", 10.0, 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(1)
	tween.tween_property(game_over, "self_modulate", Color(1.0, 1.0, 1.0), 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(1)
	tween.tween_property(retry, "self_modulate", Color(1.0, 1.0, 1.0), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(back_to_menu, "self_modulate", Color(1.0, 1.0, 1.0), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	await waits(9.5)
	click_stopper.visible = false
	click_stopper.disabled = true
	
func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func pointAway():
	pointer.global_position = Vector2(-25.0, 456.0)

func _on_retry_mouse_entered() -> void:
	pointer.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	pointer.global_position = Vector2(171, 413)

func _on_back_mouse_entered() -> void:
	pointer.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	pointer.global_position = Vector2(112, 452)
	
func _on_back_mouse_exited() -> void:
	pointer.self_modulate = Color(1.0, 1.0, 1.0, 0)
	pointAway()
	
func _on_retry_mouse_exited() -> void:
	pointAway()
	
func _on_retry_pressed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(black_screen, "self_modulate", Color(1.0, 1.0, 1.0), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await waits(2)
	get_tree().change_scene_to_file("res://Scenes/game_manager.tscn")

func _on_back_pressed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(black_screen, "self_modulate", Color(1.0, 1.0, 1.0), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await waits(2)
	Global.day = 1
	get_tree().change_scene_to_file(ProjectSettings.get_setting("application/run/main_scene"))
