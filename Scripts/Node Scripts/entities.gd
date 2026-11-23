class_name Entities extends Node2D

# Disposal: Hanging, Radiation, Compression, Flood
#freq: 1-3
#thermo: Hot or Cold
#flowerLV: 1-3
#metalLV 1-3

const entity_data = {
	"Aetherax": {
		"disposal": ["Hanging", "Radition", "Compression"],
		"freq": 2,
		"thermo": "hot",
		"flowerLV": 1,
		"metalLV": 2
	},
	
	"Frogman": {
		"disposal": ["Compression", "Hanging", "Compression"],
		"freq": 2,
		"thermo": "cold",
		"flowerLV": 1,
		"metalLV": 2
	},
	"Chupacabra": {
		"disposal": ["Hanging", "Radiation", "Flood"],
		"freq": 1,
		"thermo": "hot",
		"flowerLV": 1,
		"metalLV": 2
	}
}

func _ready() -> void:
	modelChange(randi_range(1, 24))

func modelChange(modelNo):
	var number = "res://Assets/Entities/model_" + str(modelNo) + ".png"
	$entityHolder.texture = load(number) 
func floweytheflower(freq):
	pass
