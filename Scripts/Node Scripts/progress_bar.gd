class_name Sanity extends ProgressBar
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start()
	
func _on_timeout() -> void:
	value -=0.476
	
func change(amount: float):
	value += amount
