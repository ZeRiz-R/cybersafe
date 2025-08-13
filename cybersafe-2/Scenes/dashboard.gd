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
		
	set_date()
		
@onready var week_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/WeekLabel
@onready var day_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/DayLabel
func set_date():
	week_label.text = "WEEK " + str(Calendar.get_date().x)
	day_label.text = "DAY " + str(Calendar.get_date().y)

func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
	
	
