extends Button

@onready var chat_name: Label = $HBoxContainer/ChatName
@onready var avatar: PanelContainer = $HBoxContainer/AvatarWrapper/AvatarContainer
func connect_chat(chat: Chat):
	chat_name.text = chat.chatName
	set_meta("chat_obj", chat)
	avatar.select_image(chat.chatName)
