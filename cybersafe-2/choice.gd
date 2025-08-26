class_name Choice

var id: String	# Correct, Incorrect, Ignore for emails
var text: String
var outcomeText: Array[String]

# map name to change in meter e.g. "social_trust", -5
var meterChanges: Dictionary

func _init(_id: String, _text: String, _meterChanges: Dictionary, _outcomeText: Array[String]):
	id = _id
	text = _text
	meterChanges = _meterChanges
	outcomeText = _outcomeText
