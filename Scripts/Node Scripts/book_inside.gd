extends Area2D
@onready var book = $"../Book"
var book_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	get_parent().move_child(self, 0)
	book.book_open.connect(book_opened)

func book_opened():
	show()
	move_to_front()
	book_open = true
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE and book_open == true:
			hide()
			get_parent().move_child(self, 0)
			book_open = false
