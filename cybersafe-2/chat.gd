class_name Chat

var chatName: String
var icon # Don't know what type? Image? String?

var messages: Array[ChatMessage]
var unsent: Array[ChatMessage]

var currentDecision: Decision

func _init(_chatName: String, _messages: Array[ChatMessage]):
	chatName = _chatName
	messages = _messages

func add_message(message: ChatMessage):
	messages.append(message)
