extends Node2D
const TEXT_1 = preload("res://Assets/Dialogue/Tutorial/Text 1.png")
const TEXT_2 = preload("res://Assets/Dialogue/Tutorial/Text 2.png")
const TEXT_3 = preload("res://Assets/Dialogue/Tutorial/Text 3.png")
const TEXT_4 = preload("res://Assets/Dialogue/Tutorial/Text 4.png")
const TEXT_5 = preload("res://Assets/Dialogue/Tutorial/Text 5.png")
const TEXT_6 = preload("res://Assets/Dialogue/Tutorial/Text 6.png")
const TEXT_7 = preload("res://Assets/Dialogue/Tutorial/Text 7.png")
const TEXT_8 = preload("res://Assets/Dialogue/Tutorial/Text 8.png")

const __1____CONE_MAN = preload("res://Assets/Dialogue/Entities/1 - Cone Man/[1] - Cone Man.png")
const __2____CONE_MAN = preload("res://Assets/Dialogue/Entities/1 - Cone Man/[2] - Cone Man.png")
const __3____CONE_MAN = preload("res://Assets/Dialogue/Entities/1 - Cone Man/[3] - Cone Man.png")

const __1____AETHERAX = preload("res://Assets/Dialogue/Entities/2 - Aetherax/[1] - Aetherax.png")
const __2____AETHERAX = preload("res://Assets/Dialogue/Entities/2 - Aetherax/[2] - Aetherax.png")
const __3____AETHERAX = preload("res://Assets/Dialogue/Entities/2 - Aetherax/[3] - Aetherax.png")

const __1____GNAWING_GNOME = preload("res://Assets/Dialogue/Entities/3 - Gnawing Gnome/[1] - Gnawing Gnome.png")
const __2____GNAWING_GNOME = preload("res://Assets/Dialogue/Entities/3 - Gnawing Gnome/[2] - Gnawing Gnome.png")
const __3____GNAWING_GNOME = preload("res://Assets/Dialogue/Entities/3 - Gnawing Gnome/[3] - Gnawing Gnome.png")

const __1____FROGMAN = preload("res://Assets/Dialogue/Entities/4 - Frogman/[1] - Frogman.png")
const __2____FROGMAN = preload("res://Assets/Dialogue/Entities/4 - Frogman/[2] - Frogman.png")
const __3____FROGMAN = preload("res://Assets/Dialogue/Entities/4 - Frogman/[3] - Frogman.png")

const __1____CHUPACABRA = preload("res://Assets/Dialogue/Entities/5 - Chupacabra/[1] - Chupacabra.png")
const __2____CHUPACABRA = preload("res://Assets/Dialogue/Entities/5 - Chupacabra/[2] - Chupacabra.png")
const __3____CHUPACABRA = preload("res://Assets/Dialogue/Entities/5 - Chupacabra/[3] - Chupacabra.png")

const __1____MOMMY = preload("res://Assets/Dialogue/Entities/6 - Mommy/[1] - Mommy.png")
const __2____MOMMY = preload("res://Assets/Dialogue/Entities/6 - Mommy/[2] - Mommy.png")
const __3____MOMMY = preload("res://Assets/Dialogue/Entities/6 - Mommy/[3] - Mommy.png")

const __1____VAMPIERRE = preload("res://Assets/Dialogue/Entities/7 - Vampierre/[1] - Vampierre.png")
const __2____VAMPIERRE = preload("res://Assets/Dialogue/Entities/7 - Vampierre/[2] - Vampierre.png")
const __3____VAMPIERRE = preload("res://Assets/Dialogue/Entities/7 - Vampierre/[3] - Vampierre.png")

const __1____ABELLA = preload("res://Assets/Dialogue/Entities/8 - Abella/[1] - Abella.png")
const __2____ABELLA = preload("res://Assets/Dialogue/Entities/8 - Abella/[2] - Abella.png")
const __3____ABELLA = preload("res://Assets/Dialogue/Entities/8 - Abella/[3] - Abella.png")

const __1____SYLCLOP = preload("res://Assets/Dialogue/Entities/9 - Sylclop/[1] - Sylclop.png")
const __2____SYLCLOP = preload("res://Assets/Dialogue/Entities/9 - Sylclop/[2] - Sylclop.png")
const __3____SYLCLOP = preload("res://Assets/Dialogue/Entities/9 - Sylclop/[3] - Sylclop.png")

const __1____THE_HERMIT = preload("res://Assets/Dialogue/Entities/10 - The Hermit/[1] - The Hermit.png")
const __2____THE_HERMIT = preload("res://Assets/Dialogue/Entities/10 - The Hermit/[2] - The Hermit.png")
const __3____THE_HERMIT = preload("res://Assets/Dialogue/Entities/10 - The Hermit/[3] - The Hermit.png")

var tween: Tween
var texts = [TEXT_1, TEXT_2, TEXT_3, TEXT_4, TEXT_5, TEXT_6, TEXT_7, TEXT_8]
var current = 0
var busy = false

@onready var entity: Entities = $"../entity"
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
