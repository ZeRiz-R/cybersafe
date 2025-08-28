extends CanvasLayer

@onready var meterBox: MarginContainer = $MarginContainer/PlayerPanelWrapper/PlayerPanel/MarginContainer2/VBoxContainer2/MeterBox
var meterBars: Array
var allMeters = Constants.Meters.values()
var choice: Choice

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	choice = Stores.activeDecision.selection
	load_meters()
	anim_player.play("slide_in")
	anim_player.queue("zoom_in")
	await(anim_player.animation_finished)
	await(iterate_meters()) # Iterate through meters
	# Update value
	# Display reason
	# anim_player.play("show_top_tip")
	# await(anim_player.animation_finished)
	SceneTransition.change_scene("res://Scenes/dashboard.tscn", "fade")
	
func iterate_meters():
	var index = 0
	print("Iterating meters")
	Player.update_meters(choice.meterChanges)
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
