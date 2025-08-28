extends MarginContainer


@onready var sender: Label = $Wrapper/VBoxContainer/Sender
@onready var message: Label = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/MessageWrapper/BigMessageContainer/MessageContainer/Message
@onready var icon_message_container: HBoxContainer = $Wrapper/VBoxContainer/IconMessageContainer
@onready var message_box_wrapper: MarginContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper
@onready var big_message_container: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/MessageWrapper/BigMessageContainer
@onready var typing: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/TypingWrapper/Typing
@onready var chat_message_container: MarginContainer = $"."
@onready var v_box_container: VBoxContainer = $Wrapper/VBoxContainer
@onready var anim_player: AnimationPlayer = $AnimationPlayer
signal message_sent

@onready var avatar: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/AvatarWrapper/Avatar
func connect_message(chatMessage: ChatMessage):
	sender.text = chatMessage.sender
	message.text = chatMessage.message
	avatar.select_image(chatMessage.sender)
	
	if chatMessage.isPlayerMessage:
		# Swap icon and message, then align right
		icon_message_container.move_child(message_box_wrapper, 0) # Moves message_container to top of hbox
		avatar.select_image(Player.playerIcon)
		sender.text = Player.playerName
		sender.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		
func display_message():
	v_box_container.modulate = Color(1,1,1,1)
	big_message_container.modulate = Color(1,1,1,1)

func queue_message():
	anim_player.play("load_message")
	anim_player.queue("open_typing")
	anim_player.speed_scale = 1.325
	anim_player.queue("typing")
	anim_player.speed_scale = 1
	await(get_tree().create_timer(2).timeout)
	anim_player.play("send_message")
	print("emitting signal message sent")
	emit_signal("message_sent")
