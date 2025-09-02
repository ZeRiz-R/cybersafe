extends Resource

class_name GameEvent

@export var id: String
@export var date: Vector2i

func _init(_id = "default", _date = Vector2i(1,1)):
	id = _id
	date = _date
	
