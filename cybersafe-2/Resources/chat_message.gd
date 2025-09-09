extends Resource

class_name ChatMessage

@export var sender: String
@export var message: String
@export var duration := 1.3
@export var cooldown := 1.2
@export var isPlayerMessage: bool

func _init(_sender = "", _message = "", _isPlayerMessage = false):
	sender = _sender
	message = _message
	isPlayerMessage = _isPlayerMessage
