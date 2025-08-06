extends Control

class_name MeterBar

@onready var progress_bar: ProgressBar = $PanelContainer/ProgressBar
@onready var tween := get_tree().create_tween()
var duration := 1.5

func _process(delta):
	await(get_tree().create_timer(2).timeout)
	set_meter_value(100)

func set_meter_value(new_value: float):
	tween = create_tween()
	tween.tween_property(progress_bar, "value", new_value, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	
	
