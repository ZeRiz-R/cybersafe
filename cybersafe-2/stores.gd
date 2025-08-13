extends Node

var emailStore := []
var chatStore := {}
var chatsInOrder := []

var activeDecision: Decision

func _init() -> void:
	activeDecision = Constants.dummyDecision

func add_email(emailDecision: EmailDecision):
	emailStore.append(emailDecision)
	
func get_all_emails() -> Array:
	return emailStore
	
func add_message(chatName: String, message: ChatMessage):
	print("adding message " + message.message)
	var chat = chatStore.get(chatName)
	if not chat:
		chatStore[chatName] = Chat.new(chatName, [])
		chat = chatStore.get(chatName)
	
	chat.add_message(message)
	chatsInOrder.erase(chatName)
	chatsInOrder.insert(0, chatName)

func add_chat_event(chatDecision: ChatDecision):
	var chatName = chatDecision.chatName
	for message in chatDecision.messages:
		add_message(chatName, message)
	Stores.chatStore[chatName].currentDecision = chatDecision
	
func add_chat(chat: Chat):
	chatStore[chat.chatName] = chat
	chatsInOrder.erase(chat.chatName)
	chatsInOrder.insert(0, chat.chatName)

# Returns the names of all chats! Use chatStore to get the chat objects
func get_all_chat_names() -> Array:
	return chatsInOrder
	
func set_active_decision(decision: Decision):
	activeDecision = decision
	
