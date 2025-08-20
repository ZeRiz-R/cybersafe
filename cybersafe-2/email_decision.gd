class_name EmailDecision extends Decision

var email: Email

func _init(_id: String, _prompt: String, _tip: String, _choices: Array[Choice], _email: Email):
	super._init(_id, _prompt, _tip, _choices)
	email = _email

func complete_decision():
	super.complete_decision()
	Stores.popUnreadEmail()
