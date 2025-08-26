extends GameEvent

class_name IgnoreEvent

var meterChanges: Dictionary
var outcomeText: Array[String]
var attachedDecision: Decision

func _init(_id: String, _date: Vector2i, _meterChanges: Dictionary, _outcomeText: Array[String]):
	super._init(_id, _date)
	meterChanges = _meterChanges
	outcomeText = _outcomeText

func attach_decision(_decision: Decision):
	attachedDecision = _decision
