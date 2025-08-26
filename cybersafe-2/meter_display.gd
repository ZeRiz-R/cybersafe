extends PanelContainer

func _ready():
	load_meters()
	# animate_outer()

@onready var meterBox: VBoxContainer = $PanelContainer/MetersWrapper/MeterBox
var meterBars: Array
var allMeters = Constants.Meters.values()

func load_meters():
	var index = 0;
	print("Getting ready")
	meterBars = get_progress_bars(meterBox, [])
	for bar in meterBars:
		bar.tween_meter_value(Player.meters[allMeters[index]])
		index += 1

func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
	
@onready var inner_panel: PanelContainer = $PanelContainer
var wobble := Vector2(-0.39, -0.04)
func animate_outer():
	var tween = get_tree().create_tween().set_loops()
	var sb: StyleBoxFlat = inner_panel.get_theme_stylebox("panel")
	var skew_x = sb.skew.x
	var skew_y = sb.skew.y
	tween.tween_property(sb, "skew", wobble, 0.1)
	tween.tween_property(sb, "skew", Vector2(skew_x, skew_y), 0.1)
