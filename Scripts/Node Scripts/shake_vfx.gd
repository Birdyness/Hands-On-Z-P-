extends Camera2D
var tween: Tween
@onready var blood_vfx: TextureRect = $bloodVFX
@onready var black_screen: TextureRect = $BlackScreen
@onready var day_1: TextureRect = $Day1

var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise = FastNoiseLite.new()

func _ready() -> void:
	blood_vfx.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	black_screen.self_modulate = Color(1.0, 1.0, 1.0)
	day_1.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	
	await waits(2)
	day_1.self_modulate = Color(1.0, 1.0, 1.0)
	black_screen.self_modulate = Color(1.0, 1.0, 1.0, 0)
	
	if tween:
			tween.kill()
	tween = create_tween()
	tween.tween_property(day_1, "self_modulate", Color(1.0, 1.0, 1.0, 0), 3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	
func _physics_process(delta: float) -> void:
	if active_shake_time > 0:
		shake_time += delta*shake_time_speed
		active_shake_time -= delta
		
		offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)

		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)

func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func screen_shake(intensity: int, time: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0
	
	if tween:
			tween.kill()
	tween = create_tween()
	tween.tween_property(blood_vfx, "self_modulate", Color(1.0, 1.0, 1.0), 0.05).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(blood_vfx, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 1.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	
	
