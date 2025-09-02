extends GameEvent

class_name IgnoreEvent

@export var outcomeText: Array[String]
var attachedDecision: Decision

func _init(_id = "", _date = Vector2i.ZERO, _meterChanges = {}, _outcomeText: Array[String] = [""]):
	super._init(_id, _date)
	outcomeText = _outcomeText

func attach_decision(_decision: Decision):
	attachedDecision = _decision
