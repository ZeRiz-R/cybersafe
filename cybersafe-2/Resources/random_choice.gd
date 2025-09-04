extends Choice
class_name RandomChoice

@export var random_choices: Array[RandomOutcome]

func set_outcome():
	randomise_outcome()
	
func randomise_outcome():
	var total_prob = 0.0
	for rchoice in random_choices:
		total_prob += rchoice.probability
	
	var randNum = randf() * total_prob
	var current = 0.0
	
	# FIX PROBABILITY DISTRIBUTION PLS
	for rchoice in random_choices:
		current += rchoice.probability
		if randNum >= rchoice.probability:
			outcomeText = rchoice.outcomeText
			meterChanges = rchoice.meterChanges
			break
