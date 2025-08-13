extends Control


@onready var meterBox: VBoxContainer = $MarginContainer3/HBoxContainer/MarginContainer2/PanelContainer/MarginContainer2/VBoxContainer2/MarginContainer2/VBoxContainer

func _ready():
	var children = meterBox.get_children()
	var allMeters = Constants.Meters.values()
	var index = 0;
	print("Getting ready")
	var meterBars = get_progress_bars(meterBox, [])
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
	
	
