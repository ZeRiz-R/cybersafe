class_name Choice
	
var text: String
# map name to change in meter e.g. "social_trust", -5
var meter_changes: Dictionary

func _init(_text: String, _meter_changes: Dictionary):
	text = _text
	meter_changes = _meter_changes
