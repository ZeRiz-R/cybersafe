extends GameEvent

class_name Decision

var choices: Array[Choice]
var selection: Choice
var prompt: String
var tip: String

var complete: bool

signal choice_selected(choice: Choice)

func _init(_id: String, _date: Vector2i, _prompt: String, _tip: String, _choices: Array[Choice]):
	super._init(_id, _date)
	choices = _choices
	prompt = _prompt
	selection = choices[0]
	tip = _tip
	complete = false
	
func select_choice(choice):
	print("Selected choice for " + id)
	selection = choice
	if choice is IgnoreChoice:
		choice.attach_decision(self)
	emit_signal("choice_selected", choice)
	
func get_outcome_text():
	return selection.outcomeText

func complete_decision():
	complete = true
	

	
	
