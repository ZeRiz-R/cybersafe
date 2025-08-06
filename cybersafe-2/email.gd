class_name Email

var sender: String
var title: String
var body: String
var attachments = []

func _init(_sender: String, _title: String, _body: String, _attachments: Array):
	sender = _sender
	title = _title
	body = _body
	attachments = _attachments

	
