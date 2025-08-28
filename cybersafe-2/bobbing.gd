extends Node

@export var float_radius := 20.0
@export var float_speed := 1.0
var duration = 1.0
var time := 0.0
var centre := Vector2.ZERO

func _ready():
	centre = get_parent().position
	_float_animate()

func _float_animate():
	var tweenX = get_tree().create_tween().set_loops()
	var tweenY = get_tree().create_tween().set_loops()
	
	# Horizontal
	tweenX.tween_property(get_parent(), "position:x", centre.x + float_radius, float_speed * duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tweenX.tween_property(get_parent(), "position:x", centre.x - float_radius, float_speed * duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Vertical
	# await(get_tree().create_timer(duration / 2).timeout)
	tweenY.tween_property(get_parent(), "position:y", centre.y + float_radius, float_speed * duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tweenY.tween_property(get_parent(), "position:y", centre.y - float_radius, float_speed * duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
