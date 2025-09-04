extends Resource
class_name RandomOutcome

@export var meterChanges: Dictionary = {
	"CK": {"Value": 0, "Reason": ""},
	"DH": {"Value": 0, "Reason": ""},
	"DS": {"Value": 0, "Reason": ""},
	"ST": {"Value": 0, "Reason": ""},
	"S": {"Value": 0, "Reason": ""},
}

@export var outcomeText: Array[TextBoxEntry]

@export var update := true

@export_range(0.0, 1.0, 0.01) var probability = 1.0
