extends Node2D

@onready var entity_shutter: Sprite2D = $EntityShutter
@onready var flower_shutter: Sprite2D = $FlowerShutter
@onready var disp: Node2D = $"../dispButton"
@onready var shake_vfx: Camera2D = $"../shakeVFX"
@onready var pot: Node2D = $"../Pot"

var entity_tween: Tween
var flower_tween: Tween
var gTime = 0


func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	disp.delay.connect(entityShutter)
	pot.shutterIt.connect(flowerShutter)
	pot.shutC.connect(gTimeSet)
	# add more when making days, like for disable or start of day
	
func entityShutter():
	if entity_tween:
		entity_tween.kill()
	entity_tween = create_tween()
	
	entity_tween.tween_property(entity_shutter, "position", Vector2(0, 0), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	entity_tween.tween_interval(0.5)
	entity_tween.tween_property(entity_shutter, "position", Vector2(0, -1900), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await waits(1)
	shake_vfx.screen_shake(3, 0.2)

func flowerShutter():
	if flower_tween:
		flower_tween.kill()
	flower_tween = create_tween()
	
	flower_tween.tween_property(flower_shutter, "position", Vector2(2211.627, 316.277), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	flower_tween.tween_interval(gTime)
	flower_tween.tween_property(flower_shutter, "position", Vector2(2211.627, 1588.496), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await waits(1)

func gTimeSet(gTimeR: int):
	gTime = gTimeR
