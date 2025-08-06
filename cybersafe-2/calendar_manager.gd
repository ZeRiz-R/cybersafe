extends Node

class_name CalendarManager

var currentDate := Vector2i(1, 1)
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

func print_event():
	while !calendar.get(currentDate):
		print(currentDate)
		progress_time()
	var event = calendar[currentDate]
	if event.event is EmailDecision:
		Stores.add_email(event.event)
			
	
