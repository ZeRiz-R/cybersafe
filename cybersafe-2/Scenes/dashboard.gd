extends Control


@onready var meterBox: VBoxContainer = $MarginContainer3/HBoxContainer/MarginContainer2/PanelContainer/MarginContainer2/VBoxContainer2/MarginContainer2/VBoxContainer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var avatar: PanelContainer = $MarginContainer3/HBoxContainer/MarginContainer2/PanelContainer/MarginContainer2/VBoxContainer2/MarginContainer/Control/AvatarContainer
func _ready():
	load_meters()
	set_date()
	set_player_avatar()
	ready_alerts()
	check_ignores()
		
		
func load_meters():
	var allMeters = Constants.Meters.values()
	var index = 0;
	print("Getting ready")
	var meterBars = get_progress_bars(meterBox, [])
	for bar in meterBars:
		bar.set_meter_value(Player.meters[allMeters[index]])
		index += 1

@onready var week_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/WeekLabel
@onready var day_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/DayLabel
func set_date():
	week_label.text = "WEEK " + str(Calendar.get_date().x)
	day_label.text = "DAY " + str(Calendar.get_date().y)
	
@onready var alertEmail: TextureRect = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/EmailButton/Alert
@onready var alertChat: TextureRect = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MessagesButton/Alert
@onready var ignore_panel: PanelContainer = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/IgnorePanelWrapper/IgnorePanel
func ready_alerts():
	if Stores.unreadEmails > 0:
		alertEmail.appear()
	else:
		alertEmail.disappear()
	
	if Stores.unreadChats > 0:
		alertChat.appear()
	else:
		alertChat.disappear()
		
func check_ignores():
	if len(Stores.ignoredEventDates) > 0:
		anim_player.play("OpenIgnorePanel")
	elif len(Stores.ignoredStore) > 0:
		anim_player.play("IgnoreEventActivate")
		var ignoreEvent = Stores.ignoredStore.pop_front()
		Stores.activeDecision = ignoreEvent.attachedDecision
		await(anim_player.animation_finished)
		await(Constants.display_outcome_text(get_tree().current_scene, ignoreEvent.outcomeText))# QueueOutcomeText()
		SceneTransition.change_scene("res://Scenes/update_meters.tscn", "arrow")
	else:
		ignore_panel.visible = false
		
func set_player_avatar():
	avatar.select_image("Avatar1")

func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
	
	
