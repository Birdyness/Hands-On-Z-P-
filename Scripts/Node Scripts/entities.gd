class_name Entities extends Node2D
var entity = ""
@export var sanity: Sanity
@onready var shake_vfx: Camera2D = $"../shakeVFX"

# Disposal: Hanging, Radiation, Compression, Flood
#freq: 1-3
#thermo: 0-2 respectively normal, coldB, hotB
#flowerLV: 0-3 respectively normal, altered, manipulation, wither
#metalLV 0-3
#id: just to keep track

const entity_data = {
	"Aetherax": {
		"disposal": ["Hanging", "Radiation", "Compression"],
		"freq": 2,
		"thermo": 2,
		"flowerLV": 0,
		"metalLV": 2,
		"id": 1
	},
	
	"Frogman": {
		"disposal": ["Compression", "Hanging", "Compression"],
		"freq": 2,
		"thermo": 1,
		"flowerLV": 2,
		"metalLV": 2,
		"id": 2
	},
	"Chupacabra": {
		"disposal": ["Hanging", "Radiation", "Flood"],
		"freq": 1,
		"thermo": 2,
		"flowerLV": 1,
		"metalLV": 2,
		"id": 3
	}
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
	entityRandomizer(randi_range(1, 3))
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
