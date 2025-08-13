extends Control

@onready var meterBox: VBoxContainer = $MarginContainer2/VBoxContainer
var allMeters = Constants.Meters.values()
var meterBars: Array
var choice: Choice

func _ready():
	choice = Stores.activeDecision.selection
	load_meters()
	await(iterate_meters()) # Iterate through meters
	# Update value
	# Display reason
	SceneTransition.change_scene("res://Scenes/dashboard.tscn")
	
func iterate_meters():
	var index = 0
	print("Iterating meters")
	Player.update_meters(choice.meter_changes)
	for bar in meterBars:
		bar.tween_meter_value(Player.meters[allMeters[index]])
		await(get_tree().create_timer(1).timeout)
		index += 1
		

func load_meters():
	var index = 0;
	print("Getting ready")
	meterBars = get_progress_bars(meterBox, [])
	for bar in meterBars:
		bar.set_meter_value(Player.meters[allMeters[index]])
		index += 1

func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
