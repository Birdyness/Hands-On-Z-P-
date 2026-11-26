extends Node2D
var seq = []
signal toak(disSeq)
var notDisplayed = true
var tween: Tween
@onready var entity: Entities = $"../entity"
@onready var hanging: TextureButton = $Hanging
@onready var radiation: TextureButton = $Radiation
@onready var compression: TextureButton = $Compression
@onready var flood: TextureButton = $Flood
@onready var shutSFX: AudioStreamPlayer = $ShutterSFX
@onready var deadSFX: AudioStreamPlayer = $ScreamSFX
var canAppend = true
signal delay

func _ready() -> void:
		get_parent().get_node("Buttons").dispDown.connect(display)
		self.show()
		global_position = Vector2(-259, 515)
		
		
func display():
	if notDisplayed == false:
		notDisplayed = true
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "position", Vector2(-259, 515), 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	else:
		notDisplayed = false
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "position", Vector2(257, 515), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		
func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func threeOfAKind():
	if canAppend == false:
		return
	canAppend = false
	delay.emit()
	
	shutSFX.play()
	await waits(1)
	if seq.size() == 3 and entity.entity != "Bhael":
		toak.emit(seq)
		seq.clear()
	if seq.size() == 4:
		toak.emit(seq)
		seq.clear()
	
	canAppend = true
	print(seq)
func disabled():
	hanging.disabled = true
	radiation.disabled = true
	compression.disabled = true
	flood.disabled = true

func enabled():
	hanging.disabled = false
	radiation.disabled = false
	compression.disabled = false
	flood.disabled = false
	
func _on_hanging_button_down() -> void:
	if canAppend == false:
		return
	seq.append("Hanging")
	threeOfAKind()
	

func _on_radiation_button_down() -> void:
	if canAppend == false:
		return
	seq.append("Radiation")
	threeOfAKind()

func _on_compression_button_down() -> void:
	if canAppend == false:
		return
	seq.append("Compression")
	threeOfAKind()

func _on_flood_button_down() -> void:
	if canAppend == false:
		return
	seq.append("Flood")
	threeOfAKind()


func _on_entity_entity_disposed() -> void:
	deadSFX.play()
