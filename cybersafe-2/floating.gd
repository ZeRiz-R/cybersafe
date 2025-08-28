extends Node

@export var float_radius := 20.0
@export var float_speed := 1.0
# var duration = 1.0
var time := 0.0
var centre := Vector2.ZERO

func _ready():
	centre = get_parent().position

func _process(delta):
	time += delta * float_speed
	get_parent().position = centre + Vector2(
		sin(time) * float_radius,
		cos(time * 0.75) * float_radius * 0.5
	)
	
