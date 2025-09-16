extends Node

var emailStore := []
var unreadEmails := 0

var chatStore := {}
var unreadChats := 0
var chatsInOrder := []

var ignoredStore := []
var ignoredEventDates := []

var eventStore := []

var activeDecision: GameEvent
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
	chatStore[chatName] = []
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
	unreadEmails = max(unreadEmails - 1, 0)

func popUnreadChat():
	unreadChats = max(unreadChats - 1, 0)
	
func addIgnoredEvent(event):
	if event is IgnoreEvent or event is PendingEvent:
		ignoredStore.insert(0, event)
	else:
		print("Can't add event that is not pending.")
	
func queueIgnoredEvent(date: Vector2i):
	for i in range(len(ignoredEventDates)):
		if date.x <= ignoredEventDates[i].x and date.y <= ignoredEventDates[i].y:
			ignoredEventDates.insert(i, date)
			return
	ignoredEventDates.append(date)

func popIgnoredEvent():
	return ignoredEventDates.pop_front()
	
func add_generic_event(event):
	eventStore.append(event)
	
func reset_game():
	emailStore.clear()
	unreadEmails = 0
	chatStore.clear()
	unreadChats = 0
	chatsInOrder.clear()
	ignoredStore.clear()
	ignoredEventDates.clear()
	eventStore.clear()
	
	for stat in Player.meters:
		Player.meters[stat] = 50
	Player.meters["S"] = 0
	
	Calendar.currentDate = Vector2(1, -1)
	
