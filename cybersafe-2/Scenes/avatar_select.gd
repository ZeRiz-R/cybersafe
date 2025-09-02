extends Control

@onready var title: Label = $MarginContainer/VBoxContainer/MarginContainer/PanelContainer2/TitleWrapper/Title
@onready var line_edit: LineEdit = $MarginContainer/VBoxContainer/PanelContainer/LineEdit
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	line_edit.text_submitted.connect(_on_name_entered)
	pass
	
func _on_name_entered(entry: String):
	Player.playerName = entry
	Constants.placeholders["name"] = Player.playerName
	anim_player.play("switch_to_avatar")
	anim_player.queue("change_title")
	
func change_title(new_title: String):
	title.text = new_title
