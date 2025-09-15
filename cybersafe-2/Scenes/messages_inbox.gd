extends Control

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var chat_list: VBoxContainer = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/ChatList
@onready var chat_screen_wrapper: Control = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer/ChatScreenWrapper
@onready var chat_screen: MarginContainer
@onready var displayArea: PanelContainer = $MarginContainer/HBoxContainer/PhoneWrapper/PhoneContainer/PanelContainer/MarginContainer/VBoxContainer/PanelContainer
@onready var decisionButton: MarginContainer = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/DecisionButtonWrapper/DecisionButton
func _ready():
	anim_player.play("slide_in")
	chat_screen_wrapper.visible = false
	chat_screen = chat_screen_wrapper.get_child(0)
	chat_list.open_chat.connect(_on_chat_pressed)
	chat_screen.close_chat.connect(_on_chat_closed)
	chat_screen.finished_queueing.connect(_on_queue_finished)
	decisionButton.hide_instant()

func _on_queue_finished():
	if Stores.activeDecision.noDecision:
		anim_player.play("queue_finished")
		Stores.activeDecision.complete_decision()
		if Stores.activeDecision.changes:
			await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text()))# QueueOutcomeText()
			SceneTransition.change_scene(Constants.update_meters_scene, "arrow")
	elif not Stores.activeDecision.complete:
		decisionButton.show_animate()

func _on_chat_pressed(chat: Chat):
	chat_screen_wrapper.visible = true
	Stores.activeDecision.choice_selected.connect(_on_choice_selected)
	
	if not Stores.activeDecision.complete and len(chat.unsent) == 0:
		decisionButton.show_animate()
	
	#if not Stores.activeDecision.complete or not Stores.activeDecision.noDecision:
		#decision_button.disabled = false
	#else:
		#decision_button.disabled = true
		
	chat_screen.initialise(chat)
	anim_player.play("open_chat")

func _on_chat_closed():
	chat_list.refresh_unread()
	anim_player.play_backwards("open_chat")
	decisionButton.hide_animate()
	await(anim_player.animation_finished)
	chat_screen_wrapper.visible = false

func _on_choice_selected(choice: ChatChoice):
	print("Choice selected")
	await(chat_screen.followUp(choice.followUpMessages))
		# ZoomToEmail()
		# DisplayVisual()
	await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text()))# QueueOutcomeText()
		# CompleteDecision()
	SceneTransition.change_scene(Constants.update_meters_scene, "arrow")
	# Constants.overlay_scene(Constants.update_meters_scene)
	# UpdateMetersVisual() Maybe different scene
