extends Resource
class_name TextBoxEntry

@export var speaker: String = "Mysterious Voice"
@export var text: String
@export var isPlayerText := false

func _init(_speaker: String = "", _text: String = ""):
	speaker = _speaker
	text = _text
