extends Node

class Player:
	var name: String
	var meters: Dictionary
	
	func _init(_name: String):
		name = _name
		for meter in Constants.Meters:
			meters[meter] = 0
	
	func update_meters(changes: Dictionary):
		for change in changes:
			meters[change[0]] += change[1]
		
