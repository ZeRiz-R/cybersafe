class_name GameEvent

var name: String
var date: Vector2i
var event # A decision/minigame/email/message (use typeof to adjust output)

func _init(_name: String, _date: Vector2i, _event):
	name = _name
	date = _date
	event = _event
	
