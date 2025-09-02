extends VBoxContainer

var chat_button := preload("res://chat_button.tscn")
signal open_chat(chat: Chat)

func _ready():
	load_chats()
	connect_buttons()
	
@onready var inbox: VBoxContainer = $ScrollContainer/VBoxContainer
func load_chats():
	# Removes all buttons from the email inbox
	for child in inbox.get_children():
		child.queue_free()
	# Adds buttons for each email to the inbox
	for chatName in Stores.get_all_chat_names():
		var chat = Stores.chatStore.get(chatName)
		var btn = chat_button.instantiate()
		inbox.add_child(btn)
		btn.connect_chat(chat, chat.currentDecision.complete == false)

func connect_buttons():
	var buttons = inbox.get_children()
	for btn in buttons:
		var chat = btn.get_meta("chat_obj") as Chat
		btn.pressed.connect(_on_chatbtn_pressed.bind(chat))

func _on_chatbtn_pressed(chat: Chat):
	print("Opening chat: " + chat.chatName)
	Stores.set_active_decision(chat.currentDecision)
	emit_signal("open_chat", chat)
