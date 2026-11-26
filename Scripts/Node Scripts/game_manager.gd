extends Node2D
var day = Global.day
var dispEasyCount = 0
var dispHardCount = 0
var dispCount = 0
signal dayEnd
@onready var entity: Entities = $entity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$entity.entityDisposed.connect(dispCounter)

func endDay():
	print("DAY ", day, " ENDED")
	day += 1
	Global.day += 1
	dispEasyCount = 0
	dispHardCount = 0
	dispCount = 0
	dayEnd.emit(day)
	
func dispCounter():
	if entity.entity_data[entity.entity]["id"] <= 10:
		dispEasyCount += 1
	else:
		dispHardCount += 1
	
	dispCount = dispEasyCount + dispHardCount
		
	if dispEasyCount == 2 and day == 1:
		endDay()
	elif dispEasyCount == 5 and day == 2:
		endDay()
	elif dispEasyCount == 6 and dispHardCount == 1 and day == 3:
		endDay()
	elif dispEasyCount == 8 and dispHardCount == 2 and day == 4:
		endDay()
	elif dispCount == 12 and day == 5:
		endDay()
	if dispCount == 10 and day >= 6:
		endDay()
		


func _on_fix_pressed() -> void:
	pass # Replace with function body.
