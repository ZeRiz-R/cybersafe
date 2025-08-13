extends Button

var hover_scale: Vector2 = Vector2(1.05, 1.05)
var tween_duration := 0.05

# Buttons


func _ready():
	scale = Vector2(1, 1)
	pivot_offset = Vector2(size.x / 2, size.y / 2)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered():
	z_index = 10
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", hover_scale, tween_duration)
	

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), tween_duration)
	z_index = 0


func _on_pressed():
	match self.name:
		"EmailButton":
			SceneTransition.change_scene("res://Scenes/email_inbox.tscn", "tiles")
		"MessagesButton":
			SceneTransition.change_scene("res://Scenes/messages_inbox.tscn", "tiles")
		"BackToDashboard":
			SceneTransition.change_scene("res://Scenes/dashboard.tscn", "tiles")
		"TimeButton":
			SceneTransition.change_scene("res://Scenes/dashboard.tscn", "arrow_time")
			Calendar.print_event()
		"DecisionButton":
			decision_button_pressed()
			
func decision_button_pressed():
	print("making a decision")
	var decisionScreen = preload("res://Scenes/make_decision.tscn").instantiate()
	var uiLayer = get_tree().current_scene
	uiLayer.add_child(decisionScreen)
	self.disabled = true
