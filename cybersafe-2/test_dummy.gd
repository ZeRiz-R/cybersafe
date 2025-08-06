extends Node2D
@onready var calendar_manager = CalendarManager.new()

func _ready():
	calendar_manager.load_test_event()
	calendar_manager.print_event()
	# test_inbox()
	switch_to_dashboard()

func test_inbox():
	var emails = [Email.new("Sora Sakurai", "Announcing Super Smash Bros. Legends", "Sus.", []),
					Email.new("Shigeru Maiyamo", "On the movements of Pikmin 4", "Pikmin 4 is close to completion!", [])]
	for email in emails:
		Stores.add_email(email)

func switch_to_dashboard():
	get_tree().change_scene_to_file("res://Scenes/dashboard.tscn")
