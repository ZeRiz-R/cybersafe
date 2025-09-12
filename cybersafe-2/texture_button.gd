extends TextureButton

var hover_scale: Vector2 = Vector2(1.1, 1.1)
var tween_duration := 0.05

# Buttons

func _ready():
	scale = Vector2(1, 1)
	pivot_offset = Vector2(size.x / 2, size.y / 2)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	if texture_normal:
		# Get the image from the texture normal
		var image = texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap

func _on_mouse_entered():
	z_index = 10
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", hover_scale, tween_duration)
	

func _on_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), tween_duration)
	z_index = 1
	
func _on_pressed():
	match self.name:
		"BackButton":
			SceneTransition.change_scene("res://Scenes/dashboard.tscn", "tiles")
		"DecisionButton":
			decision_button_pressed()
			
func decision_button_pressed():
	print("making a decision")
	var decisionScreen = preload("res://Scenes/make_decision.tscn").instantiate()
	var uiLayer = get_tree().current_scene
	uiLayer.add_child(decisionScreen)
	self.disabled = true
