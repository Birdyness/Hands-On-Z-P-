class_name Entities extends Node2D
var entity = ""
@export var sanity: Sanity

# Disposal: Hanging, Radiation, Compression, Flood
#freq: 1-3
#thermo: Hot or Cold
#flowerLV: 0-3 respectively normal, altered, manipulation, wither
#metalLV 1-3
#id: just to keep track

const entity_data = {
	"Aetherax": {
		"disposal": ["Hanging", "Radiation", "Compression"],
		"freq": 2,
		"thermo": "hot",
		"flowerLV": 0,
		"metalLV": 2,
		"id": 1
	},
	
	"Frogman": {
		"disposal": ["Compression", "Hanging", "Compression"],
		"freq": 2,
		"thermo": "cold",
		"flowerLV": 2,
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
	
func floweytheflower(freq):
	pass

func seqCheck(disSeq):
	if entity_data[entity]["disposal"] == disSeq:
		print("DISPOSED")
		randomizer()
		sanity.change(40)
		print(entity) #just to see
	else:
		print("WRONG")
		sanity.change(-20)
