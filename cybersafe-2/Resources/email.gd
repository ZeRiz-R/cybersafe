extends Resource
class_name Email

@export var sender: String
@export var title: String
@export_multiline var body: String
@export var attachments: Array[String] = []

func _init(_sender = "", _title = "", _body = "", _attachments: Array[String] = []):
	sender = _sender
	title = _title
	body = _body
	attachments = _attachments

	
