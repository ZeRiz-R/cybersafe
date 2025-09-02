extends Node2D
# Fictional Uni name: 
var email_test: EmailDecision

func _ready():
	load_events("res://Assets/GameEvents")
	Calendar.load_test_event(events)
	# Calendar.print_event()
	# test_inbox()
	switch_to_dashboard()

func test_inbox():
	var emails = [Email.new("Sora Sakurai", "Announcing Super Smash Bros. Legends", "Sus.", []),
					Email.new("Shigeru Maiyamo", "On the movements of Pikmin 4", "Pikmin 4 is close to completion!", [])]
	for email in emails:
		Stores.add_email(email)

func switch_to_dashboard():
	# get_tree().change_scene_to_file("res://Scenes/dashboard.tscn")
	get_tree().change_scene_to_file("res://Scenes/avatar_select.tscn")

var events = []
func load_events(filePath: String):
	var dir = DirAccess.open(filePath)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var resourcePath = filePath.path_join(file_name)
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				load_events(resourcePath)
			else:
				print("Found file: " + file_name)
				events.append(load(resourcePath))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	pass
