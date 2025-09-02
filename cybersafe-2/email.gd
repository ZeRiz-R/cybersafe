extends Resource
class_name Email

@export var sender: String
@export var title: String
@export_multiline var body: String
var attachments = []

func _init(_sender = "", _title = "", _body = "", _attachments = []):
	sender = _sender
	title = _title
	body = _body
	attachments = _attachments

	
