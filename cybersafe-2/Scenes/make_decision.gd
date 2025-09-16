extends Control

@onready var choiceButtons: Control = $ChoiceButtons
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	print("yahoo")
	load_choices(Stores.activeDecision)
	connect_buttons()
	anim_player.play("transition_in")

func load_choices(decision: Decision):
	print("Rah")
	var buttons = choiceButtons.get_children()
	var choices = decision.choices
	for i in range(len(buttons)):
		if i < len(choices):
			buttons[i].set_label_text(choices[i].text)
			buttons[i].set_meta("choice", choices[i])
		else:
			buttons[i].set_label_text("No choice. Please don't click.")
			buttons[i].visible = false
		
@onready var closeButton: Button = $MarginContainer/Button
func connect_buttons():
	var buttons = choiceButtons.get_children()
	for btn in buttons:
		btn.pressed.connect(_on_button_pressed.bind(btn.get_meta("choice")))
	closeButton.pressed.connect(close)

func _on_button_pressed(choice: Choice):
	# Player.update_meters(choice.meter_changes)
	Stores.activeDecision.select_choice(choice)
	if choice is IgnoreChoice:
		choice.add_followup_event()
	Stores.activeDecision.complete_decision()
	# Stores.activeDecision = null
	close()
		

func close():
	queue_free()
