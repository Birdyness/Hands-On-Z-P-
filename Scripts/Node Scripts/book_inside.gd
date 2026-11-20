extends Area2D
@onready var book = $"../Book"
var book_open = false
signal book_close

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	get_parent().move_child(self, 0)
	book.book_open.connect(book_opened)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_escape") and book_open == true:
		hide()
		get_parent().move_child(self, 0)
		book_open = false
		book_close.emit()
		
func book_opened():
	show()
	move_to_front()
	book_open = true
	
