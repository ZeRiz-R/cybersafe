extends Label

const goodColour := Color(0x5bdd00ff)
const badColour := Color(0xd30004ff)

func _ready():
	visible = false
	
func assign_text(_text: String, good: bool):
	if good:
		label_settings.outline_color = goodColour
	else:
		label_settings.outline_color = badColour
	
	text = _text
	visible = true
	modulate.a = 0.0
	
	var tween = get_tree().create_tween().set_parallel()
	print(visible, modulate, text)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.tween_property(self, "position:y", position.y - 10, 0.3).set_ease(Tween.EASE_IN)
	print(modulate)
