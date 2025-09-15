extends MarginContainer

@export var avatar_name := "Default"

@onready var avatar: PanelContainer = $Button/Avatar
@onready var button: Button = $Button

signal avatar_selected

func _ready():
	avatar.select_image(avatar_name)
	button.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	Player.playerIcon = avatar_name
	Constants.distribute_avatars(avatar_name)
	emit_signal("avatar_selected")
	SceneTransition.change_scene("res://Scenes/dashboard.tscn", "arrow")
