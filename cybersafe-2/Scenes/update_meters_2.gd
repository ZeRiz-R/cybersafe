extends Control
class_name UpdateMeters

@onready var meterBox: MarginContainer = $MarginContainer/PlayerPanelWrapper/PlayerPanel/MarginContainer2/VBoxContainer2/MeterBox
var meterBars: Array
var allMeters = Constants.Meters.keys()
var choice: Choice

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var tip_text: Label = $TopTipWrapper/TopTipBox/VBoxContainer/TipWrapper/PanelContainer/TipText

signal complete

func _ready():
	choice = Stores.activeDecision.selection
	load_meters()
	set_tip()
	# Update value
	# Display reason
	# anim_player.play("show_top_tip")
	# await(anim_player.animation_finished)
	
func update_meters(show_tip2: bool):
	anim_player.play("slide_in")
	anim_player.queue("zoom_in")
	
	await(anim_player.animation_finished)
	await(iterate_meters()) # Iterate through meters
	await(get_tree().create_timer(1).timeout)
	anim_player.play_backwards("zoom_in")
	await(anim_player.animation_finished)
	anim_player.play_backwards("slide_in")
	await(anim_player.animation_finished)
	
	if show_tip2:
		await(show_tip())
		
	emit_signal("complete")
	
func show_tip():
	anim_player.play("show_cyber_tip")
	await(anim_player.animation_finished)
	
func iterate_meters():
	var index = 0
	print("Iterating meters")
	Player.update_meters(choice.meterChanges)
	for stat in allMeters:
		var player_meter_value = Player.meters[stat]
		var bar = meterBars[index]
		if bar.get_meter_value() != player_meter_value:
			bar.tween_meter_value(player_meter_value)
			
			var reason = bar.get_node("../ReasonText")
			await(get_tree().create_timer(0.6).timeout)
			var reason_colour = sign(choice.meterChanges[stat]["Value"]) != -1
			print(bar.stress)
			print("rah")
			if bar.stress:
				print("stressin")
				reason_colour = !reason_colour
			reason.assign_text(choice.meterChanges[stat]["Reason"], reason_colour)
			await(get_tree().create_timer(1).timeout)
		index += 1
		

func load_meters():
	var index = 0;
	print("Getting ready")
	meterBars = get_progress_bars(meterBox, [])
	for stat in allMeters:
		var bar = meterBars[index]
		bar.set_meter_value(Player.meters[stat])
		index += 1

func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
	
func set_tip():
	tip_text.text = Stores.activeDecision.tip
