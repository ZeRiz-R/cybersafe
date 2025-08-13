extends Node

class_name ChatMessage

var sender: String
var message: String
var isPlayerMessage: bool

func _init(_sender: String, _message: String, _isPlayerMessage):
	sender = _sender
	message = _message
	isPlayerMessage = _isPlayerMessage
