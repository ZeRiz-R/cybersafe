extends TextureRect

@onready var anim_player: AnimationPlayer = $AnimationPlayer
func appear():
	visible = true
	print("showing alert")
	anim_player.play("appear")
	await(anim_player.animation_finished)
	anim_player.queue("loop")

func disappear():
	visible = false
