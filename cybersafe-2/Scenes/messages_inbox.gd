extends Control

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var chat_list: VBoxContainer = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/ChatList
@onready var chat_screen_wrapper: Control = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/ChatScreenWrapper
@onready var chat_screen: MarginContainer
@onready var displayArea: PanelContainer = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer
@onready var decision_button: Button = $MarginContainer/HBoxContainer/VBoxContainer3/DecisionButton
func _ready():
	anim_player.play("slide_in")
	chat_screen_wrapper.visible = false
	chat_screen = chat_screen_wrapper.get_child(0)
	chat_list.open_chat.connect(_on_chat_pressed)
	decision_button.disabled = true

func _on_chat_pressed(chat: Chat):
	chat_screen_wrapper.visible = true
	Stores.activeDecision.choice_selected.connect(_on_choice_selected)
	
	if not Stores.activeDecision.complete:
		decision_button.disabled = false
	else:
		decision_button.disabled = true
		
	chat_screen.initialise(chat)
	anim_player.play("open_chat")


func _on_choice_selected(choice: Choice):
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
	await(Stores.activeDecision.display_outcome_text(get_tree().current_scene))# QueueOutcomeText()
		# CompleteDecision()
	SceneTransition.change_scene("res://Scenes/update_meters.tscn")
	# UpdateMetersVisual() Maybe different scene
