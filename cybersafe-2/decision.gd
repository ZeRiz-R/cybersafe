class_name Decision

var id: String
var choices: Array[Choice]
var prompt: String

func _init(_id: String, _choices: Array[Choice], _prompt: String):
	id = _id
	choices = _choices
	prompt = _prompt

func _select_choice(index: int):
	return choices[index]
	
	
