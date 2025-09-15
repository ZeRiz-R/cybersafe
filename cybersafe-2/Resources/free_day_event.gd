extends Decision

class_name FreeDayEvent

static var available_choices: Array[Choice] = [preload("res://Assets/FreeDayChoices/free_day_library.tres"), preload("res://Assets/FreeDayChoices/movie_night.tres")]

func get_events():
	for i in range(3):
		if i < len(available_choices):
			choices.append(available_choices[i])
	
func select_choice(choice):
	super.select_choice(choice)
	available_choices.erase(choice)

	
