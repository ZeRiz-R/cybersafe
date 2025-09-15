extends Node

class_name CalendarManager

var currentDate := Vector2i(10,-1) # Week / Day
var calendar := {}
var activeEvent := GameEvent

func add_event(week: int, day: int, event: GameEvent):
	var key = Vector2i(week, day)
	var eventList = calendar.get(key, [])
	eventList.append(event)
	calendar[key] = eventList

func get_events(week: int, day: int):
	var key = Vector2i(week, day)
	return calendar.get(key, null)

func progress_time():
	currentDate.y += 1
	if currentDate.y > 7:
		currentDate.y = 1
		currentDate.x += 1
		
func load_test_event(events):
	#var event = Constants.dummyDecision
	#add_event(event.date.x, event.date.y, event)
	#
	#event = Constants.dummyChatDecision
	#add_event(event.date.x, event.date.y, event)
	
	#event = Constants.resourceTest
	#add_event(event.date.x, event.date.y, event)
	
	for event2 in events:
		add_event(event2.date.x, event2.date.y, event2)
	print_event()
	
	


func print_event():
	var timeout = 0
	progress_time()
	while !calendar.get(currentDate) and timeout < 20:
		print(currentDate)
		progress_time()
		timeout += 1
	var events = calendar.get(currentDate, null)
	
	if not events:
		return
	
	for event in events:
		if event is EmailDecision:
			Stores.add_email(event)
		if event is ChatDecision:
			Stores.add_chat_event(event)
		if event is IgnoreEvent or event is PendingEvent:
			Stores.popIgnoredEvent()
			Stores.addIgnoredEvent(event)
		if event is FreeDayEvent:
			Stores.set_free_event(event)
			event.get_events()
		if event is StoryEvent:
			Stores.add_generic_event(event)
			
func get_date():
	return currentDate
	
func get_date_difference(otherDate: Vector2i):
	var currentDateVal = 7 * currentDate.x + currentDate.y
	var otherDateVal = 7 * otherDate.x + otherDate.y
	
	return otherDateVal - currentDateVal
