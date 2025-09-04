extends Node

@onready var inbox: VBoxContainer = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/LeftBoxWrapper/VBoxContainer/PanelContainer2/MarginContainer/ScrollContainer/VBoxContainer
@onready var decisionButton: Button = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/MarginContainer/DecisionButton
@onready var anim_player: AnimationPlayer = $AnimationPlayer
var emailButton = preload("res://email_button.tscn")
func _ready():
	load_emails()
	connect_buttons()
	anim_player.play("entry")

func load_emails():
	# Removes all buttons from the email inbox
	for child in inbox.get_children():
		child.queue_free()
	# Adds buttons for each email to the inbox
	for emailDecision in Stores.get_all_emails():
		var btn = emailButton.instantiate()
		btn.set_meta("email_decision", emailDecision)
		inbox.add_child(btn)
		btn.initialise(emailDecision.email.title, emailDecision.complete == false)

func connect_buttons():
	var buttons = inbox.get_children()
	for btn in buttons:
		var emailDecision = btn.get_meta("email_decision") as EmailDecision
		btn.pressed.connect(_on_inbox_pressed.bind(emailDecision))

	decisionButton.disabled = true
		

@onready var titleLabel: Label = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/RightBoxWrapper/VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/PanelContainer/TitleWrapper/Title
@onready var senderLabel: Label = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/RightBoxWrapper/VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer2/PanelContainer/SenderWrapper/Sender
@onready var bodyLabel: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/MarginContainer/VBoxContainer2/RightBoxWrapper/VBoxContainer/MarginContainer2/PanelContainer/BodyWrapper/Body
func _on_inbox_pressed(emailDecision: EmailDecision):
	var email = emailDecision.email
	titleLabel.text = email.title
	senderLabel.text = email.sender
	bodyLabel.parse_bbcode(email.body.format(Constants.placeholders))
	
	anim_player.play("slide_in")
	
	if not (emailDecision.complete):
		Stores.set_active_decision(emailDecision)
		Stores.activeDecision.choice_selected.connect(_on_choice_selected)
		decisionButton.disabled = false
	else:
		decisionButton.disabled = true	
	
func _on_choice_selected(choice):
	print("Choice selected")
	match choice.id:
		"Correct":
			pass
			# Set visual element (e.g. green tick?)
		"Incorrect":
			pass
		"Ignore":
			pass
		# ZoomToEmail()
		# DisplayVisual()
	await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text()))# QueueOutcomeText()
	
	if choice is IgnoreChoice:
		print("Ignored!!!")
		SceneTransition.change_scene("res://Scenes/dashboard.tscn", "arrow")
	else:
		SceneTransition.change_scene(Constants.update_meters_scene, "arrow")

	
	
