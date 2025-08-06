extends Node2D

var hover_scale: Vector2 = Vector2(1.05, 1.05)
var skew_scale := tan(deg_to_rad(30.0))
var tween_duration := 0.05

var time := 0.0
var center := Vector2.ZERO

@onready var area_2d: Area2D = $Area2D
@onready var choice_button: Sprite2D = $Area2D/ChoiceButton
func _ready():
	area_2d.scale = Vector2(1, 1)
	center = position  # start position as center
	print("Choice Button initialised")
	area_2d.input_event.connect(_on_area_2d_input_event)
	area_2d.mouse_entered.connect(_on_area_2d_mouse_entered)
	area_2d.mouse_exited.connect(_on_area_2d_mouse_exited)
	
@export var float_radius := 20.0
@export var float_speed := 1.0


func _process(delta):
	time += delta * float_speed
	position = center + Vector2(
		sin(time) * float_radius,
		cos(time * 0.75) * float_radius * 0.5
	)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("awesine")
		# Select Choice


func _on_area_2d_mouse_entered() -> void:
	z_index = 10
	var tween = get_tree().create_tween()
	tween.tween_property(area_2d, "scale", hover_scale, tween_duration)
	# tween.tween_property(area_2d, "skew", skew_scale, tween_duration)

func _on_area_2d_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(area_2d, "scale", Vector2(1, 1), tween_duration)
	# tween.tween_property(area_2d, "skew", 0.0, tween_duration)
	z_index = 1
