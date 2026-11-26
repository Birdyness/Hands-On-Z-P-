extends Sprite2D

func _process(_delta):
	var view_size = get_viewport_rect().size
	var tex_size = texture.get_size()
	scale = view_size * 1.05 / tex_size 
