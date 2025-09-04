extends Control

@onready var update_meters: Control = $UpdateMeters
func _ready():
	update_meters.complete.connect(_on_complete)
	update_meters.update_meters(true)
	await(update_meters.complete)

func _on_complete():
	if Stores.activeDecision is FreeDayEvent:
		Stores.set_active_decision(Stores.activeDecision.selection.followUp)
		SceneTransition.change_scene("res://Scenes/free_day.tscn", "arrow")
	else:
		SceneTransition.change_scene("res://Scenes/dashboard.tscn", "tiles")
