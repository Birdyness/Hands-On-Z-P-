extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(item_home)
	area_exited.connect(item_ran)
	
func item_home(object: toolBasic):
	object._on_board()
func item_ran(object: toolBasic):
	object._off_board()
