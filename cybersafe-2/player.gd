extends Node

var playerName: String
var meters: Dictionary
	
func _init():
	print("setting meters")
	for meter in Constants.Meters.values():
		meters[meter] = 0
	
func update_meters(changes: Dictionary):
	for stat in changes.keys():
		var val = changes[stat]
		meters[stat] += val
		
