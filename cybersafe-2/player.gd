extends Node

var playerName := "Sabo"
var playerIcon := "Default"
var meters: Dictionary
	
func _init():
	print("setting meters")
	for meter in Constants.Meters.values():
		meters[meter] = 50
	
func update_meters(changes: Dictionary):
	for stat in changes.keys():
		var val = changes[stat]
		meters[stat] += val
		meters[stat] = min(meters[stat], 100)
		meters[stat] = max(meters[stat], 0)
		
