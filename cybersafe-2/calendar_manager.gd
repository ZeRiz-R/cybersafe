extends Node

class CalendarManager:
	var currentDate := Vector2i(1, 1)
	var calendar := {}
	
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
		var choice1 = Choice.new("choice2", {Constants.Meters.CYBER_KNOWLEDGE: +2,
											 Constants.Meters.DEVICE_HEALTH: +3,
											 Constants.Meters.DATA_SECURITY: +4,
											 Constants.Meters.SOCIAL_TRUST: +5,
											 Constants.Meters.STRESS: -5})
		var choice2 = Choice.new("choice2", {Constants.Meters.CYBER_KNOWLEDGE: +2,
											 Constants.Meters.DEVICE_HEALTH: +3,
											 Constants.Meters.DATA_SECURITY: +4,
											 Constants.Meters.SOCIAL_TRUST: +5,
											 Constants.Meters.STRESS: -5})
		var choice3 = Choice.new("choice3", {Constants.Meters.CYBER_KNOWLEDGE: +2,
											 Constants.Meters.DEVICE_HEALTH: +3,
											 Constants.Meters.DATA_SECURITY: +4,
											 Constants.Meters.SOCIAL_TRUST: +5,
											 Constants.Meters.STRESS: -5})
		var decision = Decision.new("DecisionTest", [choice1, choice2, choice3], "This is a test... believe it!")
		var event = GameEvent.new("TestEvent", Vector2i(2, 1), decision)
		add_event(event.date.x, event.date.y, event)

	func print_event():
		while !calendar.get(currentDate):
			print(currentDate)
			progress_time()
		var event = calendar[currentDate]
		
			
	
