extends Control


@onready var meterBox: VBoxContainer = $MarginContainer3/HBoxContainer/MarginContainer2/PlayerPanelWrapper/PanelContainer/MarginContainer2/VBoxContainer2/MarginContainer2/VBoxContainer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var avatar: PanelContainer = $MarginContainer3/HBoxContainer/MarginContainer2/PlayerPanelWrapper/PanelContainer/MarginContainer2/VBoxContainer2/MarginContainer/Control/AvatarContainer
@onready var player_name: Label = $MarginContainer3/HBoxContainer/MarginContainer2/PlayerPanelWrapper/PanelContainer/MarginContainer2/VBoxContainer2/PlayerName
func _ready():
	load_meters()
	set_date()
	set_player_avatar()
	await(check_story_events())
	await(check_ignores())
	await(check_free_events())
	await(ready_alerts())
		
		
func load_meters():
	var allMeters = Constants.Meters.keys()
	var index = 0;
	print("Getting ready")
	var meterBars = get_progress_bars(meterBox, [])
	for stat in allMeters:
		var bar = meterBars[index]
		bar.tween_meter_value(Player.meters[stat])
		index += 1

@onready var week_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/WeekLabel
@onready var day_label: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/VBoxContainer/DayLabel
func set_date():
	week_label.text = "WEEK " + str(Calendar.get_date().x)
	day_label.text = "DAY " + str(Calendar.get_date().y)
	
@onready var alertEmail: TextureRect = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/EmailButton/Alert
@onready var alertChat: TextureRect = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MessagesButton/Alert
@onready var ignore_panel: PanelContainer = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/IgnorePanelWrapper/IgnorePanel
@onready var time_button: TextureButton = $MarginContainer3/HBoxContainer/MarginContainer2/PlayerPanelWrapper/PanelContainer/MarginContainer2/VBoxContainer2/TimeWrapper/TimeButton
func ready_alerts():
	var any_alerts = false

	if Stores.unreadEmails > 0:
		await(alertEmail.appear())
		any_alerts = true
	else:
		alertEmail.disappear()
	
	if Stores.unreadChats > 0:
		await(alertChat.appear())
		any_alerts = true
	else:
		alertChat.disappear()
		
	if not any_alerts:
		anim_player.play("open_time")
		await(anim_player.animation_finished)
	else:
		time_button.scale = Vector2.ZERO
		
@onready var number_ignored: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/IgnorePanelWrapper/IgnorePanel/HBoxContainer/VBoxContainer/NumberIgnored
@onready var days_ignored: Label = $MarginContainer3/HBoxContainer/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/MarginContainer/IgnorePanelWrapper/IgnorePanel/HBoxContainer/VBoxContainer/DaysIgnored
func check_ignores():
	if len(Stores.ignoredEventDates) > 0:
		await(open_ignore_panel())
	else:
		ignore_panel.visible = false
	if len(Stores.ignoredStore) > 0:
		ignore_panel.visible = true
		anim_player.play("IgnoreEventActivate")
		days_ignored.text = "Impact Timer: 0 Days"
		var ignoreEvent = Stores.ignoredStore.pop_front()
		if ignoreEvent is IgnoreEvent:
			Stores.activeDecision = ignoreEvent.attachedDecision
			Stores.activeDecision.outcomeTextMain = ignoreEvent.outcomeText
		else:
			Stores.activeDecision = ignoreEvent
		await(anim_player.animation_finished)
		await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text()))# QueueOutcomeText()
		SceneTransition.change_scene(Constants.update_meters_scene, "arrow")
		
@onready var free_day_text: Label = $Overlays/FreeDayContainer/FreeDayText
func check_story_events():
	if len(Stores.eventStore) > 0:
		free_day_text.text = "EVENT!"
		anim_player.play("FreeDayActivate")
		await(anim_player.animation_finished)
		Stores.activeDecision = Stores.eventStore.pop_front()
		await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.get_outcome_text()))# QueueOutcomeText()
		if Stores.activeDecision.resource_name == "evaluation":
			SceneTransition.change_scene("res://Scenes/evaluation_scene.tscn", "fade")
		else:
			SceneTransition.change_scene(Constants.update_meters_scene, "arrow")

func check_free_events():
	if Stores.activeFreeEvent:
		free_day_text.text = "FREE DAY"
		anim_player.play("FreeDayActivate")
		await(anim_player.animation_finished)
		Stores.set_active_decision(Stores.activeFreeEvent)
		Stores.activeDecision.choice_selected.connect(_on_free_event_selected)
		await(Constants.display_outcome_text(get_tree().current_scene, Stores.activeDecision.prompt))# QueueOutcomeText()
		Constants.overlay_scene(Constants.make_decision_scene)

func _on_free_event_selected(choice):
	if choice:
		await(Constants.display_outcome_text(get_tree().current_scene, choice.outcomeText))# QueueOutcomeText()
		SceneTransition.change_scene(Constants.update_meters_scene, "arrow")
	
	
	
func open_ignore_panel():
		number_ignored.text = str(len(Stores.ignoredEventDates)) + " Pending Outcome"
		if len(Stores.ignoredEventDates) > 1:
			number_ignored.text += "s"
		var days = Calendar.get_date_difference(Stores.ignoredEventDates[0])
		days_ignored.text = "Impact Timer: " + str(days) + " Days"
		anim_player.play("OpenIgnorePanel")
		await(anim_player.animation_finished)
		
func set_player_avatar():
	avatar.select_image(Player.playerIcon)
	player_name.text = Player.playerName
	
func get_progress_bars(node: Node, arr: Array):
	var children = node.get_children()
	for child in children:
		if child is MeterBar:
			arr.append(child)
		get_progress_bars(child, arr)
	return arr
	
	
