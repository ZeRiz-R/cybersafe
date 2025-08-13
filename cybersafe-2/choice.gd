class_name Choice

var id: String	# Correct, Incorrect, Ignore for emails
var text: String
var outcomeText: Array[String]

# map name to change in meter e.g. "social_trust", -5
var meter_changes: Dictionary

func _init(_id: String, _text: String, _meter_changes: Dictionary, _outcomeText: Array[String]):
	id = _id
	text = _text
	meter_changes = _meter_changes
	outcomeText = _outcomeText
