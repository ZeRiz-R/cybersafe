extends Control

var activeD: Decision

func _ready():
	Stores.activeDecision.choice_selected.connect(_on_choice_selected)
	await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_prompt(), false))# QueueOutcomeText()
	make_decision()
	
func _on_choice_selected(choice: Choice):
	await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text(), false))# QueueOutcomeText()
	var um = Constants.overlay_scene(Constants.update_meters_overlay) as UpdateMeters
	um.update_meters(false)
	await(um.complete)
	
	if choice is RandomChoice:
		choice.set_outcome()

	await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text(), false))# QueueOutcomeText()
	um = Constants.overlay_scene(Constants.update_meters_overlay) as UpdateMeters
	um.update_meters(true)
	await(um.complete)
	
	Stores.set_free_event(null)
	SceneTransition.change_scene("res://Scenes/dashboard.tscn", "tiles")
	
		

func make_decision():
	Constants.overlay_scene(Constants.make_decision_scene)
