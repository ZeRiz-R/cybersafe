extends MarginContainer

@onready var anim_player: AnimationPlayer = $DecisionButtonWrapper/DecisionButton/AnimationPlayer
@onready var decision_button: Button = $DecisionButtonWrapper/DecisionButton
func show_animate():
	if not decision_button.visible:
		decision_button.visible = true
		decision_button.disabled = false
		anim_player.play("SHOW")
		await(anim_player.animation_finished)
	
func hide_animate():
	if decision_button.visible:
		anim_player.play("HIDE")
		await(anim_player.animation_finished)
		decision_button.disabled = true
		decision_button.visible = false
	
func hide_instant():
	decision_button.visible = false
	decision_button.disabled = false
