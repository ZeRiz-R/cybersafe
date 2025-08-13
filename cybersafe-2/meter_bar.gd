extends Control

class_name MeterBar

@onready var progress_bar: ProgressBar = $PanelContainer/ProgressBar
var duration := 1.5

func set_meter_value(_value: float):
	progress_bar.value = _value

func tween_meter_value(new_value: float):
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", new_value, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	
	
