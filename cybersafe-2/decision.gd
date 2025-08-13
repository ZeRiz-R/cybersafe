extends Node
class_name Decision

var id: String
var choices: Array[Choice]
var selection: Choice
var prompt: String

var complete: bool

signal choice_selected(choice: Choice)

func _init(_id: String, _prompt: String, _choices: Array[Choice]):
	id = _id
	choices = _choices
	prompt = _prompt
	selection = choices[0]
	complete = false
	
func select_choice(choice: Choice):
	print("Selected choice for " + id)
	selection = choice
	emit_signal("choice_selected", choice)
	
func complete_decision():
	complete = true
	
func display_outcome_text(scene_root: Node):
	var textbox = preload("res://Scenes/text_box.tscn").instantiate()
	scene_root.add_child(textbox)
	await(textbox.available)
	textbox.queue_array(Stores.activeDecision.selection.outcomeText)
	await(textbox.tree_exited)
	
	
