extends Control

@onready var meterBox: VBoxContainer = $MarginContainer2/MeterUpdatesWrapper/MeterUpdates/Meters
var allMeters = Constants.Meters.values()
var meterBars: Array
var choice: Choice

@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	choice = Stores.activeDecision.selection
	load_meters()
	set_tip()
	await(iterate_meters()) # Iterate through meters
	# Update value
	# Display reason
	anim_player.play("show_top_tip")
	await(anim_player.animation_finished)
	SceneTransition.change_scene("res://Scenes/dashboard.tscn", "fade")
	
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
	
@onready var tip_text: Label = $MarginContainer2/TopTipWrapper/TopTipBox/PanelContainer/VBoxContainer/TipText
func set_tip():
	tip_text.text = Stores.activeDecision.tip
