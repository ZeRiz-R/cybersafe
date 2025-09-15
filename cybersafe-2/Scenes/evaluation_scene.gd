extends Control

@export var ck_eval: Dictionary = {
	"HIGH": ["RESULT: Cyber Ninja",
			"Your choices showed a brilliant understanding of cybersecurity awareness!"],
	"MID": ["RESULT: Cyber Student",
			"You made some bad choices here and there.", 
			"But overall you showed a decent understanding of cybersecurity awareness."],
	"LOW": ["RESULT: Cyber Fraud",
			"That's pretty rough...",
			"You definitely need to work on identifying bad situations!"]
}

@export var dh_eval: Dictionary = {
	"HIGH": ["RESULT: Guardian of the Devices", 
			"Your devices are in safe hands!"],
	"MID": ["RESULT: Friend of the Devices",
			"Your devices are in a little danger, but you'll keep them from completely falling to bits!"],
	"LOW": ["RESULT: Enemy of the Devices",
			"We might need to call DPS (Device Protection Services) on you!"]
}

@export var ds_eval: Dictionary = {
	"HIGH": ["RESULT: Data Stronghold", 
			"Your data is kept very safe!",
			"Just don't let the silverfish bite!"],
	"MID": ["RESULT: Data Cipher.",
			"Your data is kept fairly safe.",
			"But sometimes, the code to the vault is cracked."
			],
	"LOW": ["RESULT: Data Fountain",
			"Your data is flowing into the hands of attackers!",
			"At this rate they'll know more about you than you do!"]
}

@export var st_eval: Dictionary = {
	"HIGH": ["RESULT: Social Butterfly", 
			"You might just be the coolest one around!",
			"Everyone wants to be your friend!"],
	"MID": ["RESULT: Up Dog.",
			"You might not be the most popular one around.",
			"But people still talk to you about \"Up Dog\" when they see you.",
			"You still haven't quite figured out what \"Up Dog\" is though!"
			],
	"LOW": ["RESULT: Lone Wolf",
			"Definitely not the most popular one around.",
			"But hey! At least you know all the people you can trust.",
			"Consisting of yourself, yourself, and finally yourself."]
}

@export var s_eval: Dictionary = {
	"HIGH": ["RESULT: Stress Monster", 
			"You might actually be the most stressed person on the planet.",
			"Take it easy!",
			"Maybe join your uni volleyball team!"],
	"MID": ["RESULT: Average Uni Student",
			"Life always comes with a bit of stress.",
			"You've kept it fairly under control!",
			],
	"LOW": ["RESULT: Chill Guy",
			"Stress? Never heard of it!",
			"You found the key to living a long life.",
			"When people ask what that secret is, all you can tell them is:",
			"\"I'm just a chill guy!\""]
}

var dialogue_map := {
	"CK": ck_eval,
	"DH": dh_eval,
	"DS": ds_eval,
	"ST": st_eval,
	"S": s_eval
}

@onready var text_box: CanvasLayer = $TextBox
var speakers = ["Josh", "Amy", "Winston", "Mei", "Sarah"]
var i = 0
func _ready():
	for stat in Player.meters:
		var val = Player.meters[stat]
		var temp = TextBoxEntry.new("Mysterious Voice",
		"Your " + Constants.Meters[stat] + " score was " + str(val) + "!" )
		text_box.queue_text(temp)
		
		var stat_map = dialogue_map[stat]
		if val >= Constants.MeterThresholds["HIGH"]:
			for dialogue in stat_map["HIGH"]:
				temp = TextBoxEntry.new(speakers[i], dialogue)
				text_box.queue_text(temp)
		elif val >= Constants.MeterThresholds["MEDIUM"]:
			for dialogue in stat_map["MID"]:
				temp = TextBoxEntry.new(speakers[i], dialogue)
				text_box.queue_text(temp)
		elif val >= Constants.MeterThresholds["LOW"]:
			for dialogue in stat_map["LOW"]:
				temp = TextBoxEntry.new(speakers[i], dialogue)
				text_box.queue_text(temp)
		i += 1
	print("Weval")
