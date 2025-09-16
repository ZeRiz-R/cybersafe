extends Control

@onready var avatar: PanelContainer = $MarginContainer/AvatarWrapper/Avatar
var cycle = ["Avatar1", "Avatar2", "Avatar3", "Avatar4", "Avatar5", "Avatar6", "Avatar7"
, "Avatar8", "Avatar9"]

func _ready():
	while true:
		for i in range(len(cycle)):
			var tween = get_tree().create_tween().set_parallel()
			avatar.modulate.a = 0
			avatar.select_image(cycle[i])
			avatar.position.x += 50
			tween.tween_property(avatar,"modulate:a", 1.0, 0.25).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(avatar, "position:x", avatar.position.x - 50, 0.25).set_ease(Tween.EASE_IN_OUT)
			await(get_tree().create_timer(7).timeout)
