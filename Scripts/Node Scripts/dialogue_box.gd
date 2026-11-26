extends Node2D
const TEXT_1 = preload("res://Assets/Dialogue/Tutorial/Text 1.png")
const TEXT_2 = preload("res://Assets/Dialogue/Tutorial/Text 2.png")
const TEXT_3 = preload("res://Assets/Dialogue/Tutorial/Text 3.png")
const TEXT_4 = preload("res://Assets/Dialogue/Tutorial/Text 4.png")
const TEXT_5 = preload("res://Assets/Dialogue/Tutorial/Text 5.png")
const TEXT_6 = preload("res://Assets/Dialogue/Tutorial/Text 6.png")
const TEXT_7 = preload("res://Assets/Dialogue/Tutorial/Text 7.png")
const TEXT_8 = preload("res://Assets/Dialogue/Tutorial/Text 8.png")
var tween: Tween
var texts = [TEXT_1, TEXT_2, TEXT_3, TEXT_4, TEXT_5, TEXT_6, TEXT_7, TEXT_8]
var current = 0
var busy = false
@onready var dialogue_box: Sprite2D = $dialogueBox
signal tutorialFinished

func _ready() -> void:
	global_position = Vector2(566.0, 119.0)
	dialogue_box.texture = texts[0]
	busy = true
	await waits(5)
	dialogueDown()
	await tween.finished
	busy = false


func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func dialogueUp():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(566.0, 119.0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
func dialogueDown():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(566.0, 340.0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		
func _on_next_dialogue_pressed() -> void:
	if busy:
		return
	if current >= 7:
		return
	busy = true
	
	dialogueUp()
	await tween.finished
	
	current += 1
	dialogue_box.texture = texts[current]
	
	if current == 7:
		tutorialFinished.emit()
	else:
		dialogueDown()
		await tween.finished
	
	busy = false
