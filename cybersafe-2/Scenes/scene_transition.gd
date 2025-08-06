extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	print("Loaded Animation Player")
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(new_scene: String):
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	tile_transition(new_scene)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func fade_transition(new_scene: String):
	anim_player.play("transition_in")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play_backwards("transition_out")
	
func tile_transition(new_scene: String):
	anim_player.play("transition_in")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play("transition_out")
