extends MarginContainer


@onready var sender: Label = $Wrapper/VBoxContainer/Sender
@onready var message: Label = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/MessageWrapper/BigMessageContainer/MessageContainer/Message
@onready var icon_message_container: HBoxContainer = $Wrapper/VBoxContainer/IconMessageContainer
@onready var message_box_wrapper: MarginContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper
@onready var big_message_container: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/MessageWrapper/BigMessageContainer
@onready var black_panel: Panel = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/MessageWrapper/BigMessageContainer/BlackPanel
@onready var typing: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/MessageBoxWrapper/TypingWrapper/Typing
@onready var chat_message_container: MarginContainer = $"."
@onready var v_box_container: VBoxContainer = $Wrapper/VBoxContainer
@onready var anim_player: AnimationPlayer = $AnimationPlayer
signal message_sent

@onready var avatar: PanelContainer = $Wrapper/VBoxContainer/IconMessageContainer/AvatarWrapper/Avatar
func connect_message(chatMessage: ChatMessage):
	sender.text = chatMessage.sender.format(Constants.placeholders)
	message.text = chatMessage.message.format(Constants.placeholders)
	avatar.select_image(chatMessage.sender)
	
	if chatMessage.isPlayerMessage:
		# Swap icon and message, then align right
		icon_message_container.move_child(message_box_wrapper, 0) # Moves message_container to top of hbox
		avatar.select_image(Player.playerIcon)
		sender.text = Player.playerName
		message.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		sender.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		
		var wsb = big_message_container.get_theme_stylebox("panel") as StyleBoxFlat
		wsb.skew = Vector2(-wsb.skew.x, -wsb.skew.y)
		var bsb = black_panel.get_theme_stylebox("panel") as StyleBoxFlat
		bsb.skew = Vector2(-bsb.skew.x, -bsb.skew.y)
		
func display_message():
	v_box_container.modulate = Color(1,1,1,1)
	big_message_container.modulate = Color(1,1,1,1)

func queue_message(duration: float):
	anim_player.play("load_message")
	anim_player.queue("open_typing")
	anim_player.speed_scale = 1.25
	anim_player.queue("typing")
	await(get_tree().create_timer(duration).timeout)
	anim_player.speed_scale = 1
	anim_player.play("send_message")
	print("emitting signal message sent")
	emit_signal("message_sent")
