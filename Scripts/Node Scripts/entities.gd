class_name Entities extends Node2D
var entity = ""
@export var sanity: Sanity
@onready var shake_vfx: Camera2D = $"../shakeVFX"

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

func _ready() -> void:
	randomizer()
	get_parent().get_node("dispButton").toak.connect(seqCheck)
	print(entity)
	
func modelRandomizer(modelNo):
	var number = "res://Assets/Entities/model_" + str(modelNo) + ".png"
	$entityHolder.texture = load(number) 

func entityRandomizer(entityID):
	for entPick in entity_data:
		if entity_data[entPick]["id"] == entityID:
			entity = entPick
			break
func randomizer():
	entityRandomizer(randi_range(1, 13))
	modelRandomizer(randi_range(1, 24)) #model needs size readjusment
	
func seqCheck(disSeq):
	if entity_data[entity]["disposal"] == disSeq:
		print("DISPOSED")
		randomizer()
		sanity.change(20)
		print(entity) #just to see
	else:
		print("WRONG")
		sanity.change(-10)
		shake_vfx.screen_shake(15, 0.6)
