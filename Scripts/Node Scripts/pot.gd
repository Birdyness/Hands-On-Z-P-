extends Node2D
@export var sanity: Sanity
@export var cEntity: Entities
@onready var timer: Timer = $Timer
var curPhase = 0

func emptyS():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/emptyPot.png")
	curPhase = 0
	
func growingS():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/growingPot.png")
	curPhase = 1
	
func normalS():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/normalPot.png")
	curPhase = 2
	
func alteredS():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/alteredPot.png")
	curPhase = 3
	
func witheredS():
	$potCurrent.texture = load("res://Assets/Buttons/Pot & Flower/witheredPot.png")
	curPhase = 4

func normal():
	timer.start(5)
	await timer.timeout
	normalS()

func altered():
	timer.start(5)
	await timer.timeout
	alteredS()
	
func manipulation():
	timer.start(10)
	await timer.timeout
	normalS()

func withered():
	timer.start(5)
	await timer.timeout
	witheredS()
	
func _ready() -> void:
	emptyS()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	var curEnt = cEntity.entity_data[cEntity.entity]["flowerLV"]
	if curPhase != 1:
		sanity.change(-5)
		growingS()
		print(curEnt)
		if curEnt == 0:
			normal()
		elif curEnt == 1:
			altered()
		elif curEnt == 2:
			manipulation()
		else:
			withered()
