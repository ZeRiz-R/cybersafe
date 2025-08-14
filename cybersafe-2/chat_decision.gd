class_name ChatDecision extends Decision

var chatName: String
var messages: Array[ChatMessage]

func _init(_id: String, _prompt: String, _choices: Array[Choice], _chatName: String, _messages: Array[ChatMessage]):
	super._init(_id, _prompt, _choices)
	chatName = _chatName
	messages = _messages

func complete_decision():
	super.complete_decision()
	Stores.popUnreadChat()
