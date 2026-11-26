class_name Entities extends Node2D
var entity = ""
@export var sanity: Sanity
@onready var shake_vfx: Camera2D = $"../shakeVFX"
@onready var game_manager = get_parent()
@onready var days = game_manager.day

var lastEntity = 0

signal entityDisposed
# Disposal: Hanging, Radiation, Compression, Flood
#freq: 0-3 resp none, low, mid, high
#thermo: 0-2 respectively normal, coldB, hotB
#flowerLV: 0-3 respectively normal, altered, manipulation, wither
#metalLV 0-3 resp sorrow, weak, semi, fully
#id: just to keep track

#SPECIAL:
#freq = 4, interfere with all radio frequencies
#metalLV = 4, picks a random number from 1-3

const entity_data = {
	"The Cone Man": {
		"disposal": ["Compression", "Compression", "Compression"],
		"freq": 3,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 0,
		"id": 1
	},
	
	"Aetherax": {
		"disposal": ["Hanging", "Radiation", "Compression"],
		"freq": 1,
		"thermo": 1,
		"flowerLV": 3,
		"metalLV": 0,
		"id": 2
	},
	"Gnawing Gnome": {
		"disposal": ["Compression", "Hanging", "Compression"],
		"freq": 0,
		"thermo": 0,
		"flowerLV": 2,
		"metalLV": 2,
		"id": 3
	},
	"Frogman": {
		"disposal": ["Radiation", "Flood", "Compression"],
		"freq": 0,
		"thermo": 1,
		"flowerLV": 1,
		"metalLV": 0,
		"id": 4
	},
	"Chupacabra": {
		"disposal": ["Hanging", "Compression", "Hanging"],
		"freq": 0,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 1,
		"id": 5
	},
	"Mommy": {
		"disposal": ["Hanging", "Hanging", "Compression"],
		"freq": 2,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 0,
		"id": 6
	},
	"Vampierre": {
		"disposal": ["Hanging", "Compression", "Flood"],
		"freq": 3,
		"thermo": 1,
		"flowerLV": 3,
		"metalLV": 0,
		"id": 7
	},
	"Abella": {
		"disposal": ["Compression", "Radiation", "Hanging"],
		"freq": 2,
		"thermo": 0,
		"flowerLV": 0,
		"metalLV": 1,
		"id": 8
	},
	"Sylclop": {
		"disposal": ["Flood", "Compression", "Flood"],
		"freq": 3,
		"thermo": 0,
		"flowerLV": 2,
		"metalLV": 3,
		"id": 9
	},
	"The Hermit": {
		"disposal": ["Hanging", "Radiation", "Compression"],
		"freq": 2,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 2,
		"id": 10
	},
	"Maravas": {
		"disposal": ["Radiation", "Flood", "Compression"],
		"freq": 4,
		"thermo": 1,
		"flowerLV": 3,
		"metalLV": 0,
		"id": 11
	},
	"Agarose": {
		"disposal": ["Hanging", "Radiation", "Compression"],
		"freq": 2,
		"thermo": 1,
		"flowerLV": 1,
		"metalLV": 4,
		"id": 12
	},
	"Bhael": {
		"disposal": ["Hanging", "Flood", "Radiation", "Compression"],
		"freq": 2,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 2,
		"id": 13
	},
}

const dailyQuota = {3: [6, 1], 4: [8, 2]}

func _ready() -> void:
	dayEntities(1)
	get_parent().get_node("dispButton").toak.connect(seqCheck)
	print(entity)
	game_manager.dayEnd.connect(dayEntities)
	
func modelRandomizer(modelNo):
	var number = "res://Assets/Entities (OLD)/model_" + str(modelNo) + ".png"
	$entityHolder.texture = load(number) 


func randomizeEntity(number: Array):
	var allowed = []
	for id in number:
		if days == 3:
			if id <= 10 and game_manager.dispEasyCount >= 6:
				continue
			if id > 10 and game_manager.dispHardCount >= 1:
				continue
		if days == 4:
			if id <= 10 and game_manager.dispEasyCount >= 8:
				continue
			if id > 10 and game_manager.dispHardCount >= 2:
				continue
		allowed.append(id)
		
	if allowed.size() > 1:
		allowed.erase(lastEntity)
	var pick = allowed.pick_random()
	lastEntity = pick
	var chosen = get_node("model_" + str(randi_range(1, 10)))
	
	for entPick in entity_data:
		if entity_data[entPick]["id"] == pick:
			entity = entPick
			break

	for child in get_children():
		if child is Sprite2D:
			child.visible = child == chosen
			
	return chosen
	
func seqCheck(disSeq):
	if entity_data[entity]["disposal"] == disSeq:
		print("DISPOSED")
		entityDisposed.emit()
		dayEntities(days)
		sanity.change(20)
		print(entity) #just to see
	else:
		print("WRONG")
		sanity.change(-10)
		shake_vfx.screen_shake_blood(15, 0.6)

func dayEntities(newDay):
	days = newDay
	if days == 1:
		randomizeEntity([1, 6])
	if days == 2:
		randomizeEntity([1, 2, 4, 6, 7])
	elif days == 3:
		randomizeEntity([1, 2, 4, 6, 7, 11, 12])
	elif days == 4:
		randomizeEntity([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
	elif days >= 5:
		randomizeEntity([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])


#GOD MODE REMEMBER TO REMOVE
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E:
			seqCheck(entity_data[entity]["disposal"])
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_Q:
			seqCheck(["Wrong"])
