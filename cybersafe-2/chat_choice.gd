extends Choice
class_name ChatChoice

@export var followUpMessages: Array[ChatMessage] = []

func queue_followups(chat: Chat):
	for message in followUpMessages:
		chat.queue_message(message)
