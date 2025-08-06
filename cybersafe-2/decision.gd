class_name Decision

var id: String
var choices: Array[Choice]
var prompt: String

var complete: bool

func _init(_id: String, _prompt: String, _choices: Array[Choice]):
	id = _id
	choices = _choices
	prompt = _prompt
	complete = false

func _select_choice(index: int):
	return choices[index]
	
func complete_decision():
	complete = true
	
	
