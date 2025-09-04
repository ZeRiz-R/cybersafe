extends Node

var Meters = {
	"CK": "Cyber Knowledge",
	"DH": "Device Health",
	"DS": "Data Security",
	"ST": "Social Trust",
	"S": "Stress"
}

var placeholders := {
	"name": "placeholder",
	"link": "#00cef2"
}

func display_outcome_text(scene_root: Node, outcomeText: Array[TextBoxEntry], includeOverlay := true):
	var textbox = preload("res://Scenes/text_box.tscn").instantiate()
	scene_root.add_child(textbox)
	if not includeOverlay:
		textbox.hide_overlay()
	await(textbox.available)
	textbox.queue_array(outcomeText)
	await(textbox.tree_exited)

# HASHMAP Mapping Names to Icons for messages
var Avatars = { "Default": { "texture": preload("res://Assets/Avatars/winton.webp"), "scale": Vector2(0.85, 0.85) },
				"Avatar1": { "texture": preload("res://Assets/Avatars/1.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar2": { "texture": preload("res://Assets/Avatars/2.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar3": { "texture": preload("res://Assets/Avatars/3.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar4": { "texture": preload("res://Assets/Avatars/4.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar5": { "texture": preload("res://Assets/Avatars/5.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar6": { "texture": preload("res://Assets/Avatars/6.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar7": { "texture": preload("res://Assets/Avatars/7.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar8": { "texture": preload("res://Assets/Avatars/8.png"), "scale": Vector2(0.182, 0.182) },
				"Avatar9": { "texture": preload("res://Assets/Avatars/9.png"), "scale": Vector2(0.182, 0.182) }
				} 

## TEST DECISION EMAIL
#var choice1 = Choice.new("Follow" ,"Follow", {"CK": {"Value": +30, "Reason": "Good reason"},
										 #"DH": {"Value": +10, "Reason": "Good reason"},
										 #"DS": {"Value": -10, "Reason": "Good reason"},
										 #"ST": {"Value": -30, "Reason": "Good reason"},
										 #"S": {"Value": +10, "Reason": "Good reason"}}, ["Good stuff", "It's not everyday you test an email!"])
#var choice2 = Choice.new("Report", "Report", {"CK": {"Value": +2, "Reason": "Good reason"},
										 #"DH": {"Value": +3, "Reason": "Good reason"},
										 #"DS": {"Value": +4, "Reason": "Good reason"},
										 #"ST": {"Value": +5, "Reason": "Good reason"},
										 #"S": {"Value": -5, "Reason": "Good reason"}}, ["Bad Stuff", "It's not everyday you report an email!"])
#var choice3 = IgnoreChoice.new("Ignore", "Ignore", {"CK": {"Value": +30, "Reason": "Good reason"},
										 #"DH": {"Value": +3, "Reason": "Good reason"},
										 #"DS": {"Value": +4, "Reason": "Good reason"},
										 #"ST": {"Value": +10, "Reason": "Good reason"},
										 #"S": {"Value": -5, "Reason": "Good reason"}}, ["Decent Stuff", "We'll see how this turns out another time"],
										#Vector2i(3, 2), ["Time to follow up on that ignore!", "Turns out it was all good."])
#var email = Email.new("testsender@test.co.uk", "This is a test email", "This is a test email. [hint=warwick.ac.uk]Link[/hint]", [])
#var dummyDecision = EmailDecision.new("DecisionTest", Vector2i(3, 1), "This is a test... believe it!", "Here is a top tip for an email", [choice1, choice2, choice3],  email)
#
## TEST CHAT STUFF
#var chat1 = ChatMessage.new("Winton Overwat", "Overwatch 2 in big 2025", false)
#var chat2 = ChatMessage.new("FroggerTV", "Does this mean Overwatch is back?", true)
#var chat3 = ChatMessage.new("Winton Overwat", "Yes, Yes we are!", false)
#
#var choice1c = ChatChoice.new("Play", "Play Overwatch. you could reach Grandmaster!", {"CK": {"Value": +30, "Reason": "Good reason"},
										 #"DH": {"Value": +10, "Reason": "Good reason"},
										 #"DS": {"Value": -10, "Reason": "Good reason"},
										 #"ST": {"Value": -30, "Reason": "Good reason"},
										 #"S": {"Value": +10, "Reason": "Good reason"}}, ["Maybe not the best choice...", "Your enthusiasm quickly dries out as you re-enter that hellscape."])
#var choice2c = ChatChoice.new("Uninstall", "Uninstall Overwatch. It's not worth the pain.",  {"CK": {"Value": +2, "Reason": "Good reason"},
										 #"DH": {"Value": +2, "Reason": "Good reason"},
										 #"DS": {"Value": +4, "Reason": "Good reason"},
										 #"ST": {"Value": +5, "Reason": "Good reason"},
										 #"S": {"Value": -5, "Reason": "Good reason"}}, ["Great choice!", "Your life is way more peaceful"])
#var choice3c = ChatChoice.new("Paladins", "Play Paladins. It was bettter anyway...", {"CK": {"Value": -10, "Reason": "Good reason"},
										 #"DH": {"Value": +5, "Reason": "Good reason"},
										 #"DS": {"Value": -5, "Reason": "Good reason"},
										 #"ST": {"Value": -10, "Reason": "Good reason"},
										 #"S": {"Value": +10, "Reason": "Good reason"}}, ["Uhhhhh...", "Seems like you haven't heard the news.", "Paladins is dead."])
#var dummyChatDecision = ChatDecision.new("PlayOverwatch", Vector2i(1,1), "TestPrompt", "Learn the fastest rollouts to get to the objective!", [choice1c, choice2c, choice3c], "Winton Overwat", [chat1, chat2, chat3])

# @export var resourceTest := preload("res://Assets/GameEvents/test_email_decision.tres")

const update_meters_scene := "res://Scenes/update_meters_scene.tscn"
const update_meters_overlay := "res://Scenes/update_meters_2.tscn"
const make_decision_scene := "res://Scenes/make_decision.tscn"

func overlay_scene(scene_path: String):
	print("Overlaying Scene")
	var overlayed_scene = load(scene_path).instantiate()
	var uiLayer = get_tree().current_scene
	uiLayer.add_child(overlayed_scene)
	return overlayed_scene
	
