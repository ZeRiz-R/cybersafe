extends GameEvent

class_name Decision

@export var choices: Array[Choice]
var selection: Choice
@export var prompt: String
@export var tip: String

var complete: bool

signal choice_selected(choice: Choice)

func _init(_id = "", _date = Vector2i.ZERO, _prompt = "", _tip = "", _choices: Array[Choice] = []):
	super._init(_id, _date)
	choices = _choices
	prompt = _prompt
	selection = Choice.new()
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
	

	
	
