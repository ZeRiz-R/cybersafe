extends Choice
class_name IgnoreChoice

@export var followUpIgnore: IgnoreEvent

func _init(_id = "", _text = "", _meterChanges = {}, _outcomeText: Array[TextBoxEntry] = [], _outcomeDate = Vector2.ZERO, _outcomeText2: Array[TextBoxEntry] = []) -> void:
	super._init(_id, _text, _meterChanges, _outcomeText)
	followUpIgnore = IgnoreEvent.new(_id, _outcomeDate, meterChanges, _outcomeText2)

func add_followup_event():
	Calendar.add_event(followUpIgnore.date.x, followUpIgnore.date.y, followUpIgnore)
	Stores.queueIgnoredEvent(followUpIgnore.date)
	
func attach_decision(_decision: Decision):
	followUpIgnore.attach_decision(_decision)
	
	
