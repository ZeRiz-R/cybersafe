extends Resource

class_name Choice

@export var id: String	# Correct, Incorrect, Ignore for emails
@export var text: String
@export var outcomeText: Array[TextBoxEntry]

# map name to change in meter e.g. "social_trust", -5
@export var meterChanges: Dictionary = {
	"CK": {"Value": 0, "Reason": ""},
	"DH": {"Value": 0, "Reason": ""},
	"DS": {"Value": 0, "Reason": ""},
	"ST": {"Value": 0, "Reason": ""},
	"S": {"Value": 0, "Reason": ""},
}

@export var followUp: Array[GameEvent] = []

func _init(_id = "", _text = "", _meterChanges = {}, _outcomeText: Array[TextBoxEntry] = []):
	id = _id
	text = _text
	meterChanges = _meterChanges
	outcomeText = _outcomeText
