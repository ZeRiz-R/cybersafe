extends Node

var emailStore := []
var messageStore := []

var activeDecision: Decision

func _init() -> void:
	activeDecision = Constants.dummyDecision

func add_email(emailDecision: EmailDecision):
	emailStore.append(emailDecision)

func get_all_emails() -> Array:
	return emailStore
	
func set_active_decision(decision: Decision):
	activeDecision = decision
	
