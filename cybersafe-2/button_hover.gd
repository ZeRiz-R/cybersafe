extends Button

var hover_scale: Vector2 = Vector2(1.05, 1.05)
var tween_duration := 0.05

func _ready():
	scale = Vector2(1, 1)
	pivot_offset = Vector2(size.x / 2, size.y / 2)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	z_index = 10
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", hover_scale, tween_duration)
	

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), tween_duration)
	z_index = 1
