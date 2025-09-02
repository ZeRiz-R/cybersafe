extends MarginContainer

@onready var chat_name: Label = $HBoxContainer/ChatName
@onready var avatar: PanelContainer = $HBoxContainer/AvatarWrapper/AvatarContainer
@onready var blue_icon: Panel = $Button/BlueIcon
@onready var button: Button = $Button

signal pressed

func _ready():
	button.pressed.connect(_on_button_pressed)

func connect_chat(chat: Chat, incomplete: bool):
	chat_name.text = chat.chatName
	set_meta("chat_obj", chat)
	avatar.select_image(chat.chatName)
	
	if incomplete:
		blue_icon.visible = true
	else:
		blue_icon.visible = false

func _on_button_pressed():
	emit_signal("pressed")
