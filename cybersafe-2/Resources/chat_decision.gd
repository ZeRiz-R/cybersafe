class_name ChatDecision extends Decision

@export var chatName: String
@export var messages: Array[ChatMessage]
@export var noDecision: bool = false

func _init(_id = "", _date = Vector2i.ZERO, _prompt: Array[TextBoxEntry] = [], _tip = "", _choices: Array[Choice] = [], _chatName = "", _messages: Array[ChatMessage] = []):
	super._init(_id, _date, _prompt, _tip, _choices)
	chatName = _chatName
	messages = _messages

func complete_decision():
	super.complete_decision()
	Stores.popUnreadChat()
