extends Button

@onready var chat_name: Label = $HBoxContainer/ChatName
func connect_chat(chat: Chat):
	chat_name.text = chat.chatName
	set_meta("chat_obj", chat)
