extends MarginContainer

var chat: Chat
var chat_message := preload("res://chat_message.tscn")

@onready var chat_name: Label = $VBoxContainer/HBoxContainer/ChatName
func initialise(_chat: Chat):
	chat = _chat
	chat_name.text = chat.chatName
	load_chats()


@onready var chatArea: VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer
func load_chats():
	# Removes all buttons from the email inbox
	for message in chatArea.get_children():
		message.queue_free()
	# Adds buttons for each email to the inbox
	for message in chat.messages:
		var msg = chat_message.instantiate()
		chatArea.add_child(msg)
		if message.isPlayerMessage:
			msg.size_flags_horizontal = SIZE_SHRINK_END
		msg.connect_message(message)
