class_name ChatDecision extends Decision

var chatName: String
var messages: Array[ChatMessage]

func _init(_id: String, _date: Vector2i, _prompt: String, _tip: String, _choices: Array[Choice], _chatName: String, _messages: Array[ChatMessage]):
	super._init(_id, _date, _prompt, _tip, _choices)
	chatName = _chatName
	messages = _messages

func complete_decision():
	super.complete_decision()
	Stores.popUnreadChat()
