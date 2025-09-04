extends Control

class_name MeterBar

@onready var progress_bar: ProgressBar = $PanelContainer/ProgressBar
@export var stress := false
var sb
	
var duration := 1.5
var prevColour := Color.WHITE
var newColour := Color.WHITE

const RED_COLOUR := Color(0xb60002ff)
var LOW := 0
const ORANGE_COLOUR := Color(0xe7a900ff)
var MID := 31
const GREEN_COLOUR := Color(0x42b600ff)
var HIGH := 66
var GOLD_COLOUR := Color(0x00a8fdff) # This is gold, the other is blue Color(0xf1c900ff)

@onready var panel_container: PanelContainer = $PanelContainer
func _ready():
	sb = progress_bar.get_theme_stylebox("fill") as StyleBoxFlat
	if stress:
		var temp = HIGH
		HIGH = LOW
		LOW = temp
		var sbp = panel_container.get_theme_stylebox("panel") as StyleBoxFlat
		sbp.bg_color = Color(0xff4846ff)
	
func _process(delta: float) -> void:
	var newValue = progress_bar.value
	if newValue >= 100:
		newColour = GOLD_COLOUR
	elif newValue >= HIGH:
		newColour = GREEN_COLOUR
	elif newValue >= MID:
		newColour = ORANGE_COLOUR
	else:
		newColour = RED_COLOUR

	if prevColour != newColour:
		var tween = get_tree().create_tween()
		tween.tween_property(sb, "bg_color", newColour, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		prevColour = newColour


func set_meter_value(_value: float):
	progress_bar.value = _value
	if _value >= 100:
		sb.bg_color = GOLD_COLOUR
	elif _value >= HIGH:
		sb.bg_color = GREEN_COLOUR
	elif _value >= MID:
		sb.bg_color = ORANGE_COLOUR
	else:
		sb.bg_color = RED_COLOUR

func tween_meter_value(newValue: float):
	var tween = get_tree().create_tween()
	prevColour = sb.bg_color
	tween.tween_property(progress_bar, "value", newValue, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	#if newColour == GOLD_COLOUR:
		#tween2.tween_property(sb, "bg_color", GREEN_COLOUR, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		#await(tween2.finished)
		#sb.bg_color = GOLD_COLOUR
	#else:
		#tween2.tween_property(sb, "bg_color", newColour, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func get_meter_value():
	return progress_bar.value
	
