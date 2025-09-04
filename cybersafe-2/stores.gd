extends Node

var emailStore := []
var unreadEmails := 0

var chatStore := {}
var unreadChats := 0
var chatsInOrder := []

var ignoredStore := []
var ignoredEventDates := []

var activeDecision: Decision
var activeMeterChange: Dictionary

var activeFreeEvent: Decision = null

func _init() -> void:
	pass
	# activeDecision = Constants.dummyDecision

func add_email(emailDecision: EmailDecision):
	emailStore.insert(0, emailDecision)
	unreadEmails += 1
	
func get_all_emails() -> Array:
	return emailStore
	
func add_message(chatName: String, message: ChatMessage):
	print("adding message " + message.message)
	var chat = chatStore.get(chatName)
	if not chat:
		chatStore[chatName] = Chat.new(chatName, [])
		chat = chatStore.get(chatName)
	
	chat.queue_message(message)
	chatsInOrder.erase(chatName)
	chatsInOrder.insert(0, chatName)

func add_chat_event(chatDecision: ChatDecision):
	var chatName = chatDecision.chatName
	for message in chatDecision.messages:
		add_message(chatName, message)
	chatStore[chatName].currentDecision = chatDecision
	unreadChats += 1
	
func add_chat(chat: Chat):
	chatStore[chat.chatName] = chat
	chatsInOrder.erase(chat.chatName)
	chatsInOrder.insert(0, chat.chatName)

# Returns the names of all chats! Use chatStore to get the chat objects
func get_all_chat_names() -> Array:
	return chatsInOrder
	
func set_active_decision(decision: Decision):
	activeDecision = decision
	
func set_free_event(event: Decision):
	activeFreeEvent = event
	
func popUnreadEmail():
	unreadEmails = min(unreadEmails - 1, 0)

func popUnreadChat():
	unreadChats = min(unreadChats - 1, 0)
	
func addIgnoredEvent(event: IgnoreEvent):
	ignoredStore.insert(0, event)
	
func queueIgnoredEvent(date: Vector2i):
	for i in range(len(ignoredEventDates)):
		if date.x <= ignoredEventDates[i].x and date.y <= ignoredEventDates[i].y:
			ignoredEventDates.insert(i, date)
			return
	ignoredEventDates.append(date)

func popIgnoredEvent():
	return ignoredEventDates.pop_front()
	
