extends Decision

class_name FreeDayEvent

static var available_choices: Array[Choice]

func get_events():
	for i in range(3):
		choices[i] = available_choices[i]
	
func select_choice(choice):
	super.select_choice(choice)
	available_choices.erase(choice)
	
