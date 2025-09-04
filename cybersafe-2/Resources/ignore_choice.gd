extends Choice
class_name IgnoreChoice

@export var followUp2: IgnoreEvent

func _init(_id = "", _text = "", _meterChanges = {}, _outcomeText: Array[TextBoxEntry] = [], _outcomeDate = Vector2.ZERO, _outcomeText2: Array[TextBoxEntry] = []) -> void:
	super._init(_id, _text, _meterChanges, _outcomeText)
	followUp = IgnoreEvent.new(_id, _outcomeDate, meterChanges, _outcomeText2)

func add_followup_event():
	Calendar.add_event(followUp.date.x, followUp.date.y, followUp)
	Stores.queueIgnoredEvent(followUp.date)
	
func attach_decision(_decision: Decision):
	followUp.attach_decision(_decision)
	
	
