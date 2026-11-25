extends Node2D
@export var sanity: Sanity
@export var cEntity: Entities
@onready var timer: Timer = $Timer
var curPhase = 0
@onready var pot_flower: Sprite2D = $potFlower
signal shutterIt

func growingN():
	pot_flower.texture = load("res://Assets/Flowers/Red_ Flower-Growing.png")
	curPhase = 1

func growingA():
	pot_flower.texture = load("res://Assets/Flowers/White_ Flower-Growing.png")
	curPhase = 1
	
func normalS():
	pot_flower.texture = load("res://Assets/Flowers/Red_ Flower Fully-Bloomed.png")
	curPhase = 2
	
func alteredS():
	pot_flower.texture = load("res://Assets/Flowers/White_ Flower Fully-Bloomed.png")
	curPhase = 3
	
func witheredS():
	pot_flower.texture = load("res://Assets/Flowers/Withered_Wilted.png")
	curPhase = 4

func waits(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func normal():
	pot_flower.show()
	growingN()
	timer.start(5)
	await timer.timeout
	normalS()

func altered():
	pot_flower.show()
	growingA()
	timer.start(5)
	await timer.timeout
	alteredS()
	
func manipulation():
	pot_flower.show()
	growingN()
	timer.start(10)
	await timer.timeout
	normalS()

func withered():
	pot_flower.show()
	var mixUp = randi_range(1,2)
	if mixUp == 1:
		growingN()
	else:
		growingA()
	timer.start(5)
	await timer.timeout
	witheredS()
	
func _ready() -> void:
	pot_flower.hide()


func _on_texture_button_pressed() -> void:
	var curEnt = cEntity.entity_data[cEntity.entity]["flowerLV"]
	await waits(1)
	shutterIt.emit()
	await waits(1)
	if curPhase != 1:
		sanity.change(-5)
		if curEnt == 0:
			normal()
		elif curEnt == 1:
			altered()
		elif curEnt == 2:
			manipulation()
		else:
			withered()
