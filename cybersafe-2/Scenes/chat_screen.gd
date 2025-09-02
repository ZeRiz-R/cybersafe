extends MarginContainer

var chat: Chat
var chat_message := preload("res://chat_message.tscn")
signal close_chat

@onready var chat_name: Label = $VBoxContainer/MarginContainer/HBoxContainer/ChatName
@onready var back_button: TextureButton = $VBoxContainer/MarginContainer/HBoxContainer/BackButton
@onready var avatar: PanelContainer = $VBoxContainer/MarginContainer/HBoxContainer/AvatarWrapper/Avatar
func _ready():
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	emit_signal("close_chat")

func initialise(_chat: Chat):
	chat = _chat
	chat_name.text = chat.chatName
	avatar.select_image(chat.chatName)
	load_chats()
	queue_messages()


@onready var chatArea: VBoxContainer = $VBoxContainer/MarginContainer2/ScrollContainer/VBoxContainer
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
		msg.display_message()
		#await(get_tree().create_timer(0.3).timeout)
		#msg.queue_message()
		#await(msg.message_sent)
		
func followUp(messages: Array[ChatMessage]):
	for message in messages:
		chat.queue_message(message)
	await(queue_messages())

@onready var scroll_container: ScrollContainer = $VBoxContainer/MarginContainer2/ScrollContainer
func queue_messages():
	while not chat.unsent.is_empty():
		var message = chat.unsent[0]
		var msg = chat_message.instantiate()
		chatArea.add_child(msg)
		if message.isPlayerMessage:
			msg.size_flags_horizontal = SIZE_SHRINK_END
		msg.connect_message(message)
		await(get_tree().create_timer(1.0).timeout)
		scroll_down()
		if is_instance_valid(msg):
			msg.queue_message(message.duration)
			await(msg.message_sent)
			chat.dequeue_message()
	await(get_tree().create_timer(1.5).timeout)

func scroll_down():
		await get_tree().process_frame
		var tween = get_tree().create_tween()
		tween.tween_property(scroll_container, "scroll_vertical", scroll_container.get_v_scroll_bar().max_value, 0.3)
