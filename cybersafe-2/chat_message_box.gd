extends MarginContainer


@onready var sender: Label = $VBoxContainer/Sender
@onready var message: Label = $VBoxContainer/IconMessageContainer/BigMessageContainer/MessageContainer/Message
@onready var icon_message_container: HBoxContainer = $VBoxContainer/IconMessageContainer
@onready var big_message_container: PanelContainer = $VBoxContainer/IconMessageContainer/BigMessageContainer
@onready var chat_message_container: MarginContainer = $"."

func connect_message(chatMessage: ChatMessage):
	sender.text = chatMessage.sender
	message.text = chatMessage.message
	if chatMessage.isPlayerMessage:
		# Swap icon and message, then align right
		icon_message_container.move_child(big_message_container, 0) # Moves message_container to top of hbox
		sender.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
