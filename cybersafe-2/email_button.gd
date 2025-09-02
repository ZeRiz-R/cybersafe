extends MarginContainer

@onready var subject_label: Label = $Button/MarginContainer/SubjectLabel
@onready var button: Button = $Button
@onready var red_icon: Panel = $Button/RedIcon
signal pressed

func _ready():
	button.pressed.connect(_on_button_pressed)

func initialise(text: String, unread: bool):
	subject_label.text = text
	if unread:
		red_icon.visible = true
	else:
		red_icon.visible = false

func _on_button_pressed():
	emit_signal("pressed")
