extends Camera2D
var tween: Tween
@onready var blood_vfx: TextureRect = $bloodVFX
@onready var black_screen: TextureRect = $BlackScreen
@onready var day_1: TextureRect = $Day1
@onready var game_manager = get_parent()
@onready var days = game_manager.day
@onready var day_label: Label = $DayLabel
@onready var boom: AudioStreamPlayer2D = $BOOM

var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise = FastNoiseLite.new()

func _ready() -> void:
	day_label.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	blood_vfx.self_modulate = Color(1.0, 1.0, 1.0, 0.0)
	black_screen.self_modulate = Color(1.0, 1.0, 1.0)
	
	await waits(1)
	boom.play()
	await waits(0.2)
	day_label.self_modulate = Color(1.0, 1.0, 1.0, 0.6)
	await waits(1)
	if tween:
			tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(day_label, "self_modulate", Color(1.0, 1.0, 1.0, 0), 3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween = create_tween()
	tween.tween_property(black_screen, "self_modulate", Color(1.0, 1.0, 1.0, 0.0) , 3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)

	game_manager.dayEnd.connect(dayLabel)
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
	
func screen_shake_blood(intensity: int, time: float):
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
	
	
func dayLabel(dayEnd: int):
	$DayLabel.text = "DAY-" + str(days)
	
