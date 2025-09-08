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

var prev_sender = ""
var current_vb = null
@onready var chatArea: VBoxContainer = $VBoxContainer/MarginContainer2/ScrollContainer/VBoxContainer
func load_chats():
	# Removes all buttons from the email inbox
	for message in chatArea.get_children():
		message.queue_free()
	# Adds buttons for each email to the inbox
	var msg = null
	for message in chat.messages:
		if message.sender != prev_sender:
			add_sender_vbox()
			prev_sender = message.sender
			msg = instantiate_message(message, current_vb)
		else:
			msg = instantiate_message(message, current_vb)
			msg.hide_sender_info()
		msg.display_message()

func add_sender_vbox():
	var vb = VBoxContainer.new()
	vb.set_anchors_and_offsets_preset(PRESET_FULL_RECT)
	vb.add_theme_constant_override("separation", -50)
	current_vb = vb
	chatArea.add_child(vb)

func instantiate_message(message, area):
	var msg = chat_message.instantiate()
	area.add_child(msg)
	if message.isPlayerMessage:
		msg.size_flags_horizontal = SIZE_SHRINK_END
	msg.connect_message(message)
	return msg

func followUp(messages: Array[ChatMessage]):
	for message in messages:
		chat.queue_message(message)
	await(queue_messages())

@onready var scroll_container: ScrollContainer = $VBoxContainer/MarginContainer2/ScrollContainer
func queue_messages():
	while not chat.unsent.is_empty():
		var message = chat.unsent[0]
		var msg = null
		
		print("Prev: " + prev_sender + " New: " + message.sender)
		if message.sender != prev_sender:
			print("different guy")
			prev_sender = message.sender
			add_sender_vbox()
			msg = instantiate_message(message, current_vb)
		else:
			print("same guy")
			msg = instantiate_message(message, current_vb)
			msg.hide_sender_info()
		await(get_tree().create_timer(message.cooldown).timeout)
		
		scroll_down()
		if is_instance_valid(msg):
			msg.queue_message(message.duration)
			await(msg.message_sent)
			chat.dequeue_message()
			
	if Stores.activeDecision.noDecision:
		Stores.activeDecision.complete_decision()
	await(get_tree().create_timer(1.5).timeout)

func scroll_down():
		await get_tree().process_frame
		var tween = get_tree().create_tween()
		tween.tween_property(scroll_container, "scroll_vertical", scroll_container.get_v_scroll_bar().max_value, 0.3)
