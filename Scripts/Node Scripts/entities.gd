class_name Entities extends Node2D
var entity = ""
# Disposal: Hanging, Radiation, Compression, Flood
#freq: 1-3
#thermo: Hot or Cold
#flowerLV: 1-3
#metalLV 1-3
#id: just to keep track

const entity_data = {
	"Aetherax": {
		"disposal": ["Hanging", "Radition", "Compression"],
		"freq": 2,
		"thermo": "hot",
		"flowerLV": 1,
		"metalLV": 2,
		"id": 1
	},
	
	"Frogman": {
		"disposal": ["Compression", "Hanging", "Compression"],
		"freq": 2,
		"thermo": "cold",
		"flowerLV": 1,
		"metalLV": 2,
		"id": 2
	},
	"Chupacabra": {
		"disposal": ["Hanging", "Radiation", "Flood"],
		"freq": 1,
		"thermo": "hot",
		"flowerLV": 1,
		"metalLV": 2,
		"id": 3
	}
}

func _ready() -> void:
	entityRandomizer(randi_range(1, 3))
	modelRandomizer(randi_range(1, 24))
	
	print(entity)
func modelRandomizer(modelNo):
	var number = "res://Assets/Entities/model_" + str(modelNo) + ".png"
	$entityHolder.texture = load(number) 

func entityRandomizer(entityID):
	for entPick in entity_data:
		if entity_data[entPick]["id"] == entityID:
			entity = entPick
			break
	
func floweytheflower(freq):
	pass
