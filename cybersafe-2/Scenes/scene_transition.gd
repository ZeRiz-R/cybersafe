extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var arrow: Polygon2D = $Arrow
func _ready():
	print("Loaded Animation Player")
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(new_scene: String, transition: String):
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	match transition:
		"fade":
			fade_transition(new_scene)
		"tiles":
			tile_transition(new_scene)
		"arrow":
			arrow_transition(new_scene)
		"arrow_time":
			arrow_time_transition(new_scene)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func fade_transition(new_scene: String):
	color_rect.material.shader = preload("res://Scenes/ShaderTransitions/fade.gdshader")
	anim_player.play("transition_in")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play_backwards("transition_out")
	
func tile_transition(new_scene: String):
	color_rect.material.shader = preload("res://Scenes/ShaderTransitions/tiled_sweep.gdshader")
	anim_player.play("transition_in")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play("transition_out")

func arrow_transition(new_scene: String):
	anim_player.play("in_arrow")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play("out_arrow")
	
func arrow_time_transition(new_scene: String):
	anim_player.play("in_arrow")
	anim_player.queue("clock_ascend")
	anim_player.queue("clock_spin")
	await(anim_player.animation_finished)
	get_tree().change_scene_to_file(new_scene)
	anim_player.play_backwards("clock_ascend")
	anim_player.queue("out_arrow")
