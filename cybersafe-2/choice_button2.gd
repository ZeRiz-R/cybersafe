extends Control

@onready var texture_button: TextureButton = $TextureButton
@onready var label: Label = $TextureButton/Label
@onready var floating = $Floating

@export var float_radius := 20.0:
	set(value):
		float_radius = value
		if floating:
			floating.float_radius = value

@export var float_speed := 1.0:
	set(value):
		float_speed = value
		if floating:
			floating.float_speed = value

signal pressed  # Custom signal on the root node

func _ready():
	# Forward the internal TextureButton's pressed signal
	texture_button.pressed.connect(_on_internal_pressed)
	# Ensure values are passed at runtime too
	floating.float_radius = float_radius
	floating.float_speed = float_speed

func _on_internal_pressed():
	emit_signal("pressed")

func set_label_text(new_text: String):
	label.text = new_text
