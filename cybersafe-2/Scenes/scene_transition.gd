extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var arrow: Polygon2D = $Arrow
@onready var mouse_block: MarginContainer = $MouseBlock
signal transition_finished
signal transitioning

func _ready():
	print("Loaded Animation Player")
	mouse_block.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(new_scene: String, transition: String):
	emit_signal("transitioning")
	mouse_block.mouse_filter = Control.MOUSE_FILTER_STOP
	match transition:
		"fade":
			await(fade_transition(new_scene))
		"tiles":
			await(tile_transition(new_scene))
		"arrow":
			await(arrow_transition(new_scene))
		"arrow_time":
			await(arrow_time_transition(new_scene))
	mouse_block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	emit_signal("transition_finished")
	
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
