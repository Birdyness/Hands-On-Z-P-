extends toolBasic
signal book_open

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E and touching == true:
			book_open.emit()
