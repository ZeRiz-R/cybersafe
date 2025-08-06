extends Node

@onready var inbox: VBoxContainer = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/VBoxContainer/PanelContainer2/PanelContainer/ScrollContainer/VBoxContainer
@onready var decisionButton: Button = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/MarginContainer/Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	load_emails()
	connect_buttons()

func load_emails():
	# Removes all buttons from the email inbox
	for child in inbox.get_children():
		child.queue_free()
	# Adds buttons for each email to the inbox
	for emailDecision in Stores.get_all_emails():
		var btn = Button.new()
		btn.text = emailDecision.email.sender
		btn.set_meta("email_decision", emailDecision)
		inbox.add_child(btn)

func connect_buttons():
	var buttons = inbox.get_children()
	for btn in buttons:
		var emailDecision = btn.get_meta("email_decision") as EmailDecision
		btn.pressed.connect(_on_inbox_pressed.bind(emailDecision))

	decisionButton.pressed.connect(_on_decision_pressed)
	decisionButton.disabled = true
		
@onready var titleLabel: Label = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer/PanelContainer/Label
@onready var senderLabel: Label = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer/MarginContainer2/PanelContainer/Label
@onready var bodyLabel: Label = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/MarginContainer2/PanelContainer/Label
func _on_inbox_pressed(emailDecision: EmailDecision):
	var email = emailDecision.email
	titleLabel.text = email.title
	senderLabel.text = email.sender
	bodyLabel.text = email.body
	
	anim_player.play("slide_in")
	
	if not (emailDecision.complete):
		Stores.set_active_decision(emailDecision)
		decisionButton.disabled = false
	else:
		decisionButton.disabled = true
	
func _on_decision_pressed():
	print("making a decision")
	var decisionScreen = preload("res://Scenes/make_decision.tscn").instantiate()
	var uiLayer = get_node(".")
	uiLayer.add_child(decisionScreen)
	decisionButton.disabled = true
	
