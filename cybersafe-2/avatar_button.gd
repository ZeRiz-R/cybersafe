extends Button

var hover_scale: Vector2 = Vector2(1.05, 1.05)
var tween_duration := 0.05

var skew
var sb: StyleBoxFlat
var wobble_tween = null

# Buttons


func _ready():
	scale = Vector2(1, 1)
	pivot_offset = Vector2(size.x / 2, size.y / 2)
	
	sb = get_theme_stylebox("hover")
	skew = sb.skew
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	z_index = 10
	var tween = get_tree().create_tween()
	animate_outer()
	tween.tween_property(self, "scale", hover_scale, tween_duration)
	

func _on_mouse_exited():
	wobble_tween.kill()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), tween_duration)
	z_index = 0
	
var wobble := Vector2(-0.73, -0.53)
func animate_outer():
	wobble_tween = get_tree().create_tween().set_loops()
	wobble_tween.tween_property(sb, "skew", wobble, 0.13)
	wobble_tween.tween_property(sb, "skew", skew, 0.13)
