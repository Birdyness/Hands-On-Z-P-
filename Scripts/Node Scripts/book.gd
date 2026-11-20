extends Area2D
signal book_open
@onready var bookInside = $"../BookInside"

func _ready() -> void:
	bookInside.book_close.connect(book_closed)
	
func _on_button_pressed() -> void:
	book_open.emit()
	self.hide()
	
func book_closed():
	self.show()
