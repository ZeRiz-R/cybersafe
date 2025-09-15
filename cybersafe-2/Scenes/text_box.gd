extends CanvasLayer


@onready var textbox_container: MarginContainer = $TextBoxContainer
const CHAR_READ_RATE = 0.03
signal available

# Animated Elements
@onready var outer_panel_container: PanelContainer = $TextBoxContainer/VBoxContainer/OuterPanelContainer
@export var wobble := Vector2(-0.25, -0.04)
var skew = Vector2(-0.625, -0.07)

# Text Elements
@onready var start: Label = $TextBoxContainer/VBoxContainer/OuterPanelContainer/MarginContainer/HBoxContainer/Start
@onready var content: Label = $TextBoxContainer/VBoxContainer/OuterPanelContainer/MarginContainer/HBoxContainer/Content
@onready var end: Label = $TextBoxContainer/VBoxContainer/OuterPanelContainer/MarginContainer/HBoxContainer/End
var text_tween: Tween

@onready var speaker: Label = $TextBoxContainer/VBoxContainer/OuterPanelContainer/NameWrapper/Sender
@onready var avatar: PanelContainer = $TextBoxContainer/VBoxContainer/AvatarWrapper/Avatar
var textQueue = []

enum state {
	READY,
	READING,
	FINISHED
}
var currentState = state.READY

@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready():
	animate_outer()
	await(open_textbox())
	#queue_text("This is the life as they say and dey say!")
	#queue_text("Lucio moment fr fr")
	#queue_text("Is this a dagger which I see before me, the handle before my hand.")
	emit_signal("available")
	pass
	
func _process(_delta: float) -> void:
	match currentState:
		state.READY:
			if not textQueue.is_empty():
				display_text()
		state.READING:
			if Input.is_action_just_pressed("finish_text"):			
				content.visible_ratio = 1.0
				text_tween.stop()
				end.text = " *"
				change_state(state.FINISHED)
		state.FINISHED:
			if Input.is_action_just_pressed("finish_text"):
				change_state(state.READY)
				if (textQueue.is_empty()):
					hide_textbox()
					queue_free()

func open_textbox():
	start.text = ""
	content.text = ""
	end.text = ""
	anim_player.play("slide_in")
	await(anim_player.animation_finished)

func queue_text(nextText: TextBoxEntry):
	textQueue.push_back(nextText)

func queue_array(allText: Array[TextBoxEntry]):
	for line in allText:
		queue_text(line)

func initiailise_tween():
	text_tween = create_tween()
	text_tween.finished.connect(_on_reading_finished)
	
func close_textbox():
	pass # Animate the text box closing
	
func display_text():
	initiailise_tween()
	var nextText = textQueue.pop_front()
	change_state(state.READING)
	content.visible_ratio = 0.0
	
	content.text = nextText.text.format(Constants.placeholders)
	if speaker.text != nextText.speaker:
		if nextText.isPlayerText:
			speaker.text = Player.playerName
			avatar.select_image(Player.playerIcon)
		else:
			speaker.text = nextText.speaker
			avatar.select_image(speaker.text)
		anim_player.play("swap_speaker")
		#await(anim_player.animation_finished)
		pass
		
	show_textbox()
	text_tween.tween_property(content, "visible_ratio", 1.0, len(nextText.text) * CHAR_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

@onready var color_rect: ColorRect = $ColorRect
func hide_overlay():
	color_rect.visible = false

func _on_reading_finished():
	end.text = " *"
	change_state(state.FINISHED)
	
func change_state(nextState: state):
	currentState = nextState

func show_textbox():
	start.text = "* "
	end.text = ""
	textbox_container.show()

func hide_textbox():
	start.text = ""
	content.text = ""
	end.text = ""
	textbox_container.hide()
	
	
func animate_outer():
	var tween = get_tree().create_tween().set_loops()
	var sb: StyleBoxFlat = outer_panel_container.get_theme_stylebox("panel")
	tween.tween_property(sb, "skew", wobble, 0.1)
	tween.tween_property(sb, "skew", skew, 0.1)
