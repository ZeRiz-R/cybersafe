class_name Chat

var chatName: String
var icon # Don't know what type? Image? String?

var messages: Array[ChatMessage]
var unsent: Array[ChatMessage]

var currentDecision: Decision

func _init(_chatName: String, _messages: Array[ChatMessage]):
	chatName = _chatName
	messages = _messages

func queue_message(message: ChatMessage):
	unsent.append(message)

func add_message(message: ChatMessage):
	messages.append(message)
	
func dequeue_message():
	var msg = unsent.pop_front()
	messages.append(msg)
