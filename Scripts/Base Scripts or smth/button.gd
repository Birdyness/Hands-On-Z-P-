extends Button

@export var buttonSprite: Sprite2D
@export var btnTweenDuration = 0.1
@export var btnTweenMagnitude = 0.01

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	button_down.connect(on_mouse_down)
	button_up.connect(on_mouse_entered)

func on_mouse_entered():
	create_tween().tween_property(buttonSprite, "scale", Vector2(0.6 + btnTweenMagnitude, 0.6 + btnTweenMagnitude), btnTweenDuration)

func on_mouse_exited():
	create_tween().tween_property(buttonSprite, "scale", Vector2(0.6, 0.6), btnTweenDuration)

func on_mouse_down():
	create_tween().tween_property(buttonSprite, "scale", Vector2(0.6 - btnTweenMagnitude, 0.6 - btnTweenMagnitude), btnTweenDuration)
