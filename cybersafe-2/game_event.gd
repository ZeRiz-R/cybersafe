extends Resource

class_name GameEvent

@export var id: String
@export var date: Vector2i
@export var changes: bool = false # Only relevant for decisions with no choices (i.e. pure events)
@export var meterChanges: Dictionary = {
	"CK": {"Value": 0, "Reason": ""},
	"DH": {"Value": 0, "Reason": ""},
	"DS": {"Value": 0, "Reason": ""},
	"ST": {"Value": 0, "Reason": ""},
	"S": {"Value": 0, "Reason": ""},
}

@export var outcomeTextMain: Array[TextBoxEntry] = []

func _init(_id = "default", _date = Vector2i(1,1)):
	id = _id
	date = _date
	
func get_outcome_text():
	return outcomeTextMain
	
