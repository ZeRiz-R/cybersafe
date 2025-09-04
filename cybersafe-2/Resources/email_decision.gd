class_name EmailDecision extends Decision

@export var email: Email

func _init(_id = "", _date = Vector2i.ZERO, _prompt: Array[TextBoxEntry] = [], _tip = "", _choices: Array[Choice] = [], _email: Email = null):
	super._init(_id, _date, _prompt, _tip, _choices)
	email = _email

func complete_decision():
	super.complete_decision()
	Stores.popUnreadEmail()
