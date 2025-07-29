class_name Decision

var id: String
var choices: Array[Choice]
var prompt: String

func _init(_id: String, _choices: Array, _prompt: String):
	id = _id
	choices = _choices
	_prompt = prompt

func _select_choice(index: int):
	print(choices[index].meter_changes)
	
	
