extends Node

class_name CalendarManager

var currentDate := Vector2i(0, 1)
var calendar := {}
var activeEvent := GameEvent

func add_event(day: int, week: int, event: GameEvent):
	var key = Vector2i(day, week)
	calendar[key] = event

func get_event(day: int, week: int):
	var key = Vector2i(day, week)
	return calendar.get(key, null)

func progress_time():
	currentDate.x += 1
	if currentDate.x > 7:
		currentDate.x = 1
		currentDate.y += 1
		
func load_test_event():
	var event = Constants.dummyEvent
	add_event(event.date.x, event.date.y, event)
	
	event = Constants.dummyChatEvent
	add_event(event.date.x, event.date.y, event)


func print_event():
	var timeout = 0
	progress_time()
	while !calendar.get(currentDate) and timeout < 20:
		print(currentDate)
		progress_time()
		timeout += 1
	var event = calendar.get(currentDate)
	
	if not event:
		return
	
	if event.event is EmailDecision:
		Stores.add_email(event.event)
	if event.event is ChatDecision:
		Stores.add_chat_event(event.event)
			
	
