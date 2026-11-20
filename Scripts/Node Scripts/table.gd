extends Area2D
signal object_fell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(item_back)
	area_exited.connect(item_left)

func _process(delta: float) -> void:
	pass
	
func item_back(object: toolBasic):
		object._on_table()
		
func item_left(object: toolBasic):
		object._off_table()

func chains(object: toolBasic):
		if object.on_table == false:
			object.get_over_here()
