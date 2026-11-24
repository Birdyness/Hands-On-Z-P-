extends Node2D

func empty():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/emptyPot.png")

func growing():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/growingPot.png")
	
func normal():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/normalPot.png")

func altered():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/alteredPot.png")
	
func withered():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/witheredPot.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
